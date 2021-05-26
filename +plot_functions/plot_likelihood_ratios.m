function plot_likelihood_ratios(lls, models)

figure
cm = brewermap(10, 'Blues');
c = cm(5, :);
bar(1:length(models), lls - max(lls), 'FaceColor', c)

xticks(1:length(models))
xticklabels(models)
xtickangle(45)

ylabel({'log likelihood ratio relative to PEIRS', 'log(data|model) - log(data|PEIRS)'})

set(gca, 'FontSize', 15, 'FontName', 'Arial')

end