function plot_regression_traces_bin_hierarchical(y, e, INTERP, nt, fig_name, event_name, color)
%% constants

XLIMS = [-200,2000];
TICKS = 0:1000:2000;

%% stats

bin_stats = struct();

n_y = length(y);
bin_width = 5;

index = 0:(n_y-1);
bin_ids = ( index - mod(index, bin_width) ) / bin_width;

bin_ids_set = unique(bin_ids);

for i = 1:length(bin_ids_set)
    
    bin_id = bin_ids_set(i);
    vals = y(bin_ids == bin_id);
    [~, p] = ttest(vals,[], 'tail', 'right');
    bin_stats(i).p = p * length(bin_ids_set); % bonferroni correction
    bin_stats(i).bin_centre = mean(index(bin_ids == bin_id)) + 1;
    bin_stats(i).bin_edge = max(index(bin_ids == bin_id)) + 1;
end

%% interpolation

t = (1:nt)*100;

if INTERP
    tt = linspace(0, t(end),1000);
    yy = interp1(t,y,tt,'spline');
    ee = interp1(t,e,tt,'spline');
end

%% draw fig

hold on

shadedErrorBar(tt, yy, ee, 'lineprops', {'LineWidth', 3, 'Color', color})

ystar = 1.1 * max(yy + ee);
YLIMS = [-ystar*0.2, ystar*1.3];

% plot stars
for i = 1:length(bin_stats)
    
    if bin_stats(i).p < 0.05
        text(bin_stats(i).bin_centre*100, ystar, '*', ...
            'FontSize', 30, 'HorizontalAlignment', 'center', 'Color', 'k')
    end
end

% plot bins
for i = 1:length(bin_stats)-1
    
    plot(bin_stats(i).bin_edge*[1,1]*100, YLIMS, 'LineWidth', 0.5, 'LineStyle', '--', 'Color', 'k')
end

ylim(YLIMS)
xlim(XLIMS)

xticks(TICKS)

tick_labels = {};
for i = 1:length(TICKS)
    tick_labels{i} = TICKS(i);
    if TICKS(i) ==  0
        tick_labels{i} = event_name;
    end       
end
xticklabels(tick_labels)

yticks(0)
yticklabels(0)

xlabel('Time [ms]')
ylabel({'Pupil response to \delta (a.u.)'})

title(fig_name)

plot(XLIMS,  [0,0], 'LineWidth', 0.5, 'Color', 'k')
plot([0,0], YLIMS, 'LineWidth', 0.5, 'Color', 'k')

set(gca, 'FontSize', 15, 'FontName', 'Arial')

end