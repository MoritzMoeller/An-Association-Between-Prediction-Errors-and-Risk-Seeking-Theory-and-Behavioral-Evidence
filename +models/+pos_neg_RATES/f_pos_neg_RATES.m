function  fx = f_pos_neg_RATES(x,P,u,~)

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
alpha_p = VBA_sigmoid(P(1)); % [-Inf,Inf] -> [0 1]
alpha_m = VBA_sigmoid(P(2));

i = u(1);
r = u(2);

delta = r - x(i);

% udpdate previous action value: Q_t+1 = Q_t + a_Q * d
fx = x;
fx(i) = x(i) + (delta > 0) * alpha_p * delta  + (delta < 0) * alpha_m * delta;

end