%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Simulation Script: SolowHL_PiH_GDP_Main.m
%
% Objective:
%   Simulates three scenarios of skill composition (πᴴ, πᴸ) to analyze their 
%   effects on GDP and GDP per capita over time using a Solow growth model.
%
% Description:
%   - Runs simulations for different high-skill (πᴴ) and low-skill (πᴸ) probabilities.
%   - Compares actual vs. counterfactual scenarios by computing relative GDP and 
%     GDP per capita.
%   - Uses calibrated gamma parameters to match observed wage data.
%   - Generates LaTeX-compatible tables and plots.
%
% Dependencies:
%   1. LoadInputData.m         - Loads demographic and economic parameters
%   2. SimulatePopulationHL.m  - Simulates skill-specific population dynamics
%   3. SearchGammaHL.m         - Estimates skill-specific gamma parameters
%   4. LaborHL.m               - Computes effective labor inputs
%   5. OutputYHL.m             - Computes output (Y), capital (K), land (X)
%   6. SolowHL_PiH_GDP_Table.m - Generates LaTeX table of simulation results
%   7. Plot_PiH_3Cases.m       - Plot figures for visualizing results
%
% Author: Sreyphea Chheang
% Last Modified: March 12, 2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;


%% Load input data and parameters
[data] = LoadInputData();
SRate = data.SRate;
Coh   = data.Coh;
Hor   = data.Hor;
wdata = data.wdata;

%% Economic parameters
z = 0.1;                     % Land share in production
alpha = 0.3;                 % Capital share
beta = 1 - alpha - z;        % Labor share
delta = 0.07;                % Capital depreciation rate
rho = 0.9; eta = 0.9;        % Substitution parameters 
lambda = 2/3;                % Matching function parameter
ggy   = 1.011;               % Growth rate of output
KX_SRate = 0.0855;           % Saving rate for Capital and Land

%% Define simulation scenarios for (piH, piL)
piH_values = [0.29505, 0.60000, 0.80000];       % Probabilities of being high-skill
piL_values = [0.100, 0.05673, 0.02836];         % Probabilities of being low-skill
n = length(piH_values);                         % Number of scenarios

%% Initialize storage containers for results

RelGDP_all = cell(1, n); RelGDPpca_all = cell(1, n);

TotPopH_all = cell(1, n);
TotPopL_all = cell(1, n);
theta_all = cell(1, n);

%% Loop through each scenario
for i = 1:n
    % Set current scenario parameters
    params = struct('piH', piH_values(i), 'piL', piL_values(i));
    
    % Simulate population structure
    results = SimulatePopulationHL(data, params);

    % Extract actual population
    theta     = results.theta;
    popH      = results.popH; 
    popL      = results.popL;
    popSim    = results.popSim; 
    TotPopSim = results.TotPopSim;

    % Extract counterfactual population
    theta_cf = results.theta_cf;
    popH_cf  = results.popH_cf; 
    popL_cf  = results.popL_cf;
    popCF    = results.popCF; 
    TotPopCF = results.TotPopCF;

    theta_all{i}   = theta;
    TotPopH_all{i} = results.TotPopH;
    TotPopL_all{i} = results.TotPopL;

    %% Construct saving rates (actual and counterfactual)
    % Set constant saving rates with exception during Pol Pot regime (1975)
    sigmaK = ones(1, Hor) * KX_SRate; sigmaK(1,6) = 0;
    sigmaX = ones(1, Hor) * KX_SRate; sigmaX(1,6) = 0;
    sigmaH = ones(Coh, Hor) .* SRate(:,2); sigmaH(:,6) = 0;
    sigmaL = ones(Coh, Hor) .* SRate(:,3); sigmaL(:,6) = 0;

    % Counterfactual saving rates (constant)
    sigmaK_cf = ones(1, Hor) * KX_SRate;
    sigmaX_cf = ones(1, Hor) * KX_SRate;
    sigmaH_cf = ones(Coh, Hor) .* SRate(:,2);
    sigmaL_cf = ones(Coh, Hor) .* SRate(:,3);

    %% Estimate optimal gamma 
    InputHL = struct('z', z, 'alpha', alpha, 'beta', beta, ...
        'rho', rho, 'eta', eta, 'lambda', lambda, 'delta', delta, ...
        'ggy', ggy, 'Hor', Hor, 'wdata', wdata, ...
        'sigmaK', sigmaK, 'sigmaX', sigmaX, ...
        'sigmaL', sigmaL, 'sigmaH', sigmaH, ...
        'theta', theta, 'popL', popL, 'popH', popH, ...
        'pop', popSim, 'TotPop', TotPopSim);

    gamma_init = ones(11,1) * 0.1;  % Initial guess
    options = optimoptions(@fsolve, 'Algorithm', 'levenberg-marquardt', 'PlotFcns', @optimplotfval);
    bestGamma = fsolve(@(gamma) SearchGammaHL(gamma, InputHL), gamma_init, options);

    %% Compute actual labor and output

    [L, Omega_tild] = LaborHL(bestGamma, InputHL);

    [Y, K, X] = OutputYHL(L, Omega_tild, InputHL);

    %% Compute counterfactual labor and output
    InputHL_cf = struct('z', z, 'alpha', alpha, 'beta', beta, ...
        'rho', rho, 'eta', eta, 'lambda', lambda, 'delta', delta, ...
        'ggy', ggy, 'Hor', Hor, 'wdata', wdata, ...
        'sigmaK', sigmaK_cf, 'sigmaX', sigmaX_cf, ...
        'sigmaL', sigmaL_cf, 'sigmaH', sigmaH_cf, ...
        'theta', theta_cf, 'popL', popL_cf, 'popH', popH_cf, ...
        'pop', popCF, 'TotPop', TotPopCF);

    [L_cf, Omega_tild_cf] = LaborHL(bestGamma, InputHL_cf);

    [Y_cf, K_cf, X_cf] = OutputYHL(L_cf, Omega_tild_cf, InputHL_cf);

    %% Store counterfactual results
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
    mod_name(j) = "$\pi^H$ = " + sprintf('%.2f', piH_values(j)) + " and " + "$\pi^L$ = " + sprintf('%.2f', piL_values(j));
end

% Make the table
SolowHL_PiH_GDP_Table(mod_name, RelGDP, RelGDPpca, n, 'Tables/SolowHL_GDP_PiH_3Cases.tex');


%% Plot PiH three Cases: Theta0, TotPopH, TotPopL
% unpacked year
year = data.year;

Plot_PiH_3Cases(theta_all, '$\theta_{0,t}$ values', 'southwest', 'Graphs/theta3cases2')
Plot_PiH_3Cases(TotPopH_all, 'Total high-skilled population, $P^H_t$', 'northwest', 'Graphs/popH3cases')
Plot_PiH_3Cases(TotPopL_all, 'Total low-skilled population, $P^L_t$', 'northwest', 'Graphs/popL3cases')