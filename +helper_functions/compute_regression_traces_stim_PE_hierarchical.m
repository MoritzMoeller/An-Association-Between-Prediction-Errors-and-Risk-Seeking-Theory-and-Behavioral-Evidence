function [beta, tstat, y, e] = compute_regression_traces_stim_PE_hierarchical(...
    dt, ...
    STOP_AT_REWARD, ...
    STOP_AT_CHOICE, ...
    trial_start, ...
    trial_stop, ...
    nt, ...
    subjects)


n_subs = length(subjects);

%% filter

% by trial number
ndx_trial = dt.trial >= trial_start & dt.trial <= trial_stop;
dt = dt(ndx_trial, :);

%% build control regressors

% build image_chosen regressor
dt.image_chosen = dt.choices.*dt.image1 + (1 - dt.choices).*dt.image2;
dt.image_chosen_cat = categorical(dt.image_chosen);

% build image_unchosen regressor
dt.image_unchosen = dt.choices.*dt.image2 + (1 - dt.choices).*dt.image1;
dt.image_unchosen_cat = categorical(dt.image_unchosen);

% build choice-ordered image regressor
dt.choice_image = dt.image_chosen + 100*(dt.image_unchosen);
dt.choice_image_cat = categorical(dt.choice_image);

%% define model

model = 'pub ~ 1 + PEIRS_abs_PE_s + choice_image_cat + (1 + PEIRS_abs_PE_s|ID)';

%% fit model to population

% data structures for results
beta = nan(30, nt);

tstat = nan(nt, 1);
y = nan(nt, 1);
e = nan(nt, 1);

index_PE_s = 2;

for t = 1:nt
    
    dt.pub = dt.pupil_stimuli_noNaNs(:,t);
    
    if STOP_AT_REWARD
        dt.pub(dt.rt*10 + 10 < t) = nan; % NOTE: after choice, there is 1s of delay before reward is displayed.
    end
    if STOP_AT_CHOICE
        dt.pub(dt.rt*10 < t) = nan; % NOTE: after choice, there is 1s of delay before reward is displayed.
    end
    
    fit = fitlme(dt, model);
    
    [BETA,BETANAMES,BETASTATS] = fixedEffects(fit);
    [B,BNAMES] = randomEffects(fit);
    
    name = BETANAMES.Name(index_PE_s);
    if not(strcmp(name{1}, 'PEIRS_abs_PE_s'))
        disp('Looking at the wrong regressor!')
        return
    end
    
    beta(:,t) = BETA(index_PE_s);
    y(t, 1) = BETA(index_PE_s);
    e(t, 1) = BETASTATS.SE(index_PE_s);
    tstat(t, 1) = BETASTATS.tStat(index_PE_s);

end
end