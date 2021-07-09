function create_model_names()

model_names = struct();

% RW
model_names.RW = "RW";

% UTIL models
model_names.concave-UTIL = "concave UTIL";
model_names.convex-UTIL = "convex UTIL";
model_names.s-shaped-UTIL = "s-shaped UTIL";
model_names.inverse-s-shaped-UTIL = "inv. s-shaped UTIL";

% other alternative explanations
model_names.pos-neg-RATES = "pos.-neg. RATES";
model_names.variance-RATES = "variance RATES";
model_names.attention-RATES = "attention RATES";

% Prediction error scalinf
model_names.scaled-PE = "scaled PE";

% PEIRS family
model_names.PEIRS = "PEIRS";
model_names.PIRS = "PIRS";
model_names.OEIRS = "OEIRS";

save('/Users/moritzmoeller/Repos/madan2014/models/model_names.mat','model_names')

end
