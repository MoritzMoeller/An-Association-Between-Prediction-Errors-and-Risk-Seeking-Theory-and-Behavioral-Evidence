function simulate_and_fit_recovery()

n = 1; % iterations

models = helper_functions.get_all_models();
experiment = 'plosCB2021';

n_mod = length(models);

%%

for i = 1:n
    
    % fit all models to all simulations, store results
    for i_sim = 1:n_mod
        ground_truth_params = ...
            simulation_functions.simulate_dataset_posterior_mc(simulation_functions.get_fit_data_path(models{i_sim}, experiment));
        dataset = ['simulated_', models{i_sim}, '_fitted_posterior_mc'];
        
        parfor i_rec = 1:n_mod
            fit_functions.fit_model_for_confusion(dataset, models{i_rec}, ground_truth_params)

            % sample from empirical post
            % simulate from sampled param
        end
    end
end
end