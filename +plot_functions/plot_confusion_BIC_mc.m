function plot_confusion_BIC_mc(models)

labels = labels_from_models(models);

n_mods = length(models);
n_subs = 27;

BIC_avgs = nan(n_mods, n_mods);
BIC_ranks = nan(n_mods, n_mods);

for i = 1:n_mods
    
    data_set = ['simulated_', models{i}, '_fitted_posterior_mc'];
    
    for j = 1:n_mods
        
        all_fits = dir("recovery_posterior_mc/" + data_set+"/fit_" + models{j} + "_*.mat");
        n_fits = length(all_fits);
        n_fits_max = 100;
        
        if n_fits < n_fits_max
            fprintf("Less than %G fits!\n", n_fits_max)
            break
        end
        
        BICs = nan(n_subs, n_fits_max);
        
        for k = 1:n_fits_max
            
            D_fit = open("recovery_posterior_mc/"+data_set+"/"+all_fits(k).name);
            
            for i_sub = 1:n_subs
                
                ncorrected = length(D_fit.posteriors{i_sub}.muPhi) + length(D_fit.posteriors{i_sub}.muTheta);
                BICs(i_sub, k) = -(D_fit.outs{i_sub}.fit.LL - 0.5 * ncorrected * log(D_fit.outs{i_sub}.fit.ny));
            end
        end
        
        BIC_avgs(i,j) = sum(sum(BICs))/n_fits_max;
        
    end
    
    
    BIC_avgs(i,:) = BIC_avgs(i,:) - min(BIC_avgs(i,:));%/(max(sum(BICs)) - min(sum(BICs)));
    [~, ii] = sort(BIC_avgs(i,:));
    [~,ranks]= sort(ii);
    BIC_ranks(i,:) = ranks;
end

hold on
imagesc(log(BIC_avgs))
colormap(flip(brewermap(100, 'Greys')))
axis equal

xticks(1:n_mods)
xticklabels(labels)
xtickangle(45)

xlabel("recovered model")

yticks(1:n_mods)
yticklabels(labels)

ylabel("simulated model")

title('model recovery', "FontWeight", "normal")

xlim([0.5,n_mods+0.5])
ylim([0.5,n_mods+0.5])

set(gca,"Fontsize",15, "Fontname", "Arial")

c = colorbar("FontName", "Arial", 'FontSize', 15);
c.Label.String = 'log(\Delta BIC) (relative to best fitting model)';

for i = 1:n_mods
    for j = 1:n_mods
        text(i,j,...
            sprintf("%G", BIC_ranks(j,i)),...
            "VerticalAlignment", "middle",...
            "HorizontalAlignment", "center",...
            "Color", "r",...
            "FontSize", 15,...
            "FontName", "Arial")
    end
end
end
