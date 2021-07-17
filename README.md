# An-Association-Between-Prediction-Errors-and-Risk-Seeking-Theory-and-Behavioral-Evidence

Contains all the code needed to reproduce the figures and stats given in [An Association between prediction errors and risk-seeking--theory and behavioral evidence](https://doi.org/10.1371/journal.pcbi.1009213).

***

### Dependencies

Fitting is based on the [VBA toolbox](https://mbb-team.github.io/VBA-toolbox/). To run the scripts in this repo, you need to download and install the toolbox. We also use several other external functions. All of them need to be downloaded and added to the Matlab path.

- [Brewermap](https://github.com/DrosteEffect/BrewerMap)
- [Export_fig](https://github.com/altmany/export_fig)
- [ShadedErrorBar](https://github.com/raacampbell/shadedErrorBar)
- [Shuffle](https://www.mathworks.com/matlabcentral/fileexchange/27076-shuffle)

***

### Reproduce figures

Scripts that produce the figures are in `figure_scripts`. They will plot components of the figures and save .png versions of them in the `figures` folder. 

Produce the components of all figures by running 

```
main_figures
```

Produce the components of a single figure by running the corresponding function from `+figure_scripts`, for example

```
figure_scripts.fig_2_behaviour()
```

***

### Reproduce fits and simulations

The simulations and fits needed for the figures are already contained in the repository---it is not necessary to run all fits and simulations from scratch. To run the fits and simulations from scratch, run

```
main_fits_and_sim
```

***WARNING!*** This will overwrite existing files in the data folder with newly generated data. 

***WARNING!*** Some of the simulation scripts will take very long.

***

### Get data

If you want to run your own analyses, and just need the data, run

```
dt = data_prep.load_data('plosCB2021');
```

This will give you a table `dt` with all relevant data in it.
