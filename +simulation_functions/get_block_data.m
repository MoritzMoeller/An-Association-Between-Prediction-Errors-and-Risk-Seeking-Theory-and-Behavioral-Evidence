function block_data = get_block_data()

% define constants
mean1 = 60;
mean2 = 40; 
std1 = 20;
std2 = 7;

% generate rewards
r1 = round(norminv(linspace(.05,.95,60), mean1, std1));
r2 = round(norminv(linspace(.05,.95,60), mean1, std2));
r3 = round(norminv(linspace(.05,.95,60), mean2, std1));
r4 = round(norminv(linspace(.05,.95,60), mean2, std2));

r = cell(4,1);
r{1} = Shuffle(r1);r{2} = Shuffle(r2);r{3} = Shuffle(r3);r{4} = Shuffle(r4);

stimuli_occuring = [12 13 14 21 23 24 31 32 34 41 42 43];
stimuliShown = Shuffle(repmat(stimuli_occuring,1,10))';
stim1 = floor(stimuliShown/10);
stim2 = stimuliShown - floor(stimuliShown/10)*10;

% package data
block_data = struct();
block_data.r = r;
block_data.stim1 = stim1;
block_data.stim2 = stim2;
block_data.stimuliShown = stimuliShown;

end