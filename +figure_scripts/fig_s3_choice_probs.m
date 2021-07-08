function fig_s3_choice_probs()

dt = data_prep.load_data('plosCB2021');

cm = brewermap(10, 'Blues');
BLUE = cm(5, :);
SAVE = 1;

%% get data per participant (different conditions)

p_win = nan(27, 4);
cs = 2:5;

for s = 1:27
    for i = 1:length(cs)
        
        ndx = dt.ID == s & dt.typeOfChoice == cs(i);
        
        p_win(s,i) = mean(dt.highChosen(ndx));
        
    end
end

%% bar chart with SE

x = 1:4;
y = mean(p_win);
e = std(p_win)/sqrt(length(p_win));

figure
plot_functions.bar_with_errors(x,y,e, BLUE)

x_scatter = ones(length(p_win),1)*x;
scatter(x_scatter(:) + 0.2*(rand(size(x_scatter(:))) - 0.5), p_win(:), 30, 'k','filled',...
    'MarkerFaceAlpha', 0.1, 'MarkerEdgeAlpha', 0.7)

xticks(1:4)
xticklabels({'RL-RH', 'SL-RH', 'RL-SH', 'SL-SH'})
xtickangle(45)

ylabel("P(high)")
ylim([0.5,1])

set(gca, "FontName", "Arial", "FontSize", 15)

%% save fig

set(gcf, 'Position', [560 528 560 420])
if SAVE
    set(gcf, 'Color', 'none');
    export_fig 'figures/fig_s3_choice_probs/choice_probs_mixed.png' -m4
end

end