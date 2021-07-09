function labels = labels_from_models(models)

model_names = helper_functions.load_model_names();

n_models = length(models);
labels = cell(1, n_models);

for i = 1:n_models
    labels{i} = model_names.(models{i});
end
end