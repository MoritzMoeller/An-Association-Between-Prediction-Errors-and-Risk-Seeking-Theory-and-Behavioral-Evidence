# An-Association-Between-Prediction-Errors-and-Risk-Seeking-Theory-and-Behavioral-Evidence

Contains all the code needed to reproduce the figures and stats given in [An Association between prediction errors and risk seeking--theory and behavioral evidence](https://www.biorxiv.org/content/10.1101/2020.04.29.067751v2.full).

### Prerequisits

* Fitting in based on the [VBA toolbox](https://mbb-team.github.io/VBA-toolbox/). To run the scripts in this repo, you need to download and install it.
* For plots, we use colors from brewermap (https://github.com/DrosteEffect/BrewerMap). The brewermap function needs to be downloaded and added to the path.
* To save plots as in png format, we use the export_fig function (https://github.com/altmany/export_fig). Download and add to path.
* Shaded Error Bar https://github.com/raacampbell/shadedErrorBar
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
dt = data_prep.load_data('grohn');
```

This will give you a table `dt` with all relevant data in it.


### TODO

* Rename models like in manuscript
* Change names like 'grohn' datasets
* Remove comments
* Clean up get_model_names. Maybe loose it, if models are named well from outset.
* put all data in a data folder

