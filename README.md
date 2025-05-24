## Replication Code for the Paper: *The Demographic and Economic Effects of the Cambodian Genocide*

This repository contains replication files that use **Stata** and **MATLAB** to simulate demographic and economic scenarios, with a focus on Cambodia. The objective is to analyze population dynamics and economic outcomes under both actual and counterfactual scenarios for academic research purposes.

---

## Step 1: Understand the Data Sources

### Data Sources Used in This Paper

1. **United Nations Population Division (UNPD)** – covering the period 1950–2020  
   The primary dataset is obtained from the United Nations Population Division:  
   [https://www.un.org/development/desa/pd/](https://www.un.org/development/desa/pd/)

   Extracted data include:
   - Annual population by age groups (both sexes) for Cambodia, Thailand, and Vietnam  
   - Annual female and male population by age groups  
   - Age-specific fertility rates (ASFR)  
   - Bridged life tables (both sexes)  
   - Aggregate migrant data  

2. **Saving Rate Data**  
   Taken from Angus Deaton and Christina Paxson’s (1999) paper, *"Growth and Saving among Individuals and Households"*, specifically Figure 2 on page 215.  
   Since official Cambodian saving rate data is unavailable, the **Thai saving rate** is used as a proxy.

3. **Wage Data**  
   Based on the 2010 Cambodia Socio-Economic Survey (CSES), and referenced in Humphreys (2015):  
   *"Education Premiums in Cambodia: Dummy Variables Revisited and Recent Data."*

---

## Step 2: Prepare Data with Stata

**Stata** is used to:

- Clean and transform raw demographic data
- Construct counterfactual variables:
  1. Counterfactual survival rate  
  2. Counterfactual fertility rate  
  3. Actual and counterfactual migration factors  
  4. Fraction of the female population  
  5. High-, low-, and average-skilled wage rates  
  6. High-, low-, and average-skilled saving rates  

- Aggregate and format variables for input into MATLAB simulations

---

**Outputs from Stata are saved as CSV files** and loaded into MATLAB using scripts such as `LoadInputData.m`.

### CSV Files Imported into MATLAB

1. Actual population and fraction of the female population  
2. Actual age-specific survival and fertility rates  
3. Counterfactual age-specific survival and fertility rates  
4. Actual and counterfactual migration factors  
5. Aggregate migrant data  
6. Average saving rates (log and non-log)  
7. Saving rates by skill level (average, high-skilled, and low-skilled)  
8. 2010 wage data by skill level (average, high-skilled, and low-skilled)  

---

## Step 3: Run Simulations in MATLAB

MATLAB performs the simulations, computations, plotting, and table generation.

### Main Script

- `MasterFile.m` – This is the master script that coordinates all simulations and visualizations by calling the key modules below.

### Simulation Modules

1. **Wage Simulation**  
   - `Wage_Main.m`: Simulates wage evolution to determine the optimal gamma value and plots actual vs. predicted wages.

2. **Solow Model with High-Skill Labor (PiH Cases)**  
   - `SolowHL_PiH_GDP_Main.m`: Uses the Solow model with high-skill labor under varying transition probabilities for high-skill acquisition (PiH).

3. **Malthusian Model**  
   - `Malthus_GDP_Main.m`: Implements a basic model excluding capital and high-skill labor.

4. **Solow Model without High-Skill Labor**  
   - `Solow_GDP_Main.m`: Simulates economic output using a basic Solow framework without high-skill labor.

5. **Solow Model with High-Skill Labor**  
   - `SolowHL_GDP_Main.m`: Adds high-skill labor to the production function and evaluates its contribution to GDP.

---

## Outputs

Each model generates the following:

- Simulated population matrices  
- Economic indicators (GDP, capital, land)  
- Plots and figures for visual analysis  
- Tables for academic publication and reporting

---

## Final Notes

- Always start with `MasterFile.m` to execute the full pipeline.  
- Make sure all CSV input files from Stata are placed in the `InputData/` directory.  
- The modular structure allows you to run each script independently as needed.
