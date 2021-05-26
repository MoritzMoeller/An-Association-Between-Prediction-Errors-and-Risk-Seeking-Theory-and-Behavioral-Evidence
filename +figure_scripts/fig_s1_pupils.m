function fig_s1_pupils()

dt = data_prep.load_data('grohn');
dt = data_prep.add_latent(dt, 'grohn', 'PEIRS');

%% Hierachical fits

plot_functions.plot_pupil_stim_PE_hierarchical(dt, 1)
plot_functions.plot_pupil_out_PE_hierarchical(dt, 1)

end