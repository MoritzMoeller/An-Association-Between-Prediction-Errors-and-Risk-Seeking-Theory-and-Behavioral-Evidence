function plot_simulated_learning_curves(sim_risk_preferences_per_trial, c1, c2)

XLIM = [0,120];
n_sub = 27;

hold on

c = [c1;c2];

risk_prefs_win = nan(length(sim_risk_preferences_per_trial), n_sub, 120);
risk_prefs_loose = nan(length(sim_risk_preferences_per_trial), n_sub, 120);

for s = 1:length(sim_risk_preferences_per_trial)
    risk_prefs_win(s,:,:) = nanmean(sim_risk_preferences_per_trial{s}.p_risky_win_per_trial,3);
    risk_prefs_loose(s,:,:) = nanmean(sim_risk_preferences_per_trial{s}.p_risky_loose_per_trial,3);
end

risk_prefs_per_sub = {};
risk_prefs_per_sub{1} = squeeze(nanmean(risk_prefs_win));
risk_prefs_per_sub{2} = squeeze(nanmean(risk_prefs_loose));

for i = 1:2
    y = nanmean(risk_prefs_per_sub{i});
    e = nanstd(risk_prefs_per_sub{i})/sqrt(n_sub);
    
    y = smooth(y,20);
    e = smooth(e,20);
    
    shadedErrorBar(1:120, y, e, 'lineProps', {'Linewidth', 2, 'Color', c(i,:)})
end

plot(XLIM, 0.5 * [1,1], 'k')

ylim([.35,.65])
xlim(XLIM)

yticks([.35,0.5,65])

end
