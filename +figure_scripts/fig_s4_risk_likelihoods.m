function fig_s4_risk_likelihoods()

SAVE = 1;
PLOT = 0;
EXPERIMENT = 'grohn';
MODELS = helper_functions.get_all_models();

lls = plot_functions.plot_simulated_risk_preferences_contour(MODELS, EXPERIMENT, PLOT);
[~, i] = sort(lls);
plot_functions.plot_likelihood_ratios(lls(i), MODELS(i))
%set(gcf, "Position", [71 665 1541 283])
if SAVE
    set(gcf, 'Color', 'none');
    export_fig 'figures/fig_s4_risk_likelihoods/log_likelihood_ratios.png' -m4
end

end