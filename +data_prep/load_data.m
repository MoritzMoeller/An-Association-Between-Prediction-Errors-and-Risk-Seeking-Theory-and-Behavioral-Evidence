function dt = load_data(experiment)

s1 = sscanf(experiment, 'plosCB2021_%i');
if not(isempty(s1))
    experiment = 'plosCB2021';
end

s2 = sscanf(experiment, 'simulated_%s');
if not(isempty(s2))
    experiment = 'simulated';
end

switch experiment
    case {3, 'plosCB2021'}
        D = load('data/experiment/data_table_plosCB2021.mat');
        dt = data_prep.ready_dt_plosCB2021(D.data_table_image, 0);
    case {'simulated'}
        D = load(['data/simulation/simulated_', s2, '.mat']);
        dt = data_prep.ready_dt_sim(D.dt);
    otherwise
        disp('That one does not exist!')
end
end
