

SAVE = 1;
EXPERIMENT = 'grohn';
MODELS = get_all_models();

lls = plot_simulated_risk_preferences_contour(MODELS, EXPERIMENT);
plot_likelihood_ratios(lls, MODELS)
%set(gcf, "Position", [71 665 1541 283])
if SAVE
    set(gcf, 'Color', 'none');
    export_fig '/Users/moritzmoeller/Dropbox/PEIRS/Fig S3 - llr/components/log_likelihood_ratios.png' -m4
end