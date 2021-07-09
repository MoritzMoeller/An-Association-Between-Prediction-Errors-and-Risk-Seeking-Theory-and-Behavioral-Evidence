function  gx = g_convex_UTIL(x, P, u, ~)

% IN:
%   - x(1:4): action values
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
    
    gx = 1;
else
    
    beta = exp(P(1));
    
    i1 = u(3);
    i2 = u(4);
    
    gx = VBA_sigmoid( beta * ( x(i1) - x(i2) ) );   
end
end