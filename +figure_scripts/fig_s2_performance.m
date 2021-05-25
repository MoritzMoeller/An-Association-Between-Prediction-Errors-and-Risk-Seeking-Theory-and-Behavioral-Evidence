function fig_s2_performance()

SAVE = 1;

plot_functions.plot_performance();

if SAVE
    set(gcf, 'Color', 'none');
    export_fig 'figures/fig_s2_performance/exclude_thresh.png' -m4
end

end