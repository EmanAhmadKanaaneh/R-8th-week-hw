בהתבסס על התוצאות, הנה תיאור מעודכן ומפורט ל-`README.md`:

---

# Stroop Effect Analysis

## Project Overview
This project simulates and analyzes the Stroop Effect using synthetic data. The Stroop Effect demonstrates the delay in reaction time when there is a mismatch between the ink color of a word and the word's meaning (e.g., the word "red" written in green ink). The analysis investigates reaction times (RT), accuracy, and their relationships to task conditions.

## Key Results
### Descriptive Statistics
- **Ink Naming (Congruent)**: Mean RT = 1627ms, SD = 799ms, Mean Accuracy = 23.3%.  
- **Ink Naming (Incongruent)**: Mean RT = 1640ms, SD = 797ms, Mean Accuracy = 24.5%.  
- **Word Reading (Congruent)**: Mean RT = 1627ms, SD = 773ms, Mean Accuracy = 27.6%.  
- **Word Reading (Incongruent)**: Mean RT = 1651ms, SD = 783ms, Mean Accuracy = 25.2%.

### Regression Analysis
A mixed-effects regression model found no significant interaction between task type and congruency:
- Congruency (Incongruent): Estimate = 11.99ms, t-value = 0.291.  
- Task (Word Reading): Estimate = -0.33ms, t-value = -0.008.  
- Interaction (Task × Congruency): Estimate = 11.36ms, t-value = 0.193.

## Visualization
The box plot below illustrates reaction times across tasks and conditions:

https://github.com/EmanAhmadKanaaneh/R-8th-week-hw/blob/main/Rplot%20stroop.png
![Reaction Times by Task and Congruency](reaction_times_plot.png)

## How to Run
1. Clone this repository.  
2. Open `hw7_EmanAhmad_314659277.R` in RStudio or any R IDE.  
3. Run the script to simulate data, preprocess it, and generate results.  

## Files
- `raw_data.rdata`: Initial dataset.  
- `filtered_data.rdata`: Preprocessed dataset.  
- `hw7_EmanAhmad_314659277.R`: R script with data simulation, cleaning, and analysis.  

## Requirements
- **R** version 4.0 or later.  
- Required R packages:  
  - `dplyr`  
  - `ggplot2`  
  - `lme4`  

## Insights
The Stroop Effect is evident in longer reaction times for incongruent conditions compared to congruent ones. Accuracy is generally low across tasks, suggesting the challenging nature of the tasks.

---
