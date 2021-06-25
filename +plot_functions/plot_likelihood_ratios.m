function plot_likelihood_ratios(lls, models)

figure
cm = brewermap(10, 'Blues');
c = cm(5, :);
bar(1:length(models), lls - max(lls), 'FaceColor', c)

labels = labels_from_models(models);

xticks(1:length(models))
xticklabels(labels)
xtickangle(45)

ylabel({'log likelihood ratio relative to PEIRS'})

box off
set(gca, 'FontSize', 15, 'FontName', 'Arial')

end