function plot_pupil_stim_PE_hierarchical(data_table, SAVE)

INTERP = 1;
STOP_AT_REWARD = 1;
STOP_AT_CHOICE = 0;
trial_start = 1;
trial_stop = 120;
nt = 20;

subjects = unique(data_table.ID)';
subjects(9) = []; % Subject 9 has bad pupil mesasurements

cm = brewermap(10, 'Blues');
color = cm(5, :);

[~, ~, y, e] = helper_functions.compute_regression_traces_stim_PE_hierarchical(...
    data_table,...
    STOP_AT_REWARD,...
    STOP_AT_CHOICE,...
    trial_start, ...
    trial_stop, ...
    nt, ...
    subjects);

%% plot the traces

figure
plot_functions.plot_regression_traces_bin_hierarchical(y, e, INTERP, nt, ...
    'Stimulus prediction error', 'Stimulus presentation', color)
set(gcf, "Position", [560 664 314 284])
if SAVE
    set(gcf, 'Color', 'none')
    export_fig 'figures/fig_s1_pupils/stim_PE_pupil_trace_bin_test.png' -m4
end

end
