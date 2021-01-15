import numpy as np
import pandas as pd

csv = pd.read_csv("Sale_Counts_City.csv", index_col=['RegionName', 'StateName'])
print(csv)
print(csv.loc[('Dallas','Texas')])
