SAVE = 1;

D = load('../Reward-prediction-errors-induce-risk-seeking/data_table.mat');
dt = ready_dt_grohn(D.data_table, 1);

if SAVE
    set(gcf, 'Color', 'none');
    export_fig '/Users/moritzmoeller/Dropbox/PEIRS/Fig S1 - performance/components/exclude_thresh.png' -m4
end