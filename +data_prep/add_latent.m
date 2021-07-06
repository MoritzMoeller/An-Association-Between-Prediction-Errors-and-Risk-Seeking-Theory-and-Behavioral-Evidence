function dt = add_latent(dt, dataset, model)

D = open(['data/fits/', dataset,'/fit_', model,'.mat']);

subs = unique(dt.ID)';
blocks = unique(dt.block)';
nl = size(D.posteriors{1}.muX,1);

dt.([model,'_p_choice']) = nan(size(dt.ID));
dt.([model,'_latent']) = nan(size(dt.ID, 1), nl);
dt.([model,'_PE_o']) = nan(size(dt.ID));
dt.([model,'_PE_s']) = nan(size(dt.ID));
dt.([model,'_Q_stim1']) = nan(size(dt.ID));
dt.([model,'_Q_stim2']) = nan(size(dt.ID));
dt.([model,'_Q1']) = nan(size(dt.ID));
dt.([model,'_Q2']) = nan(size(dt.ID));
dt.([model,'_Q3']) = nan(size(dt.ID));
dt.([model,'_Q4']) = nan(size(dt.ID));
dt.([model,'_gamma']) = nan(size(dt.ID));

dt.([model,'_S_stim1']) = nan(size(dt.ID));
dt.([model,'_S_stim2']) = nan(size(dt.ID));
dt.([model,'_S1']) = nan(size(dt.ID));
dt.([model,'_S2']) = nan(size(dt.ID));
dt.([model,'_S3']) = nan(size(dt.ID));
dt.([model,'_S4']) = nan(size(dt.ID));


key = [model,'_p_choice'];

for i = subs
    
    ndx = dt.ID == i & not(isnan(dt.stim1) & isnan(dt.stim2));
    
    dt.(key)(ndx,:) = D.outs{i}.gx(1,:)';
    dt.([model,'_latent'])(ndx,:) = D.posteriors{i}.muX';
        
    for b = blocks
        
        ndx = dt.ID == i & not(isnan(dt.stim1) & isnan(dt.stim2)) & dt.block == b;
        
        % compute PEs
        L = dt.([model,'_latent'])(ndx, :);
        n_latent_per_block = size(L,2)/length(blocks);
        s = dt.stim_chosen(ndx);
        s1 = dt.stim1(ndx);
        s2 = dt.stim2(ndx);
        f = dt.forced(ndx);
        
        Qchosen = nan(size(s));
        Qstims = nan(size(s));
        Qall = nan(size(s));
        
        Q_stim1 = nan(size(s));
        Q_stim2 = nan(size(s));
        
        Q1 = nan(size(s));
        Q2 = nan(size(s));
        Q3 = nan(size(s));
        Q4 = nan(size(s));
        
        if n_latent_per_block == 8
            Schosen = nan(size(s));
            Sstims = nan(size(s));
            Sall = nan(size(s));

            S_stim1 = nan(size(s));
            S_stim2 = nan(size(s));

            S1 = nan(size(s));
            S2 = nan(size(s));
            S3 = nan(size(s));
            S4 = nan(size(s));
            
        end
        
        for c = 1:length(s)
            Qchosen(c,1) = L(c,s(c) + (b - 1) * n_latent_per_block);
            
            Q1(c,1) = L(c,1 + (b - 1) * n_latent_per_block);
            Q2(c,1) = L(c,2 + (b - 1) * n_latent_per_block);
            Q3(c,1) = L(c,3 + (b - 1) * n_latent_per_block);
            Q4(c,1) = L(c,4 + (b - 1) * n_latent_per_block);
            
            Q_stim1(c,1) = L(c,s1(c) + (b - 1) * n_latent_per_block);
            
            if not(f(c) == 1)
                
                Q_stim2(c,1) = L(c,s2(c) + (b - 1) * n_latent_per_block);
                Qstims(c,1) = 0.5 * ( L(c,s1(c) + (b - 1) * n_latent_per_block)...
                    + L(c,s2(c) + (b - 1) * n_latent_per_block));
                Qall(c,1) = 0.25 *...
                    ( L(c,1 + (b - 1) * n_latent_per_block) + L(c,2 + (b - 1) * n_latent_per_block)...
                    + L(c,3 + (b - 1) * n_latent_per_block) + L(c,4 + (b - 1) * n_latent_per_block));
            end
            
            if n_latent_per_block == 8
                
                Schosen(c,1) = L(c,4 + s(c) + (b - 1) * n_latent_per_block);
            
                S1(c,1) = L(c,5 + (b - 1) * n_latent_per_block);
                S2(c,1) = L(c,6 + (b - 1) * n_latent_per_block);
                S3(c,1) = L(c,7 + (b - 1) * n_latent_per_block);
                S4(c,1) = L(c,8 + (b - 1) * n_latent_per_block);

                S_stim1(c,1) = L(c,4 + s1(c) + (b - 1) * n_latent_per_block);

                if not(f(c) == 1)

                    S_stim2(c,1) = L(c,4 + s2(c) + (b - 1) * n_latent_per_block);
                    Sstims(c,1) = 0.5 * ( L(c,4 + s1(c) + (b - 1) * n_latent_per_block)...
                        + L(c,4 + s2(c) + (b - 1) * n_latent_per_block));
                    Sall(c,1) = 0.25 *...
                        ( L(c,5 + (b - 1) * n_latent_per_block) + L(c,6 + (b - 1) * n_latent_per_block)...
                        + L(c,7 + (b - 1) * n_latent_per_block) + L(c,8 + (b - 1) * n_latent_per_block));
                end
                
            end
        end
        dt.([model,'_PE_o'])(ndx,:) = dt.reward(ndx) - Qchosen;
        dt.([model,'_PE_s'])(ndx,:) = Qstims - Qall;
        dt.([model,'_Q_stim1'])(ndx,:) = Q_stim1;
        dt.([model,'_Q_stim2'])(ndx,:) = Q_stim2;
        dt.([model,'_Q1'])(ndx,:) = Q1;
        dt.([model,'_Q2'])(ndx,:) = Q2;
        dt.([model,'_Q3'])(ndx,:) = Q3;
        dt.([model,'_Q4'])(ndx,:) = Q4;
        
        if n_latent_per_block == 8

            dt.([model,'_S_stim1'])(ndx,:) = S_stim1;
            dt.([model,'_S_stim2'])(ndx,:) = S_stim2;
            dt.([model,'_S1'])(ndx,:) = S1;
            dt.([model,'_S2'])(ndx,:) = S2;
            dt.([model,'_S3'])(ndx,:) = S3;
            dt.([model,'_S4'])(ndx,:) = S4;
            
        end
    end
    
    key_correct = [model,'_p_correct'];
    key_risky = [model,'_p_risky'];
    
    dt.(key_correct) = dt.correct.*(dt.stim_chosen == dt.stim1).*dt.(key) + ...
        dt.correct.*(dt.stim_chosen == dt.stim2).*(1 - dt.(key)) + ...
        (1 - dt.correct).*(dt.stim_chosen == dt.stim1).*(1 - dt.(key)) + ...
        (1 - dt.correct).*(dt.stim_chosen == dt.stim2).*dt.(key);
    
    dt.(key_risky) = dt.risky.*(dt.stim_chosen == dt.stim1).*dt.(key) + ...
        dt.risky.*(dt.stim_chosen == dt.stim2).*(1 - dt.(key)) + ...
        (1 - dt.risky).*(dt.stim_chosen == dt.stim1).*(1 - dt.(key)) + ...
        (1 - dt.risky).*(dt.stim_chosen == dt.stim2).*dt.(key);
    
end

dt.([model,'_abs_PE_o']) = abs(dt.([model,'_PE_o']));
dt.([model,'_abs_PE_s']) = abs(dt.([model,'_PE_s']));