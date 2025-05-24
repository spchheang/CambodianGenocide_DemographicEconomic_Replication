# CambodianGenocide_DemographicEconomic_Replication
# Replication code for the paper: The Demographic and Economic Effects of the Cambodia Genocide

This Replication combines **Stata** and **MATLAB** to simulate demographic and economic scenarios, specifically focusing on Cambodia. The objective is to analyze population dynamics and economic outcomes under actual and counterfactual scenarios for academic research paper.


## **Step 1: Understand the Data Sources**

There are **12 primary data files**, covering:

### **Cross-Country Data (Cambodia, Thailand, Vietnam)**

1. Population
2. Fraction of population

### **Cambodia-Specific Data**

1. Actual survival rate
2. Fertility rate
3. Actual population (by cohort and gender)
4. Female and male population fractions
5. UN migration data
6. 2010 wage rate
7. Thai saving rate (used as proxy for Cambodia)

### **Counterfactual Variables (Created in Stata)**

1. Counterfactual survival rate
2. Counterfactual fertility rate
3. Actual and counterfactual migration factors
4. Fraction of female population
5. High, low, and average wage rates
6. High, low, and average saving rates

---

## **Step 2: Prepare Data with Stata**

Use **Stata** for:

* Cleaning and transforming raw demographic data
* Constructing counterfactual variables
* Aggregating or formatting variables to feed into MATLAB simulations

**Output from Stata is saved as CSV files** and loaded into MATLAB using scripts like `LoadInputData.m`.

---

## **Step 3: Run Simulations in MATLAB**

MATLAB handles all simulation, computation, plotting, and table generation tasks.

### **Main MATLAB Script**

* `MasterFile.m` – the central script that coordinates all simulations and visualizations. It calls the following key scripts:

#### **1. Wage Simulation**

* `Wage_Main.m`
  Simulates wage evolution to find the optimal gamma value and plots actual vs. predicted wage rates.

#### **2. Solow Model with High-Skill Labor under PiH Cases**

* `SolowHL_PiH_GDP_Main.m`
  Runs simulations using the Solow production function, incorporating high-skill labor, under different high-skill transition probabilities (PiH).

#### **3. Malthusian Model**

* `Malthus_GDP_Main.m`
  Runs a simpler model excluding capital and high-skill labor.

#### **4. Solow Model (No High-Skill Labor)**

* `Solow_GDP_Main.m`
  Simulates economic output excluding high-skill labor, focusing on baseline Solow dynamics.

#### **5. Solow Model (With High-Skill Labor)**

* `SolowHL_GDP_Main.m`
  Includes high-skill labor in the production function to evaluate its impact on output.

---

## **Outputs**

Each model produces:

* Simulated population matrices
* Economic outputs (GDP, capital, land)
* Plots and figures for analysis
* Tables ready for use in research papers

---

## **Final Notes**

* Always run `MasterFile.m` to execute the full analysis pipeline.
* Ensure all CSV input files from Stata are available in the `InputData/` directory.
* Modular design allows flexibility: you can run each script independently if needed.



