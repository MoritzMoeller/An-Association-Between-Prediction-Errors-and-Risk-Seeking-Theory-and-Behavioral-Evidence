function plot_pupil_out_PE_hierarchical(data_table, SAVE)

INTERP = 1;
t_start = 1;
t_stop = 120;
nt = 20;

subjects = unique(data_table.ID)';
subjects(9) = []; % Subject 9 has bad pupil mesasurements

cm = brewermap(10, 'Blues');
color = cm(5, :);

[~, ~, y, e] = helper_functions.compute_regression_traces_out_PE_hierarchical(...
    data_table, t_start, t_stop, nt, subjects);

figure
plot_functions.plot_regression_traces_bin_hierarchical(...
    y, e, INTERP, nt, 'Outcome prediction error', 'Reward presentation', color)
set(gcf, "Position", [560 664 314 284])
if SAVE
    set(gcf, 'Color', 'none')
    export_fig 'figures/fig_s1_pupils/out_PE_pupil_trace_bin_test.png' -m4
end

end

