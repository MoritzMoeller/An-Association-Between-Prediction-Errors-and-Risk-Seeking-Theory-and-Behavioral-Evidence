function plot_learning_curves(dt, nt, model, B)

XLIM = [0,120];

hold on

trial_number_from_zero = dt.trial_cont - 1;
trial_number_from_zero_lower_bin_edge = trial_number_from_zero - mod(trial_number_from_zero, nt);
trial_number_from_zero_bin_centre = trial_number_from_zero_lower_bin_edge + 0.5 * nt;
dt.trial_cont_binned = trial_number_from_zero_bin_centre;

if not(isempty(model))

    lineplot(dt, 'trial_cont_binned', [model,'_p_correct'], '')
    t = [t, ' and ', model];
end


% lineplot_(dt, 'trial_cont_binned', 'correct', '')
plot_functions.lineplot_error_across_pop(dt, 'trial_cont_binned', 'correct', '', B)
plot(XLIM, 0.5 * [1,1], 'k')

%ylim([-0.15,1.15])
ylim([0,1])
xlim(XLIM)

yticks([0,0.5,1])

xlabel('trial #')
ylabel('p(correct)')

end