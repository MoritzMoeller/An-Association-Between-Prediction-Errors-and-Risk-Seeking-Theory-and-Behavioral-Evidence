function all_diffs = compute_exp_risk_diffs(experiment)

all_diffs = {};

all_risk_prefs = {helper_functions.get_risk_prefs(data_prep.load_data(experiment))};
all_risk_diffs_array = all_risk_prefs{1}.p_risky_win' - all_risk_prefs{1}.p_risky_loose';

all_diffs{1} = all_risk_diffs_array;
    

end
