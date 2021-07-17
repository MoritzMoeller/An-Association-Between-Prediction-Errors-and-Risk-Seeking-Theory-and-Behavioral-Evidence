
import os
import re

main_dir = '/Users/moritzmoeller/Repos/An-Association-Between-Prediction-Errors-and-Risk-Seeking-Theory-and-Behavioral-Evidence/data/recovery_posterior_mc'

for root, dirs, files in os.walk(main_dir):
    d = {}
    for name in files:
        m = re.match('fit_(.*)_(.*).mat', name)
        if m:
            if m.group(1) in d.keys():
                if d[m.group(1)] > 99:
                    os.remove(os.path.join(root, name))
                else:
                    d[m.group(1)] += 1
            else:
                d[m.group(1)] = 1
