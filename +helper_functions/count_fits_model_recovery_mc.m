function count_fits_model_recovery_mc(models)

n_mods = length(models);

for i = 1:n_mods
    
    data_set = ['simulated_', models{i}, '_fitted_posterior_mc'];
    % BICs = nan(n_subs, n_mods);
    
    for j = 1:n_mods
        
        all_fits = dir("recovery_posterior_mc/" + data_set+"/fit_" + models{j} + "_*.mat");
        n_fits = length(all_fits);
        
        disp(sprintf("Have %G fits for model " + models{j} + " to dataset " + data_set, n_fits))
        
    end
end
end
