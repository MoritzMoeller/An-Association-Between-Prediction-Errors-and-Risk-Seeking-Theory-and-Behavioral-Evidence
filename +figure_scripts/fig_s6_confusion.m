function fig_s6_confusion()

MODELS = helper_functions.get_all_models();

helper_functions.count_fits_model_recovery_mc(MODELS);

%% plot

SAVE = 1;

figure
plot_functions.plot_confusion_BIC_mc(MODELS)

if SAVE
    set(gcf, 'Color', 'none');
    export_fig 'figures/fig_s6_confusion/model_recovery.png' -m4
end
end