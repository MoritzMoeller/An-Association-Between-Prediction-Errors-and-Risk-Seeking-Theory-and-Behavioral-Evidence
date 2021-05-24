function plot_simulated_risk_preferences_contour_colorbar(models, experiment)

labels = helper_functions.labels_from_models(models);
exp_risk_prefs = helper_functions.get_risk_prefs(data_prep.load_data(experiment));

color_scatter = 'k';
figure
hold on

D = load(['risk_prefs/risk_prefs_sim_',models{1},'_exp_',experiment,'.mat']);
sim_risk_prefs = D.sim_risk_preferences;

model_risk_prefs = [];
for i = 1:size(sim_risk_prefs, 2)
    model_risk_prefs = [model_risk_prefs; sim_risk_prefs{i}.p_risky_win, sim_risk_prefs{i}.p_risky_loose];
end

gridx = linspace(0,1,100);
[x1,x2] = meshgrid(gridx, gridx);
xi = [x1(:) x2(:)];

pdf = ksdensity(model_risk_prefs, xi, 'Bandwidth',[0.0275, 0.0275]);
pdf = pdf/max(pdf);

levels = linspace(0,1,12);
levels = levels(2:end-1);

contourf(gridx, gridx, reshape(pdf, 100, 100), levels, "LineStyle", "none")

colormap([1,1,1; brewermap(1000, 'Blues')])

c = colorbar("FontName", "Arial", 'FontSize', 15);
c.Label.String = 'normalised density';

plot([0 1],[0 1],'k')

axis equal; axis([0.1 0.9 0.1 0.9]);
xticks([0.1,0.9])
yticks([0.1,0.9])
title({labels{1}})

scatter(exp_risk_prefs.p_risky_win, exp_risk_prefs.p_risky_loose, 20, color_scatter, 'filled', 'MarkerFaceAlpha', 0.2)

set(gca, 'FontName', 'Arial', 'FontSize', 15)

end