function  gx = g_PEIRS(x, P, u, ~)

% IN:
%   - x(1:4): action values
%   - x(5): delta
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
    
    % compute context PE
    delta_stim = ( x(i1) + x(i2) ) / 2 - sum(x(1:4)) / 4;

    % compute risk preference on this trial
    PEIRS = tanh(gamma * delta_stim);
    
    % compute V for stim 1 and stim 2:
    V1 = x(i1) + PEIRS * x(i1+4);
    V2 = x(i2) + PEIRS * x(i2+4);

    % Compute differential between stim2 and stim1
    dV = V1 - V2;
    
    gx(1) = VBA_sigmoid( beta * dV );   
end
end