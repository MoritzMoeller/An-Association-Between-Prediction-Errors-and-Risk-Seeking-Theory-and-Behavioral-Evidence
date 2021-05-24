function plot_fig_risk_prefereces(MODELS,LEGEND)

LABELS = helper_functions.labels_from_models(MODELS);

figure
dt = data_prep.load_data('grohn');
bin_width = 25; % 10 looks decent;

cm = brewermap(10, 'Blues');
c1 = cm(3, :);
c2 = cm(7, :);


GREY1 = [1,1,1]*0.8;
GREY2 = [1,1,1]*0.2;

for m = 1:length(MODELS)
    
    D = load(['risk_prefs_per_trial/risk_prefs_per_trial_sim_',MODELS{m},'_exp_grohn.mat']);
    sim_risk_preferences_per_trial = D.sim_risk_preferences_per_trial;
    
    subplot(1,length(MODELS),m)
    plot_functions.plot_risk_curves_trial_per_condition(dt, [], bin_width, "high", GREY1)
    plot_functions.plot_risk_curves_trial_per_condition(dt, [], bin_width, "low", GREY2)
    plot_functions.plot_simulated_learning_curves(sim_risk_preferences_per_trial, c1, c2)
    
    set(gca, "FontName", "Arial", 'FontSize', 15)
    axis square
    
    if m == 1
        ylabel("P(risky)")
        xlabel("trial number")
        yticks([0.4, 0.6])
    else
        set(gca, "XLabel", [])
        set(gca, "YLabel", [])
        yticks([])
    end
    
    title(LABELS{m})

end

if LEGEND
    subplot(1,length(MODELS),length(MODELS))
    legend('Exp. BH','Exp. BL','Sim. BH','Sim. BL')
end
end