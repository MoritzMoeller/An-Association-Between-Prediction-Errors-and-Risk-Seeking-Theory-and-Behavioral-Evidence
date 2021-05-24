function risk_prefs = get_risk_prefs(dt)

subs = unique(dt.ID)';

risk_prefs = struct();
risk_prefs.p_risky_win = nan(length(subs),1);
risk_prefs.p_risky_loose = nan(length(subs),1);

for i = subs
    
    ndx = dt.ID == i & dt.win == 1;
    risk_prefs.p_risky_win(i) = mean(dt.risky(ndx));
    
    ndx = dt.ID == i & dt.win == -1;
    risk_prefs.p_risky_loose(i) = mean(dt.risky(ndx));
end

end