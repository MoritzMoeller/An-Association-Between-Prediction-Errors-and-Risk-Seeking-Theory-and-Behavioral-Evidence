function plot_prefs_over_trials(DATASET, SAVE, STATS)

BW = 0;

if BW
    c = 'k';
else
    cm = brewermap(10, 'Blues');
    c = cm(5, :);
end

dt = data_prep.load_data(DATASET);

figure

subplot(1,3,1)
bin_width = 25; % 10 looks decent;
plot_functions.plot_learning_curves(dt, bin_width, [], c)
set(gca, "FontName", "Arial", 'FontSize', 15)
ylabel("P(high|different)")
xlabel("trial number")

p = helper_functions.test_significance_preferences(dt, "P(high)");
text(60, 0.52, p2star(p), 'FontSize', 30, 'FontName', 'Arial', 'HorizontalAlignment','center')


subplot(1,3,2)
bin_width = 25; % 10 looks decent;
plot_functions.plot_risk_curves_trial_per_condition(dt, [], bin_width, "high", c)
set(gca, "FontName", "Arial", 'FontSize', 15)
ylabel("P(risky|both-high)")
xlabel("trial number")

p = helper_functions.test_significance_preferences(dt, "P(risky|both-high)");
text(60, 0.506, p2star(p), 'FontSize', 30, 'FontName', 'Arial', 'HorizontalAlignment','center')

subplot(1,3,3)
bin_width = 25; % 10 looks decent;
plot_functions.plot_risk_curves_trial_per_condition(dt, [], bin_width, "low", c)
set(gca, "FontName", "Arial", 'FontSize', 15)
ylabel("P(risky|both-low)")
xlabel("trial number")

p = helper_functions.test_significance_preferences(dt, "P(risky|both-low)");
text(60, 0.485, p2star(p), 'FontSize', 30, 'FontName', 'Arial', 'HorizontalAlignment','center')

set(gcf, 'Position', [560 555 602 393])

% stats for comparing the learning curves

dt.assymptotes = nan(height(dt),1);
dt.assymptotes(any(dt.typeOfChoice == [2,3,4,5],2)) = dt.highChosen(any(dt.typeOfChoice == [2,3,4,5],2));
dt.assymptotes(dt.typeOfChoice == 1) = dt.riskChosen(dt.typeOfChoice == 1);
dt.assymptotes(dt.typeOfChoice == 6) = (1-dt.riskChosen(dt.typeOfChoice == 6));

dt.contrast = 2 * any(dt.typeOfChoice == [2,3,4,5],2) - 1;

%% statistical analysis

if STATS
    
    mdl_1 = fitlme(dt, 'assymptotes ~ trial*contrast + (trial*contrast|ID) ');
    mdl_0 = fitlme(dt, 'assymptotes ~ trial + contrast + (trial*contrast|ID) ');
    
    opt = statset('LinearMixedModel');
    opt.UseParallel = true;
    compare(mdl_0, mdl_1,'NSim',10, 'Options',opt)
end
%%

if SAVE
    set(gcf, 'Color', 'none')
    export_fig 'figures/fig_2_behaviour/learning_curves.png' -m4
end

end