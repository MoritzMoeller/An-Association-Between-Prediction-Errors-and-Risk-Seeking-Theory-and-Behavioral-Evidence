function model_names = load_model_names()

model_names = struct();

% RW
model_names.RW = "RW";

% UTIL models
model_names.concave_UTIL = "concave UTIL";
model_names.convex_UTIL = "convex UTIL";
model_names.s_shaped_UTIL = "s-shaped UTIL";
model_names.inverse_s_shaped_UTIL = "inv. s-shaped UTIL";

% other alternative explanations
model_names.pos_neg_RATES = "pos.-neg. RATES";
model_names.variance_RATES = "variance RATES";
model_names.attention_RATES = "attention RATES";

% Prediction error scaling
model_names.scaled_PE = "scaled PE";

% PEIRS family
model_names.PEIRS = "PEIRS";
model_names.PIRS = "PIRS";
model_names.OEIRS = "OEIRS";

end