function  gx = g_OEIRS(x, P, u, ~)

% IN:
%   - x(1:4): action values
%   - x(9): delta_outcome
%   - P(1): softmax temprearture
%   - u(3): index of displayed stim 1
%   - u(4): index of displayed stim 2
%   - u(5): forced trial flag, 1 if forced, 0 else
%
%	- in: [useless]
%
% OUT:
%   - gx: probability of choosing stim1

f = u(5); %    

if f
    
    gx(1) = 1;
else
    
    beta = exp(P(1));
    gamma = P(2);
    
    i1 = u(3);
    i2 = u(4);
    
    % Need outcome PE from last trial
    delta_outcome_prev_trial = x(9);

    % compute risk preference on this trial
    RIRS = tanh( gamma * delta_outcome_prev_trial );
    
    % compute V for stim 1 and stim 2:
    V1 = x(i1) + RIRS * x(i1+4);
    V2 = x(i2) + RIRS * x(i2+4);

    % Compute differential between stim2 and stim1
    dV = V1 - V2;
    
    gx(1) = VBA_sigmoid( beta * dV );   
end
end