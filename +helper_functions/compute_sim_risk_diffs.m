function all_diffs = compute_sim_risk_diffs(models, experiment)

m = length(models);

all_diffs = {};

for i = 1:m
    
    model = models{i};
    D = load(['risk_prefs/risk_prefs_sim_',model,'_exp_',experiment,'.mat']);
    all_risk_prefs = D.sim_risk_preferences;
    
    n = length(all_risk_prefs);
    all_risk_diffs_array = nan(n,27);

    for j = 1:n
        all_risk_diffs_array(j,:) = all_risk_prefs{j}.p_risky_win' - all_risk_prefs{j}.p_risky_loose';
    end
    
    all_diffs{i} = all_risk_diffs_array;
    
end
end


