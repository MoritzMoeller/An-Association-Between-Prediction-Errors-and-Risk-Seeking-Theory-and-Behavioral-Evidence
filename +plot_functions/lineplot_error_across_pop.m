function lineplot_error_across_pop(dt, x, y, split_by, color)

if isempty(split_by)
    
    xd = table2array(dt(:,x));
    yd = table2array(dt(:,y));
    
    if sum(mod(xd,1)) == 0
        idx = xd - min(xd) + 1;
        ndx = idx == idx;
    else
        [~, ~, idx] = histcounts(xd);
        ndx = not(idx == 0);
    end
        
    xp = accumarray(idx(ndx), xd(ndx), [], @(x) nanmean(x));
    y_all = [];
    for id = unique(dt.ID)'
        
        ndx_id = dt.ID == id & ndx;
        y_all = [y_all, accumarray(idx(ndx_id), yd(ndx_id), [], @(x) nanmean(x))];
        
    end
    yp = nanmean(y_all, 2);
    ep = nanstd(y_all, [], 2)/sqrt(length(unique(dt.ID)'));
    
    ndx = not(xp == 0 & yp == 0);
    X = sortrows([xp(ndx), yp(ndx), ep(ndx)]);
    errorbar(X(:,1), X(:,2), X(:,3), 'LineWidth', 2, 'MarkerSize', 50, 'CapSize',0, 'Color', color)
    h = scatter(X(:,1), X(:,2), 30, color, 'filled');
    set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
    
else
    hold on
    sd = table2array(dt(:,split_by));
    
    ss = unique(sd)';
    
    for s = ss(not(isnan(ss)))
        
        
        xd = table2array(dt(sd == s,x));
        yd = table2array(dt(sd == s,y));
        IDd = table2array(dt(sd == s,"ID"));
        
        ndx = not(isnan(xd)) & not(isnan(yd));
        xd = xd(ndx);
        yd = yd(ndx);
        
        if sum(mod(xd,1)) == 0
            idx = xd - min(xd) + 1;
            ndx = idx == idx;
        else
            [~, ~, idx] = histcounts(xd);
            ndx = not(idx == 0);
        end
        
        xp = accumarray(idx(ndx), xd(ndx), [], @(x) nanmean(x));
        y_all = [];
        for id = unique(dt.ID)'
            
            ndx_id = IDd == id & ndx;
            y_all = [y_all, accumarray(idx(ndx_id), yd(ndx_id), [], @(x) nanmean(x))];
            
        end
        yp = nanmean(y_all, 2);
        ep = nanstd(y_all, [], 2)/sqrt(length(unique(dt.ID)'));
        try
            ndx = not(xp == 0 & yp == 0);
            X = sortrows([xp(ndx), yp(ndx), ep(ndx)]);
            errorbar(X(:,1), X(:,2), X(:,3), 'LineWidth', 2, 'MarkerSize', 50, 'CapSize',0, 'Color', color)
            h = scatter(X(:,1), X(:,2), 30, color, 'filled');
            set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
        end
        
    end
end

end