function plot_BIC_bar_direct(data_set, models)

n_mods = length(models);

dt = data_prep.load_data(data_set);
subs = unique(dt.ID)';
n_subs = length(subs);

stat = 'BIC_woiv';

%% collect data

stats = nan(n_subs, n_mods);

for i_mod = 1:n_mods
    
    model = models{i_mod};
    D_fit = open("fits/"+data_set+"/fit_"+model+".mat");
    
    for i_sub = 1:n_subs
        
        ncorrected = length(D_fit.posteriors{i_sub}.muPhi) + length(D_fit.posteriors{i_sub}.muTheta);
        D_fit.outs{i_sub}.BIC_woiv = ...
            -(D_fit.outs{i_sub}.fit.LL - 0.5 * ncorrected * log(D_fit.outs{i_sub}.fit.ny));
        
        try
            stats(i_sub, i_mod) = D_fit.outs{i_sub}.(stat);
        catch
            stats(i_sub, i_mod) = D_fit.outs{i_sub}.fit.(stat);
        end
        
    end
end

BIC_all = squeeze(sum(stats,1));


%% order data wrt BIC_all

[BIC_all_ranked, idx] = sort(BIC_all);
models_ranked = models(idx);

%%  plot data

figure
    
cm = brewermap(10, 'Blues');
c = cm(5, :);

bar(1:n_mods, BIC_all_ranked, 'FaceColor', c)
    
%axis equal
axis square
    
xticks(1:n_mods)
xticklabels(labels_from_models(models_ranked))

xtickangle(45)

ylim([5700, 6150])
xlim([0,n_mods+1])

ylabel("Sum BIC")

box off
set(gca, 'FontSize', 15, 'FontName', 'Arial')
    
end

