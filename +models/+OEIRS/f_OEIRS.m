function  fx = f_OEIRS(x,P,u,~)

% IN:
%   - x(1:4): action values
%   - x(9): delta outcome
%   - P(1): learning rate for value
%	- u(1): index of chosen stim
%   - u(2): reward obtained
%
% OUT:
%   - fx: updated action values and learning rate

S0 = exp(P(3));
x(5:8) = x(5:8) + S0;

% learning rates
alpha_Q = VBA_sigmoid(P(1)); % [-Inf,Inf] -> [0 1]
alpha_S = VBA_sigmoid(P(2)); % [-Inf,Inf] -> [0 1]

% start with previous values
fx = x; 

% calculate prediction error: d = R - Q
i = u(1);
is = i + 4;

delta = u(2) - x(i);
delta_spread = abs(delta) - x(is);

% udpdate previous action value: Q_t+1 = Q_t + a_Q * d
fx(i) = x(i) + alpha_Q * delta; 
fx(is) = x(is) + alpha_S * delta_spread;

% update previous spread value
fx(5:8) = fx(5:8) - S0;

% set the outcome prediction error for the next trial
fx(9) = delta;
end