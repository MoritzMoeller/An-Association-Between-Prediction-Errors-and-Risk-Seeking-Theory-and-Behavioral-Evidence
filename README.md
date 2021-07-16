# An-Association-Between-Prediction-Errors-and-Risk-Seeking-Theory-and-Behavioral-Evidence

Contains all the code needed to reproduce the figures and stats given in [An Association between prediction errors and risk seeking--theory and behavioral evidence](https://www.biorxiv.org/content/10.1101/2020.04.29.067751v2.full).

### Dependencies

* Fitting is based on the [VBA toolbox](https://mbb-team.github.io/VBA-toolbox/). To run the scripts in this repo, you need to download and install it.

We also use several external functions. All of them need to be downloaded and added to the Matlab path.

* Brewermap (https://github.com/DrosteEffect/BrewerMap)
* Export_fig (https://github.com/altmany/export_fig)
* ShadedErrorBar (https://github.com/raacampbell/shadedErrorBar)
* Shuffle (https://www.mathworks.com/matlabcentral/fileexchange/27076-shuffle)

### Reproduce the figures

Scripts that produce the figures are in `figure_scripts`. They will plot the component parts and save PNGs of them in the `figures` folder.

Produce the component parts of all figures by running 

```
main_figures
```

Produce the component parts of a single figure by running the corresponding function from `+figure_scripts`, for example

```
figure_scripts.fig_2_behaviour()
```

### Get the data

If you want to run your own analyses, and just need the data, run

```
dt = data_prep.load_data('plosCB2021');
```

This will give you a table `dt` with all relevant data in it.
