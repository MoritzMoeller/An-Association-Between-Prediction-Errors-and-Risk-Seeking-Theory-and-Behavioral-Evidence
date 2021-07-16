function fig_s5_additional_sims()

SAVE = 1;
EXPERIMENT = 'plosCB2021';

% simulations 
MODELS_SIM = {...
    'concave_UTIL',...
    'convex_UTIL',...
    'inverse_s_shaped_UTIL', ...
    'variance_RATES',...
    'scaled_PE',...
    'attention_RATES',...
    'PIRS',...
    'OEIRS',...
    };

%% SIM bar chart

figure
plot_functions.plot_sim_and_exp_risk_diffs_test_against_exp(EXPERIMENT, MODELS_SIM)

set(gcf, 'Position', [199 181 333 477])
if SAVE
    set(gcf, 'Color', 'none');
    export_fig 'figures/fig_s5_additional_sims/sim_and_exp_risk_stats_mean_SE.png' -m4
end

%% SIM 2d contour

plot_functions.plot_simulated_risk_preferences_contour(MODELS_SIM, EXPERIMENT, 1);
set(gcf, "Position", [32 757 1649 191])
if SAVE
    set(gcf, 'Color', 'none');
    export_fig 'figures/fig_s5_additional_sims/sim_risk_preference_dist.png' -m4
end

%% SIM colorbar

plot_functions.plot_simulated_risk_preferences_contour_colorbar(MODELS_SIM, EXPERIMENT)
set(gcf, "Position", [904 730 258 163])
if SAVE
    set(gcf, 'Color', 'none');
    export_fig 'figures/fig_s5_additional_sims/sim_risk_preference_dist_colorbar.png' -m4
end

%% SIM trial-by-trial risk preference

plot_functions.plot_fig_risk_prefereces(MODELS_SIM, 0)
set(gcf, "Position", [32 757 1649 191])
if SAVE
    set(gcf, 'Color', 'none');
    export_fig 'figures/fig_s5_additional_sims/risk_pref_sim.png' -m4
end

%%% SIM trial-by-trial risk preference LEGEND

plot_functions.plot_fig_risk_prefereces(MODELS_SIM, 1)
set(gcf, "Position", [32 757 1649 191])
if SAVE
    set(gcf, 'Color', 'none');
    export_fig 'figures/fig_s5_additional_sims/risk_pref_sim_legend.png' -m4
end
end