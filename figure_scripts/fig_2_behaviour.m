

SAVE = 1;
STATS = 0; % test whether risk preferences emerge slower than value preferences
DATASET = 'grohn';

%% 2-d risk plane

plot_functions.plot_preferences_corr(DATASET, SAVE)

%% prefs over trials

plot_functions.plot_prefs_over_trials(DATASET, SAVE, STATS)

