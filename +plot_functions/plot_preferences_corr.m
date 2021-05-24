function plot_preferences_corr(DATASET, SAVE)

data_table = data_prep.load_data(DATASET);

subs = [1:2,4:11,13:22,24:30];
p1 = [];
p6 = [];
for s = subs
    
    ndx = data_table.typeOfChoice == 1 & data_table.trial < 121 & data_table.ID == s;
    p1 = [p1, sum(data_table.stim_chosen(ndx) == 1)/sum(ndx)];
    ndx = data_table.typeOfChoice == 6 & data_table.trial < 121 & data_table.ID == s;
    p6 = [p6, sum(data_table.stim_chosen(ndx) == 3)/sum(ndx)];
end

% statistical test
[~,p,~,STATS] = ttest(p1, p6);
fprintf('paired t-test on H_0: p(risky|low matched means) = p(risky|high matched means). tstat: %G, p: %G\n',...
    STATS.tstat, p)

% plot
figure
hold on

plot([0,1],[0,1], 'Color', 'k')
cm = brewermap(10, 'Blues');
c = cm(5, :);

scatter(p1, p6, 50, c, 'filled')

axis equal
xlim([0,1])
xticks([0,0.5,1])
ylim([0,1])
yticks([0,0.5,1])
text(0.75, 0.1, p2star(p),...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 30, 'FontName', 'Arial')
text(0.75, 0.05, sprintf(' p = %.2G',p),...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 15, 'FontName', 'Arial')

xlabel('P(risky|both-high)')
ylabel('P(risky|both-low)')

set(gca, 'FontSize', 15, 'FontName', 'Arial')

set(gcf, "Position", [775 686 345 262])
if SAVE
    set(gcf, 'Color', 'none')
    export_fig 'figures/fig_2_behaviour/preferences_2d.png' -m4
end

end
