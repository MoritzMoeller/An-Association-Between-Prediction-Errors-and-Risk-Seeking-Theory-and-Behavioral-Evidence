function  fx = f_s_shaped_UTIL(x,P,u,~)

% IN:
%	- x: action values and learning rate (n x 1)
%   - x(1:4): action values
%   - P(1): learning rate for value
%	- u(1): index of chosen stim
%   - u(2): reward obtained
%
% OUT:
%   - fx: updated action values and learning rate

% learning rate
alpha = VBA_sigmoid(P(1)); % [-Inf,Inf] -> [0 1]

% compression param
k = 1 + exp(P(2));

i = u(1);
r = u(2);

% start with previous values
fx = x;

% udpdate previous action value: Q_t+1 = Q_t + a_Q * d
fx(i) = x(i) + alpha * ( helper_functions.power_utility(r, k) - x(i) );

end