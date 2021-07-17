function simulate_risk_preferences()

models = helper_functions.get_all_models();
experiment = 'plosCB2021';

n = 1000;


parfor m = 1:length(models)
    
    simulation_functions.simulate_and_compute_risk_preferneces(models{m}, experiment, n);
end
end