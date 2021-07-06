function block_data_table = simulate_block(f, g, Phi, Theta, x0)

% constants
number_of_trials = 120;

% constructor
stim_chosen = nan(number_of_trials, 1);
stim_unchosen = nan(number_of_trials, 1);
reward = nan(number_of_trials, 1);

% init
block_data = simulation_functions.get_block_data();
x = x0;

for t = 1:number_of_trials
    
    % get input
    u = [nan, nan, block_data.stim1(t), block_data.stim2(t), 0];
    
    % choice
    gx = g(x, Phi, u, []);
    
    if gx > rand
        stim_chosen(t)= block_data.stim1(t);
        stim_unchosen(t)= block_data.stim2(t);
    else
        stim_chosen(t)= block_data.stim2(t);
        stim_unchosen(t)= block_data.stim1(t);
    end
    
    % get reward
    reward(t) = block_data.r{stim_chosen(t)}(1);
    block_data.r{stim_chosen(t)}(1) = [];
    
    u(1) = stim_chosen(t);
    u(2) = reward(t);

    % learning
    x = f(x, Theta, u, []);
end

block_data_table = table();
block_data_table.stim1 = block_data.stim1;
block_data_table.stim2 = block_data.stim2;
block_data_table.reward = reward;
block_data_table.stim_chosen = stim_chosen;
block_data_table.stim_unchosen = stim_unchosen;

end