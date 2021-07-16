function simulate_dataset(fit_data_path)
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
    
    muX0 = d_fit.posteriors{subject}.muX0;
    muX0 = reshape(muX0, length(muX0)/4, 4);
    
    for block = 1:number_of_blocks
        
        block_data_table = simulation_functions.simulate_block(f, g,...
            d_fit.posteriors{subject}.muPhi,...
            d_fit.posteriors{subject}.muTheta,...
            muX0(:, block));
        
        block_data_table.ID = subject * ones(height(block_data_table),1);
        block_data_table.block = block * ones(height(block_data_table),1);
        
        dt = [dt; block_data_table];
        
    end
end

% save result table
output_name = "data/simulation/simulated_" + model_name + "_using_fitted_params.mat";
save(output_name, "dt")

end