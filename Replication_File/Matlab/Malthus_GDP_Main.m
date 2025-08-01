
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Simulation File: Malthus_GDP_Main.m
%
% Description:
% This script computes relative GDP and GDP per capita under a Malthusian 
% framework by simulating demographic and economic structures using two 
% different values of the substitution parameter (rho). The model calibrates 
% production parameters to match wage data, computes labor input and output, 
% and compares actual vs. counterfactual scenarios.
%
% Dependencies:
%   1. LoadInputData.m         - Loads initial data and model parameters
%   2. SimulatePopulation.m    - Simulates population structure (actual and counterfactual)
%   3. Malthus_SearchGamma.m   - Calibrates gamma parameters via fsolve
%   4. Labor.m                 - Computes effective labor supply
%   5. Malthus_OutputY.m       - Computes economic output (GDP)
%   6. Malthus_GDP_Table.m     - Formats and saves GDP comparison results to LaTeX
%
% Output:
%   - LaTeX table of relative GDP and GDP per capita in 2010
%   - CSV file of relative GDP per capita across all years for plotting
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;

%% Load input data and parameters
[data] = LoadInputData();
SRate = data.SRate;
Coh   = data.Coh;
Hor   = data.Hor;
wdata = data.wdata;

%% Economic parameters
z = 0.1;                     % Land share in production
beta = 1 - z;                % Labor share
ggy = 1.011;                 % Growth rate of output

%% Define simulation scenarios for substitution parameters (rho) 
rho_values = [0.9, 0.5];
n = length(rho_values);      % Number of scenarios

% Saving rate for labor (not used directly in this model; only serves 
% as input to the labor function for calculating Omega)
sigmaW = ones(Coh, Hor) .* SRate(:,1); sigmaW(:,6) = 0; 
sigmaW_cf = ones(Coh, Hor) .* SRate(:,1);

%% Initialize storage containers for results
RelGDP_all = cell(1, n); RelGDPpca_all = cell(1, n);

%% Loop through each scenario
for i = 1:n
    % Set current scenario parameters
    rho = rho_values(i);
    
    % Simulate population structure
    results = SimulatePopulation(data);
    pop_sim   = results.pop_sim; 
    TotPopSim = results.TotPopSim;

    % Extract counterfactual population
    pop_cf   = results.pop_cf; 
    TotPopCF = results.TotPopCF;

    %% Calibrated optimal gamma 
    Input = struct('z', z, 'beta', beta, 'rho', rho,  ...
        'ggy', ggy, 'Hor', Hor, 'wdata', wdata, 'sigmaW', sigmaW, ...
        'TotPop', TotPopSim, 'pop', pop_sim);
         
    gamma_init = ones(11,1) * 0.1;  % Initial guess
    options = optimoptions(@fsolve, 'Algorithm', 'levenberg-marquardt', 'PlotFcns', @optimplotfval);
    bestGamma = fsolve(@(gamma) Malthus_SearchGamma(gamma, Input), gamma_init, options);

    %% Compute actual labor and output
    [L] = Labor(bestGamma, Input);
    [Y] = Malthus_OutputY(L, Input);

    %% Compute counterfactual labor and output
    Input_cf = struct('z', z, 'beta', beta, 'rho', rho,  ...
        'ggy', ggy, 'Hor', Hor, 'wdata', wdata,'sigmaW', sigmaW, ...
        'TotPop', TotPopCF, 'pop', pop_cf);
    
    [L_cf] = Labor(bestGamma, Input_cf);
    [Y_cf] = Malthus_OutputY(L_cf, Input_cf);

    %% Store actual results
    % Compute relative output metrics
    RelGDP_all{i} = Y ./ Y_cf;  % Relative GDP
    RelGDPpca_all{i} = (Y ./ TotPopSim) ./ (Y_cf ./ TotPopCF);  % Relative GDP per capita
end


%% Get the GDP and GDP per Capita in 2010
% Preallocate the RelGDP matrix
RelGDP = zeros(n, 1); RelGDPpca = zeros(n, 1); mod_name = strings(n,1);

% Extract the (1,13) value from each cell of RelGDP_all{i}

for j = 1:n
    RelGDP(j,1) = RelGDP_all{1,j}(1, 13);
    RelGDPpca(j,1) = RelGDPpca_all{1,j}(1, 13);
    mod_name(j) = "$\rho$ = " + rho_values(j);
end

% Make the table
Malthus_GDP_Table(mod_name, RelGDP, RelGDPpca, n, 'Tables/Malthus_GDP.tex');

% Extract the first Relative GDP per Capita (rho=0.9, and eta=0.9)
RelGDPpca_Malthus = RelGDPpca_all{1,1};

% Store to the data for graph
writematrix(RelGDPpca_Malthus, 'InputData/RelGDPpca_Malthus.csv');
