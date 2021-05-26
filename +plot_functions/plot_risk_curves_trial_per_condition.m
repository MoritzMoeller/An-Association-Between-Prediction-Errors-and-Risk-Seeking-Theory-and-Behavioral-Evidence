function plot_risk_curves_trial_per_condition(dt, model, nt, condition, color)

switch condition
    case "high"
        win_code = 1;
    case "low"
        win_code = -1;
    otherwise
        disp("Condition must be either 'high' or 'low'!")
end

XLIM = [0,120];

hold on

trial_number_from_zero = dt.trial_cont - 1;
trial_number_from_zero_lower_bin_edge = trial_number_from_zero - mod(trial_number_from_zero, nt);
trial_number_from_zero_bin_centre = trial_number_from_zero_lower_bin_edge + 0.5 * nt;
dt.trial_cont_binned = trial_number_from_zero_bin_centre;

if not(isempty(model))

    lineplot(dt(t.win == win_code,:), 'trial_cont_binned', [model,'_p_risky'])
    t = [t, ' and ', model];

end

plot_functions.lineplot_error_across_pop(dt(dt.win == win_code,:), 'trial_cont_binned', 'risky', [], color)

h = plot(XLIM, 0.5 * [1,1], 'k');
set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');

xlabel('trial_cont')
ylabel('p_{risky}')

xlim(XLIM)
ylim([0.35, 0.65])

end