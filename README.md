# An-Association-Between-Prediction-Errors-and-Risk-Seeking-Theory-and-Behavioral-Evidence

Contains all the code needed to reproduce the figures and stats given in [An Association between prediction errors and risk seeking--theory and behavioral evidence](https://www.biorxiv.org/content/10.1101/2020.04.29.067751v2.full).

### Prerequisits

Fitting in based on the [VBA toolbox](https://mbb-team.github.io/VBA-toolbox/). To run the scripts in this repo, you need to download and install it.

### Reproduce the figures

Scripts that produce the figures are in `figure_scripts`. Run one to produce the figure and save it as a .png into the `figures` folder.

### Get the data

If you want to run your own analyses, and just need the data, run

```
dt = data_prep.load_data('grohn');
```

This will give you a table with all relevant data in it.