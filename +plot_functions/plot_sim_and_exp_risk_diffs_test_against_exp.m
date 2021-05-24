function plot_sim_and_exp_risk_diffs_test_against_exp(EXPERIMENT, MODELS)

diffs = struct();
diffs.sim_diffs = helper_functions.compute_sim_risk_diffs(MODELS, EXPERIMENT);
diffs.exp_diffs = helper_functions.compute_exp_risk_diffs(EXPERIMENT);

cm = brewermap(10, 'Blues');
BLUE = cm(5, :);
GREY = [1,1,1]*0.8;

N = length(MODELS);

labels = labels_from_models(MODELS);

% get data from experiment
x_exp = N+1;
y_exp = mean(diffs.exp_diffs{1});
e_exp = std(diffs.exp_diffs{1})/sqrt(length(diffs.exp_diffs{1}));

n = length(diffs.sim_diffs);

% get data from sim
x_sim = 1:N;
y_sim = [];
e_sim = [];
ps = [];

fprintf('\n\n#########\n\n')
for i = 1:n
    average_over_experiments = mean(diffs.sim_diffs{i});
    population_mean = mean(average_over_experiments);
    population_SE = std(average_over_experiments)/sqrt(length(average_over_experiments));
    y_sim = [y_sim, population_mean];
    e_sim = [e_sim, population_SE];
    
    % test whether sim is different to experiment
    [h,p,~,STATS] = ttest(average_over_experiments - diffs.exp_diffs{1});
    ps = [ps, p];
    if h
        fprintf('==> ')
    end
    fprintf("%s: t(%G)=%1.3G, p=%1.3G\n", labels{i}, STATS.df, STATS.tstat, p)
end


[y_sim_ranked, idx] = sort(y_sim);
e_sim_ranked = e_sim(idx);
models_ranked = MODELS(idx);
ps_ranked = ps(idx);


% plot
hold on
plot_functions.bar_with_errors(x_sim, y_sim_ranked, e_sim_ranked, BLUE)
plot_functions.bar_with_errors(x_exp, y_exp, e_exp, GREY)

% put stats in there
for i = 1:n
    
    y_bar = y_exp + e_exp + (n-i+1) * 0.02;
    
    % plot bracket
    plot([x_sim(i), x_exp], [1, 1] * y_bar, 'LineWidth', 1, 'Color', 'k')
    plot([x_sim(i), x_sim(i)], [1, 0.99] * y_bar, 'LineWidth', 1, 'Color', 'k')
    plot([x_exp, x_exp], [1, 0.99] * y_bar, 'LineWidth', 1, 'Color', 'k')

    if ps_ranked(i) > 0.05
        text(0.5 * (x_sim(i) + x_exp), y_bar + 0.01, p2star(ps_ranked(i)),...
            "HorizontalAlignment", "center", "FontSize", 15)
    else
        text(0.5 * (x_sim(i) + x_exp), y_bar + 0.003, p2star(ps_ranked(i)),...
            "HorizontalAlignment", "center", "FontSize", 15)
    end
end

%plot([0,length(models)+1], mean_diff_exp * [1, 1], "LineWidth", 1, "Color", 'k')
%text(0.5, mean_diff_exp + 0.006, "Experiment", 'FontName', 'Arial', 'FontSize', 15)

labels = labels_from_models(models_ranked);
labels{end+1} = "Experiment";

xticks(1:(length(MODELS)+1))
xticklabels(labels)
xtickangle(45)

ylabel("P(risky|high) - P(risky|low)")

ylim([-0.05, 0.32])

set(gca, "FontName", "Arial", "FontSize", 15)
end