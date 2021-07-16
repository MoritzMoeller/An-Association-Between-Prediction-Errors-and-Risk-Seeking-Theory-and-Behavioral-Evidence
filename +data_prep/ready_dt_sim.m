function dt = ready_dt_sim(dt)

% prep
dt.forced = zeros(size(dt.block));
dt.new_block = [1;diff(dt.block)];
dt.new_block(dt.new_block == -3) = 1;

%% add trial

trial_cont = nan(size(dt.reward));

for i = 1:height(dt)
    if dt.new_block(i) == 1
        t = 1;
    else
        t = t + 1;
    end
    trial_cont(i) = t;
    
end

dt.trial_cont = trial_cont;

%% add type of choice

stims  = [dt.stim1, dt.stim2];

stims_sorted = max(stims,[],2) + min(stims,[],2)*10;

typeOfChoice = nan(size(dt.stim1));

for i = 1:height(dt)
    
    switch stims_sorted(i)
        case 12
            typeOfChoice(i) = 1;
        case 13
            typeOfChoice(i) = 2;
        case 14
            typeOfChoice(i) = 3;
        case 23
            typeOfChoice(i) = 4;
        case 24
            typeOfChoice(i) = 5;
        case 34
            typeOfChoice(i) = 6;
    end
end

dt.typeOfChoice = typeOfChoice;

%% add correct

dt.correct = nan(size(dt.typeOfChoice));

ndx = any(dt.typeOfChoice == [2,3,4,5],2);

dt.correct(ndx) = any(dt.stim_chosen(ndx) == [1,2],2);

%% add risky

dt.risky = nan(size(dt.typeOfChoice));
ndx = any(dt.typeOfChoice == [1,6],2);
dt.risky(ndx) = any(dt.stim_chosen(ndx) == [1,3],2);

%% add win
dt.win = nan(size(dt.stim1));
dt.win(dt.typeOfChoice == 1) = 1;
dt.win(dt.typeOfChoice == 6) = -1;

%% add risk Chosen
dt.riskChosen = nan(size(dt.typeOfChoice));

dt.riskChosen(dt.typeOfChoice == 1 & dt.stim_chosen == 1) = 1;
dt.riskChosen(dt.typeOfChoice == 1 & dt.stim_chosen == 2) = 0;
dt.riskChosen(dt.typeOfChoice == 6 & dt.stim_chosen == 3) = 1;
dt.riskChosen(dt.typeOfChoice == 6 & dt.stim_chosen == 4) = 0;

end

