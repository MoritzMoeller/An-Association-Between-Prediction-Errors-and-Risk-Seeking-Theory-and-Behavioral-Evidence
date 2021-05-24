function  fx = f_VAR(x,P,u,~)

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
alpha_risk = VBA_sigmoid(P(1)); % [-Inf,Inf] -> [0 1]
alpha_safe = VBA_sigmoid(P(2));

a = [alpha_risk, alpha_safe];

i = u(1);
r = u(2);

switch i
    case {1, 3}
        s = 1;
    case {2, 4}
        s = 2; 
    otherwise
        disp('Something is wrong!')
        return
end

delta = r - x(i);

% udpdate previous action value: Q_t+1 = Q_t + a_Q * d
fx = x;
fx(i) = x(i) + a(s) * delta;

end