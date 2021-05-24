function lls = plot_simulated_risk_preferences_contour(models, experiment)

exp_risk_prefs = helper_functions.get_risk_prefs(data_prep.load_data(experiment));
labels = helper_functions.labels_from_models(models);

color_scatter = 'k';

lls = [];

figure
for im = 1:length(models)
    
    subplot(1,length(models), im)
    hold on
    
    D = load(['risk_prefs/risk_prefs_sim_',models{im},'_exp_',experiment,'.mat']);
    sim_risk_prefs = D.sim_risk_preferences;
    
    model_risk_prefs = [];
    for i = 1:size(sim_risk_prefs, 2)
        model_risk_prefs = [model_risk_prefs; sim_risk_prefs{i}.p_risky_win, sim_risk_prefs{i}.p_risky_loose];
    end
    
    
    % old method
    
    %nbins = [10 10];
    %[N,C] = hist3(model_risk_prefs, nbins);
    
    %%contour(C{1},C{2},N')
    %contourf(C{1},C{2},N', "LineStyle", "none")
    %colormap([1,1,1; brewermap(10, 'Blues')])
    
    % end old method
    
    gridx = linspace(0,1,100);
    [x1,x2] = meshgrid(gridx, gridx);
    xi = [x1(:) x2(:)];
    
    pdf = ksdensity(model_risk_prefs, xi, 'Bandwidth',[0.0275, 0.0275]);
    pdf = pdf/max(pdf);
    
    %imagesc(gridx, gridx, reshape(pdf, 100, 100))
    
    levels = linspace(0,1,12);
    levels = levels(2:end-1);
    
    contourf(gridx, gridx, reshape(pdf, 100, 100), levels, "LineStyle", "none")
    
    colormap([1,1,1; brewermap(1000, 'Blues')])
    
    %colorbar
    
    plot([0 1],[0 1],'k')
    % scatter(mean(risk_prefs(1,:,:)),mean(risk_prefs(2,:,:)),50,'r','filled','markeredgecolor','k')
    if im == 1
        xlabel('P(risky|high)')
        ylabel('P(risky|low)')
        yticks([0.1,0.9])
    else
        yticks([])
    end
    
    xticks([0.1,0.9])
        
    axis equal; axis([0.1 0.9 0.1 0.9]);
  
    title({labels{im}})
    
    scatter(exp_risk_prefs.p_risky_win, exp_risk_prefs.p_risky_loose, 20, color_scatter, 'filled', 'MarkerFaceAlpha', 0.2)
    
    %risk_preferences = sim_risk_preferences{im};
    %scatter(mean(risk_preferences(:,1)), mean(risk_preferences(:,2)), 20, 'r', 'filled')
    
    set(gca, 'FontName', 'Arial', 'FontSize', 15)
    
    % for stats: compute the log likelihood of experimental data by
    % interpolating distribution
    
    [pdf_data, ~, bw] = ksdensity(model_risk_prefs, [exp_risk_prefs.p_risky_win, exp_risk_prefs.p_risky_loose],...
        'Bandwidth',[0.0275, 0.0275]);

    ll = sum(log(pdf_data));
    
    lls = [lls; ll];
    
end

end