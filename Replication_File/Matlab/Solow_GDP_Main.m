%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Simulation File: Solow_GDP_Main.m
%
% Description:
% This script computes relative GDP and GDP per capita under a Solow-style 
% growth model with land, labor, and capital. It compares actual and 
% counterfactual economic scenarios by varying the substitution parameter 
% (rho), estimating optimal gamma values, and simulating demographic and 
% economic structures.
%
% Uses Support Files:
%   1. LoadInputData.m       - Loads demographic and economic input data
%   2. SimulatePopulation.m  - Simulates actual and counterfactual populations
%   3. SearchGamma.m         - Estimates optimal gamma via numerical solver
%   4. Labor.m               - Calculates labor input and composite efficiency
%   5. OutputY.m             - Computes economic output using the Solow model
%   6. Solow_GDP_Table.m     - Formats and exports GDP metrics into LaTeX
%
% Notes:
% - Simulates two different cases of the substitution parameter (rho).
% - Outputs include LaTeX table of 2010 GDP metrics and CSV for plotting.
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
alpha = 0.3;                 % Capital share
beta = 1 - alpha - z;        % Labor share
delta = 0.07;                % Capital depreciation rate
ggy = 1.011;                 % Growth rate of output
KX_SRate = 0.0855;           % Saving rate for Capital and Land

%% Define simulation scenarios for substitution parameters (rho) 
rho_values = [0.9, 0.5];
n = length(rho_values);      % Number of scenarios

%% Initialize storage containers for results
RelGDP_all = cell(1, n); RelGDPpca_all = cell(1, n);

%% Loop through each scenario
for i = 1:n
    % Set current scenario parameters
    rho = rho_values(i);
    
    % Simulate population structure
    results = SimulatePopulation(data);

    pop_sim = results.pop_sim; 
    TotPopSim = results.TotPopSim;

    % Extract counterfactual population
    pop_cf = results.pop_cf; 
    TotPopCF = results.TotPopCF;

     %% Construct saving rates (actual and counterfactual)
    % Set constant saving rates with exception during Pol Pot regime (1975)
    sigmaK = ones(1, Hor) * KX_SRate; sigmaK(1,6) = 0;
    sigmaX = ones(1, Hor) * KX_SRate; sigmaX(1,6) = 0;
    % Saving rate for Labor
    sigmaW = ones(Coh, Hor) .* SRate(:,1); sigmaW(:,6) = 0; 

    % Counterfactual saving rates (constant)
    sigmaK_cf = ones(1, Hor) * KX_SRate;
    sigmaX_cf = ones(1, Hor) * KX_SRate;
    % Saving rate for Labor
    sigmaW_cf = ones(Coh, Hor) .* SRate(:,1);

    %% Estimate optimal gamma 
    Input = struct('z', z, 'alpha', alpha, 'beta', beta, 'delta', delta, ...
        'rho', rho, 'ggy', ggy, 'Hor', Hor, 'wdata', wdata, ...
        'sigmaK', sigmaK, 'sigmaX', sigmaX, 'sigmaW', sigmaW, ...
        'TotPop', TotPopSim, 'pop', pop_sim);
         
    gamma_init = ones(11,1) * 0.1;  % Initial guess
    options = optimoptions(@fsolve, 'Algorithm', 'levenberg-marquardt', 'PlotFcns', @optimplotfval);
    bestGamma = fsolve(@(gamma) SearchGamma(gamma, Input), gamma_init, options);

    gamma = [zeros(3,1); bestGamma; zeros(7,1)];
    gamma = gamma ./ sum(gamma);  % Normalize gamma

    %% Compute actual labor and output
    [L, Omega] = Labor(bestGamma, Input);
    [Y] = OutputY(L, Omega, Input);

    %% Compute counterfactual labor and output
    Input_cf = struct('z', z, 'alpha', alpha, 'beta', beta, 'delta', delta, ...
        'rho', rho, 'ggy', ggy, 'Hor', Hor, 'wdata', wdata, ...
        'sigmaK', sigmaK_cf, 'sigmaX', sigmaX_cf, 'sigmaW', sigmaW_cf, ...
        'TotPop', TotPopCF, 'pop', pop_cf);

    [L_cf, Omega_cf] = Labor(bestGamma, Input_cf);
    [Y_cf] = OutputY(L_cf, Omega_cf, Input_cf);

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
Solow_GDP_Table(mod_name, RelGDP, RelGDPpca, n, 'Tables/Solow_GDP.tex');

% Extract the first Relative GDP per Capita (rho=0.9, and eta=0.9)
RelGDPpca_Solow = RelGDPpca_all{1,1};

% Store to the data for graph
writematrix(RelGDPpca_Solow, 'InputData/RelGDPpca_Solow.csv');