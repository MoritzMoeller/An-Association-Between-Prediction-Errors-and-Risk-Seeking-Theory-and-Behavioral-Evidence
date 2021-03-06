function fit_model_for_confusion(dataset, model, ground_truth_params)

% set initial value
Q0 = 50;

% load data
dt = data_prep.load_data(dataset);

% get fit script
fit_VBA_model = str2func(['models.',model,'.fit_',model]);

% set up structures for fit outcomes
posteriors = {};
outs = {};

% go through all subjects and blocks to do the fit
subs = unique(dt.ID)';
for i = subs
    
    disp(['model: ', model])
    disp(['fitting subject ',num2str(i),'/',num2str(length(subs))])
    
    % fit model
    try
        [p, o] = fit_VBA_model(i, dt, 0, Q0);
    catch exception
        disp(['model ', model, ' makes trouble!'])
    end
    
    
    % store that fit
    posteriors{i}.muX0 = p.muX0;
    posteriors{i}.SigmaX0 = p.SigmaX0;
    posteriors{i}.muPhi = p.muPhi;
    posteriors{i}.SigmaPhi = p.SigmaPhi;
    posteriors{i}.muTheta = p.muTheta;
    posteriors{i}.SigmaTheta = p.SigmaTheta;
    %posteriors{i}.muX = p.muX;
    outs{i}.F = o.F;
    %outs{i}.gx = o.suffStat.gx;
    outs{i}.fit = o.fit;
end

disp('saving file')
mkdir('data/recovery_posterior_mc/')
save(['data/recovery_posterior_mc/fit_', model,'_',sprintf('%0.0f',now*1e8),'.mat'],'posteriors','outs', 'ground_truth_params')

end