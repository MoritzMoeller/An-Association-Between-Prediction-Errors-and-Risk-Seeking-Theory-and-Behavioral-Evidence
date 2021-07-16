function params = simulate_dataset_posterior_mc(fit_data_path)
%
% example input:
% fit_data_path = '../data/plosCB2021/fits/fit_RW.mat'

% constants
number_of_blocks = 4;

% get parameters
d_fit = open(fit_data_path);
number_of_subjects = length(d_fit.posteriors);

% get model name
fit_data_split = split(fit_data_path, '/');
file_name = fit_data_split{end};
file_name_split = split(file_name, '.');
model_name = erase(file_name_split{1},"fit_");

% get model functions
g = str2func(['models.',model_name,'.g_',model_name]);
f = str2func(['models.',model_name,'.f_',model_name]);

% initialise result table
dt = table();


for subject = 1:number_of_subjects
        
    X0 = mvnrnd(d_fit.posteriors{subject}.muX0, d_fit.posteriors{subject}.SigmaX0)';
    X0 = reshape(X0, length(X0)/4, 4);
    
    phi = mvnrnd(d_fit.posteriors{subject}.muPhi, d_fit.posteriors{subject}.SigmaPhi);
    try 
        theta = mvnrnd(d_fit.posteriors{subject}.muTheta, d_fit.posteriors{subject}.SigmaTheta);
    catch 
        S = d_fit.posteriors{subject}.SigmaTheta;
        SIGMA = 0.5*(S + S');
        fprintf("Had to symmetrize. Difference between original and symmetric: %G\n", sum(sum((S-SIGMA).^2)))
        theta = mvnrnd(d_fit.posteriors{subject}.muTheta, SIGMA);
        
    end
    
    for block = 1:number_of_blocks
        
        block_data_table = simulation_functions.simulate_block(f, g,...
            phi,...
            theta,...
            X0(:, block));
        
        block_data_table.ID = subject * ones(height(block_data_table),1);
        block_data_table.block = block * ones(height(block_data_table),1);
        
        dt = [dt; block_data_table];
        
    end
end

% save result table
output_name = "data/simulation/simulated_" + model_name + "_fitted_posterior_mc.mat";
save(output_name, "dt")

params = struct();

params.X0 = X0;
params.phi = phi;
params.theta = theta;
params.model_name = model_name;

end