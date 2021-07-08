function [posterior, out] = fit_EU_hard_convex_grohn(ID, dt, DISP, Q0)

% This function uses VBA to fit a model specified by f and g to one block
% of data. The block is specified through ID and block number, the data is
% found in dt.
%
% IN:
%  - ID: ID of the participant to be fitted
%  - block: block number of the block to be fitted
%  - dt: a table of data, collected or simulated
%  - DISP: set 1 to get visual output, 0 to suppress
%
% OUT:
%  - output of VBA_NLStateSpaceModel, simply forwarded
%

%% specify and reformat data for VBA

% find relevant data
dt = dt(dt.ID == ID,:);

% get rid of non-choice trials
ndx = isnan(dt.stim1) & isnan(dt.stim2);
dt(ndx,:) = [];

% prepare target variable
dt.choices = double(dt.stim_chosen == dt.stim1); % need integers, not logicals

% set observations
y = dt.choices';

% set inputs
% NOTE: dynamics are assumed to be
%   y_t = g( x_t,   u_t, phi   ) + e_t
%   x_t = f( x_t-1, u_t, theta ) + f_t
% so the input for f must be shifted by one

u = [nan, dt.stim_chosen(1:end-1)'  ;  % chosen stim        % used in f
     nan, dt.reward(1:end-1)'       ;  % reward             % used in f
     dt.stim1'                      ;  % index stim 1       % used in g
     dt.stim2'                      ;  % index stim 2       % used in g
     dt.forced'                     ]; % forced choice flag % used in g
 
skip_flag = dt.new_block';

%% save parameter names and trafos

theta = struct();
theta(1).name = '\alpha';
theta(1).trafo = @(x) VBA_sigmoid(x);

theta(2).name = 'k';
theta(2).trafo = @(x) exp(x);

phi = struct();

phi(1).name = '\beta';
phi(1).trafo = @(x) exp(x);

save('+models/+EU_hard_convex_grohn/param_info_EU_hard_convex_grohn.mat', 'theta', 'phi')

%% set options

% provide dimensions
dim = struct( ...
    'n',        4, ... number of hidden states (1-4: values)
    'n_theta',  2, ... number of evolution parameters (1: learning rate, 2: compression factor)
    'n_phi',    1 ... number of observation parameters (1: softmax temperature)
    );

options = [];

% Display main window?
options.DisplayWin = DISP;

% label source 1 as 1
options.sources(1).out = 1; 

% observations are binary (i.e. type 1, as opposed to type 0, which is real numbers)
options.sources(1).type = 1;

% set priors for internal states
options.priors.muX0 = Q0 * ones(4,1);
options.priors.SigmaX0 = 0.000001 * eye(4);

% priors for evolution params
options.priors.muTheta = [-1; -3];
options.priors.SigmaTheta = eye(2) * 2;
options.priors.SigmaTheta(2,2) = 4;

% priors for observation params
options.priors.muPhi = -2;
options.priors.SigmaPhi = 2;

% hyper hyper
options.priors.a_sigma(1) = 1;
options.priors.b_sigma(1) = 1;

% Normally, the expected first observation is g(x1), ie. after
% a first iteratition x1 = f(x0, u0). The skipf flag will prevent this evolution
% and thus set x1 = x0
options.skipf = skip_flag;

% adjust for multiple sessions
options.multisession.split = diff(find([skip_flag,1]));
options.multisession.fixed.theta = 1:dim.n_theta;
options.multisession.fixed.phi = 1:dim.n_phi;

%% invert model

[posterior, out] = VBA_NLStateSpaceModel(y, u, ...
    @models.EU_hard_convex_grohn.f_EU_hard_convex_grohn, ...
    @models.EU_hard_convex_grohn.g_EU_hard_convex_grohn, ...
    dim, options);

end



