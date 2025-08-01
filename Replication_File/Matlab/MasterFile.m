%==========================================================================
% MasterFile.m
%
% This is the master script that executes all model simulations for 
% Chapter 1 of the paper. It runs multiple scenarios to analyze the 
% role of skill levels and capital in economic output, using different 
% configurations of the Solow and Malthusian models.
%
% Author: Sreyphea Chheang
% Last Modified: March 12, 2025
%==========================================================================

clear;
clc;

% Set working directory to the folder containing all simulation scripts
cd('/Users/Phea/Desktop/Ch1/WorkCode');

% Run simulation to find the optimal gamma value and plot wage rates
run Wage_Main.m;

% Run Solow model with a production function including high-skill labor under PiH cases
run SolowHL_PiH_GDP_Main.m;

% Run Malthusian model with a production function excluding capital and high-skill labor
run Malthus_GDP_Main.m;

% Run Solow model with a production function excluding high-skill labor
run Solow_GDP_Main.m;

% Run Solow model with a production function including high-skill labor
run SolowHL_GDP_Main.m;

