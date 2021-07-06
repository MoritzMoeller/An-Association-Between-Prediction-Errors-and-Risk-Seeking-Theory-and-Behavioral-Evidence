function risk_prefs_per_trial = get_risk_prefs_per_trial(dt)

subs = unique(dt.ID)';

risk_prefs_per_trial = struct();
risk_prefs_per_trial.p_risky_win_per_trial = nan(length(subs),120,4);
risk_prefs_per_trial.p_risky_loose_per_trial = nan(length(subs),120,4);

for i = subs
    for b = 1:4
    
        ndx = dt.ID == i & dt.block == b;
        
        dt_small = dt(ndx,:);
        
        ndx_win = dt_small.win == 1;
        risk_prefs_per_trial.p_risky_win_per_trial(i,ndx_win,b) = dt_small.risky(ndx_win);
        
        ndx_loose = dt_small.win == -1;
        risk_prefs_per_trial.p_risky_loose_per_trial(i,ndx_loose,b) = dt_small.risky(ndx_loose);
    end
end

end