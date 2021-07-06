function simulate_and_compute_risk_preferneces(model, experiment, n)

sim_risk_preferences = {};
sim_risk_preferences_per_trial = {};

for j = 1:n
    
    sprintf("Simulating model %s, simulation %i", model, j)
    
    simulation_functions.simulate_dataset(simulation_functions.get_fit_data_path(model, experiment))
    dt = data_prep.load_data(['simulated_', model, '_using_fitted_params']);
    sim_risk_preferences{j} = helper_functions.get_risk_prefs(dt);
    sim_risk_preferences_per_trial{j} = helper_functions.get_risk_prefs_per_trial(dt);

end

disp('saving file')
save(['data/test/risk_prefs/risk_prefs_sim_', model,'_exp_',experiment,'.mat'],'sim_risk_preferences')
save(['data/test/risk_prefs_per_trial/risk_prefs_per_trial_sim_', model,'_exp_',experiment,'.mat'],'sim_risk_preferences_per_trial')


end