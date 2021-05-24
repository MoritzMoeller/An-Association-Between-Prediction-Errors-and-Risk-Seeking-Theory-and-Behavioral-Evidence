function model_names = load_model_names()

D = open('/Users/moritzmoeller/Repos/madan2014/models/model_names.mat');
model_names = D.model_names;
end