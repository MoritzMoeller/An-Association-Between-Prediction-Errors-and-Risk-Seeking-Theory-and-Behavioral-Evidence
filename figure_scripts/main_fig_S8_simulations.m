SAVE = 1;
EXPERIMENT = 'grohn';

% simulations 
MODELS_SIM = {...
    'EU_hard_concave_grohn',...
    'EU_hard_convex_grohn',...
    'PU_inv_hard_grohn', ...
    'VAR',...
    'SCALED',...
    'ATTENTION',...
    'PIRS',...
    'OEIRS',...
    };

%% SIM bar chart

diffs = struct();
diffs.sim_diffs = compute_sim_risk_diffs(MODELS_SIM, EXPERIMENT);
diffs.exp_diffs = compute_exp_risk_diffs(EXPERIMENT);

figure
% plot_sim_and_exp_risk_diffs(diffs, MODELS_DIFF, LABELS_DIFF)
plot_sim_and_exp_risk_diffs_test_against_exp(diffs, MODELS_SIM)

set(gcf, 'Position', [199 181 333 477])
if SAVE
    set(gcf, 'Color', 'none');
    export_fig '/Users/moritzmoeller/Dropbox/PEIRS/Fig S8 - simulations/components/sim_and_exp_risk_stats_mean_SE.png' -m4
end

%% SIM 2d contour

lls = plot_simulated_risk_preferences_contour(MODELS_SIM, EXPERIMENT);
set(gcf, "Position", [32 757 1649 191])
if SAVE
    set(gcf, 'Color', 'none');
    export_fig '/Users/moritzmoeller/Dropbox/PEIRS/Fig S8 - simulations/components/sim_risk_preference_dist.png' -m4
end

%% SIM colorbar

plot_simulated_risk_preferences_contour_colorbar(MODELS_SIM, EXPERIMENT)
set(gcf, "Position", [904 730 258 163])
if SAVE
    set(gcf, 'Color', 'none');
    export_fig '/Users/moritzmoeller/Dropbox/PEIRS/Fig S8 - simulations/components/sim_risk_preference_dist_colorbar.png' -m4
end

%% SIM trial-by-trial risk preference

plot_fig_risk_prefereces(MODELS_SIM, 0)
set(gcf, "Position", [32 757 1649 191])
if SAVE
    set(gcf, 'Color', 'none');
    export_fig '/Users/moritzmoeller/Dropbox/PEIRS/Fig S8 - simulations/components/risk_pref_sim.png' -m4
end

%%% SIM trial-by-trial risk preference LEGEND

plot_fig_risk_prefereces(MODELS_SIM, 1)
set(gcf, "Position", [32 757 1649 191])
if SAVE
    set(gcf, 'Color', 'none');
    export_fig '/Users/moritzmoeller/Dropbox/PEIRS/Fig S8 - simulations/components/risk_pref_sim_legend.png' -m4
end
