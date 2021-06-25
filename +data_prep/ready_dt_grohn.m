function dt = ready_dt_grohn(dt, PLOT)
%
% NOTE: at the end are some plots to show that recoding is correct
%

%% add forced flag and new_block flag

dt.new_block = [1;diff(dt.block)];

%% recode trial type

% 1: forced choice
% 2: decision trials (equal mean)
% 3: catch trials (different mean)

dt.TrialType_num = 3*ones(size(dt.typeOfChoice));
dt.TrialType_num(any(dt.typeOfChoice == [1,6],2)) = 2;

dt.forced = zeros(height(dt),1);

%% recode choice

dt.choices = double(dt.stim_chosen == dt.stim1);

%% code gain/loss

dt.win = nan(size(dt.TrialType_num));

ndx = dt.TrialType_num == 2 & any(dt.stim1 == [1,2], 2);
dt.win(ndx) = 1;

ndx = dt.TrialType_num == 2 & any(dt.stim1 == [3,4], 2);
dt.win(ndx) = -1;

%% code correct

dt.correct = nan(size(dt.TrialType_num));

ndx = dt.TrialType_num == 3; % select catch trials
dt.correct(ndx) = 0;

ndx = dt.TrialType_num == 3 & any(dt.stim_chosen == [1,2], 2); % select catch trials with correct responses
dt.correct(ndx) = 1;

%% code risky

dt.risky = nan(size(dt.TrialType_num));

ndx = dt.TrialType_num == 2; % select catch trials
dt.risky(ndx) = 0;

ndx = dt.TrialType_num == 2 & any(dt.stim_chosen == [1,3], 2); % select catch trials with risky responses
dt.risky(ndx) = 1;

%% check performance and remove non-learners

tresh = 0.65;

x = 'ID';
y = 'correct';

xd = table2array(dt(:,x));
yd = table2array(dt(:,y));

[~, ~, idx] = histcounts(xd);

ndx = not(idx == 0);
xp = accumarray(idx(ndx), xd(ndx), [], @(x) nanmean(x));
yp = accumarray(idx(ndx), yd(ndx), [], @(x) nanmean(x));

ex = xp(yp < tresh)';
dt(any(dt.ID == ex, 2),:) = [];

us = unique(dt.ID);

for ID = 1:length(us)
    ndx = dt.ID == us(ID);
    dt.ID(ndx) = ID;
end

%% rename trial
dt.trial = dt.trialIndex;
dt.trialIndex = [];
dt.trial_cont = dt.trial;

%% add stayed

typeOfChoice = dt.typeOfChoice;
ID = dt.ID;
block = dt.block;
trial = dt.trial;
stim_chosen = dt.stim_chosen;

stim_stay = nan(size(stim_chosen));

for s = unique(dt.ID)'
    for b = 1:4
        for t = 1:120
            
            ndx1 = block == b & trial == t & ID == s;
            toc = typeOfChoice(ndx1);
            c = stim_chosen(ndx1);

            if not(isempty(c))
                
                ndx = block == b & trial <= t & ID == s & typeOfChoice == toc;
                prev = find(ndx);
                
                if stim_chosen(prev(end)) == c
                    try
                        stim_stay(ndx1) = stim_chosen(prev(end-1));
                    end
                end
            end
        end
    end
end

dt.stim_stay = stim_stay;

%% plot 

if PLOT
    %% performance
    
    figure
    hold on
    cm = brewermap(10, 'Blues');
    c = cm(5, :);
    
    GREY = [1,1,1]*0.8;
    
    performance = sort(yp);
    
    bar(1:3, performance(1:3), "FaceColor", GREY)
    bar(4:length(performance), performance(4:end), "FaceColor", c)
    
    grid off
    ylim([0,1])
    
    yticks([0, 0.5 tresh, 1])
    yticklabels({'0','chance level: 50', sprintf('threshold: %G', tresh*100), '100'})
    
    xticks(1:30)
    xticklabels({})
    
    xlabel('Participants')
    ylabel('Proportion of correct choices')
    
    set(gca, 'FontSize', 15, 'FontName', 'Arial')
    set(gcf, 'Position', [526 367 588 391])
    
end

end