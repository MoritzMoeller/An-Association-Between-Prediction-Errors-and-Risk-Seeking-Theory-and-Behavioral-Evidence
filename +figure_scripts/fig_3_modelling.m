function fig_3_modelling()

SAVE = 1;
EXPERIMENT = 'plosCB2021';

% simulations 
MODELS_SIM = {...
    'RW',...
    's_shaped_UTIL', ...
    'pos_neg_RATES',...
    'PEIRS',...
    };

% overall model comparison
MODELS_COMP = helper_functions.get_all_models();

%% SIM bar chart

figure
plot_functions.plot_sim_and_exp_risk_diffs_test_against_exp(EXPERIMENT, MODELS_SIM)

set(gcf, 'Position', [199 181 333 477])
if SAVE
    set(gcf, 'Color', 'none');
    export_fig 'figures/fig_3_modelling/sim_and_exp_risk_stats_mean_SE.png' -m4
end

%% SIM 2d contour

PLOT = 1;
plot_functions.plot_simulated_risk_preferences_contour(MODELS_SIM, EXPERIMENT, PLOT);
set(gcf, "Position", [71 757 777 191])
if SAVE
    set(gcf, 'Color', 'none');
    export_fig 'figures/fig_3_modelling/sim_risk_preference_dist.png' -m4
end

%% SIM colorbar

plot_functions.plot_simulated_risk_preferences_contour_colorbar(MODELS_SIM, EXPERIMENT)
set(gcf, "Position", [904 730 258 163])
if SAVE
    set(gcf, 'Color', 'none');
    export_fig 'figures/fig_3_modelling/sim_risk_preference_dist_colorbar.png' -m4
end

%% SIM trial-by-trial risk preference

plot_functions.plot_fig_risk_prefereces(MODELS_SIM,0)
set(gcf, "Position", [175 562 717 194])
if SAVE
    set(gcf, 'Color', 'none');
    export_fig 'figures/fig_3_modelling/risk_pref_sim.png' -m4
end

%% SIM trial-by-trial risk preference LEGEND

plot_functions.plot_fig_risk_prefereces(MODELS_SIM,1)
set(gcf, "Position", [175 562 717 194])
if SAVE
    set(gcf, 'Color', 'none');
    export_fig 'figures/fig_3_modelling/risk_pref_sim_legend.png' -m4
end

%% COMP direct model comparison

plot_functions.plot_BIC_bar_direct(EXPERIMENT, MODELS_COMP)
set(gcf, "Position", [560 392 408 556])
if SAVE
    set(gcf, 'Color', 'none');
    export_fig 'figures/fig_3_modelling/direct_comp.png' -m4
end
end