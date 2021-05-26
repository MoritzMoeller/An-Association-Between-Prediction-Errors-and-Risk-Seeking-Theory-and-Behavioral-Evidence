function [beta, tstat, y, e] = compute_regression_traces_out_PE_hierarchical(...
    dt, ...
    trial_start, ...
    trial_stop, ...
    nt, ...
    subjects)


n_subs = length(subjects);

%% filter

% by trial number
ndx_trial = dt.trial >= trial_start & dt.trial <= trial_stop;
dt = dt(ndx_trial, :);

%% define model

model = 'pub ~ 1 + PEIRS_abs_PE_o + (1 + PEIRS_abs_PE_o|ID)';

%% fit model to population

% data structures for results
beta = nan(30, nt);
tstat = nan(30, nt);

y = nan(nt, 1);
e = nan(nt, 1);

%T = table();

index_PE_s = 2;

for t = 1:nt
    
    dt.pub = dt.pupil_reward(:,t);
    
    fit = fitlme(dt, model);
    
    [BETA,BETANAMES,BETASTATS] = fixedEffects(fit);
    [B,BNAMES] = randomEffects(fit);
    
    name = BETANAMES.Name(index_PE_s);
    if not(strcmp(name{1}, 'PEIRS_abs_PE_o'))
        disp('Looking at the wrong regressor!')
        return
    end
    
    beta(:,t) = BETA(index_PE_s);
    y(t, 1) = BETA(index_PE_s);
    e(t, 1) = BETASTATS.SE(index_PE_s);
    
    for i = 1:n_subs
        
        index_B = 2*i;
        if strcmp(BNAMES.Name{index_B}, 'PEIRS_abs_PE_o')
            beta(subjects(i),t) = beta(subjects(i),t) + B(index_B);
        else
            disp('Looking at the wrong regressor!')
            return
        end
        
    end
end
end