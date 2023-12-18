# A walk-through of the DDI pipeline 

## Introduction 
This file will provide a walk-through of our DDI pipeline using sample datasets.

### Sample datasets
1. There are four CSV files provided in the [Example_samples](Example_samples) corresponding to the Control case, Disease 1 (say disease "x") only, Disease 2 (say disease "y") only, and both Disease 1 and 2 occurring together.
2. Each of the sample cohorts is of dimensions 50 (samples) X 7 (variables; "A", "B", "C", "D", "E", "S_x" and "S_y").   
3. "A", "B", "C", "D", and "E" are continuous variables, and "D" is a covariate.
4.  "S_x" and "S_y" denote the status of each disease (x and y) in the sample cohorts. They are discrete variables that take 1 or 0 indicating the presence or absence of the disease.

### Calling the function:
Keep the working directory (wk_dir) to the path containing the four sample cohorts.
```R
MI_samples <- MI_function(Control_data = Sample_Control, Disease_1_data = Sample_Disease_1, Disaese_2_data = Sample_Disease_2,
                          Disease_1_2_data = Sample_Disease_1_and_2.csv,covariates = c("D","S_x","S_y"),disease_terms = c("S_x","S_y"), cut_off = 0.05,wk_dir = wk_dir)

```
### Outputs
Running the DDI pipeline on the sample cohorts would output:

1. "A", "B", "C", and "E" as main effect variables. 
2. "A", "B", and "C" as interaction effect variables.
3. **MI_FUNCTION_OUTPUT.csv** generated for this example is provided in [Example_output](Example_output).

Please refer to **Step_2a_and_2b_help.md** for more details.











