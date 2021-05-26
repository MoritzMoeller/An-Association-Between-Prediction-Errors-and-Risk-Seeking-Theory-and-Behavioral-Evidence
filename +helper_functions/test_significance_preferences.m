function p = test_significance_preferences(dt, panel)

switch panel
    case "P(high)"
        ndx = not(isnan(dt.highChosen)) & dt.trial < 121;
        variable = 'highChosen';
    case "P(risky|both-high)"
        ndx = dt.typeOfChoice == 1 & dt.trial < 121;
        variable = 'riskChosen';
    case "P(risky|both-low)"
        ndx = dt.typeOfChoice == 6 & dt.trial < 121;
        variable = 'riskChosen';
    otherwise
        disp("WRONG!!")
end

p_subs = [];
for s = unique(dt.ID)'
    
    ndx_s = ndx & dt.ID == s;
    p_subs = [p_subs, mean(dt.(variable)(ndx_s))];
end

[~,p,~,STATS] = ttest(p_subs - 0.5);
fprintf('t-test on H_0: p(highChosen) = 0.5, H_1: %s /= 0.5. tstat: %G, p: %G\n',...
    panel, STATS.tstat, p)
end