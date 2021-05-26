

MODELS = get_all_models();

helper_functions.count_fits_model_recovery_mc(MODELS);

%% plot

SAVE = 1;

figure
plot_confusion_BIC_mc(MODELS)

if SAVE
    set(gcf, 'Color', 'none');
    export_fig '/Users/moritzmoeller/Dropbox/PEIRS/Fig S5 - model recovery/components/model_recovery.png' -m4
end
