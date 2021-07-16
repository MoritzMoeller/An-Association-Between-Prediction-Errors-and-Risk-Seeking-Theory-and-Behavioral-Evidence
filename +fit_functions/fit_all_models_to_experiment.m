function fit_all_models_to_experiment()

MODELS = helper_functions.get_all_models();

%%

parfor im = 1:length(MODELS)
        fit_functions.fit_model('plosCB2021', MODELS{im})
end
end