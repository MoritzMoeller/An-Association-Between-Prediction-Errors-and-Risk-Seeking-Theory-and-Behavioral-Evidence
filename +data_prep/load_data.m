function dt = load_data(experiment)

i1 = sscanf(experiment, 'sim1_%i');
if not(isempty(i1))
    experiment = 'sim1';
end

i2 = sscanf(experiment, 'sim2_%i');
if not(isempty(i2))
    experiment = 'sim2';
end

i3 = sscanf(experiment, 'simulated_%s');
if not(isempty(i3))
    experiment = 'simulated';
end

m1 = sscanf(experiment, 'sim_%s');
if not(isempty(m1))
    experiment = 'sim';
end

m2 = sscanf(experiment, 'plosCB2021_%i');
if not(isempty(m2))
    experiment = 'plosCB2021';
end


switch experiment
    case {3, 'plosCB2021'}
        D = load('data/experiment/data_table_plosCB2021.mat');
        dt = data_prep.ready_dt_plosCB2021(D.data_table_image, 0);
        
    case {'test'}
        D = load('data/experiment/data_table_plosCB2021.mat');
        dt = data_prep.ready_dt_plosCB2021(D.data_table_image, 0);
        dt = dt(dt.ID == 1 & dt.block == 1, :);
        
    case {'plosCB2021_alt_pub'}
        D = load('../Reward-prediction-errors-induce-risk-seeking/data_table_alt_pub.mat');
        dt = ready_dt_plosCB2021(D.data_table, 0);
        
    case {'sim1'}
        D = load(['simulation game/data/dt', int2str(i1), '.mat']);
        dt = ready_sim_v2(D.dt);
        
    case {'sim2'}
        D = load(['simulation_game_v2/data/dt', int2str(i2), '_2.mat']);
        dt = ready_sim_v2(D.dt);
        
    case {'sim'}
        D = load(['sim game from fit/data/dt', m1, '.mat']);
        dt = ready_sim_v2(D.dt);
        
    case {'simulated'}
        D = load(['data/simulation/simulated_', i3, '.mat']);
        dt = ready_sim_v2(D.dt);
        
    otherwise
        disp('That one does not exist!')
end
end
