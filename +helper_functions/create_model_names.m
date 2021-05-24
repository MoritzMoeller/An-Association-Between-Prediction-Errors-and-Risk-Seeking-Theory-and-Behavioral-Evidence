function create_model_names()

model_names = struct();

% RW
model_names.RW = "RW";

% UTIL models
model_names.EU_hard_concave_grohn = "concave UTIL";
model_names.EU_hard_convex_grohn = "convex UTIL";
model_names.PU_hard_grohn = "s-shaped UTIL";
model_names.PU_inv_hard_grohn = "inv. s-shaped UTIL";

% other alternative explanations
model_names.PN = "pos.-neg. RATES";
model_names.VAR = "variance RATES";
model_names.ATTENTION = "attention RATES";

% Prediction error scalinf
model_names.SCALED = "scaled PE";

% PEIRS family
model_names.PEIRS = "PEIRS";
model_names.PIRS = "PIRS";
model_names.OEIRS = "OEIRS";

save('/Users/moritzmoeller/Repos/madan2014/models/model_names.mat','model_names')

end
