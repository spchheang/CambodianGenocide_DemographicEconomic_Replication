%==========================================================================
% Wage_Main.m
%
% Main simulation file for computing wage rates and plotting wage figures.
% This script estimates the optimal gamma parameters and simulates 
% population dynamics and output using skill-specific labor components.
%
% It uses the following support scripts/functions:
%   1. LoadInputData.m        - Loads demographic and wage data
%   2. SimulatePopulationHL.m - Simulates high- and low-skill population
%   3. SearchGammaHL.m        - Estimates gamma using fsolve
%   4. LaborHL.m              - Computes labor supply by skill
%   5. OutputYHL.m            - Computes economic output
%   6. PlotWage.m             - Generates wage comparison plots
%==========================================================================

clear;
clc;

%% -----------------------------------------------------------------------
%  Load Input Data and Parameters
% ------------------------------------------------------------------------
data   = LoadInputData();
SRate  = data.SRate;
Coh    = data.Coh;
Hor    = data.Hor;
wdata  = data.wdata;
wdataH = data.wdataH;
wdataL = data.wdataL;

%% -----------------------------------------------------------------------
%  Economic Parameters
% ------------------------------------------------------------------------
z       = 0.1;        % Land share in production
alpha   = 0.3;        % Capital share
beta    = 1 - alpha - z;  % Labor share
delta   = 0.07;       % Capital depreciation rate
lambda  = 2/3;        % High-skilled labor productivity
ggy     = 1.011;      % Output growth rate
KX_SRate = 0.0855;    % Saving rate for capital and land
rho     = 0.9;        % Substitution parameter (capital vs. land)
eta     = 0.9;        % Substitution parameter (low vs. high skill)

%% -----------------------------------------------------------------------
%  Simulation Parameters
% ------------------------------------------------------------------------
piH    = 0.29505;     % Probability of being high-skilled
piL    = 0.10;        % Probability of being low-skilled
params = struct('piH', piH, 'piL', piL);

% Simulate population structure
results     = SimulatePopulationHL(data, params);
theta       = results.theta;
popH        = results.popH;
popL        = results.popL;
popSim      = results.popSim;
TotPopSim   = results.TotPopSim;
TotPopCF    = results.TotPopCF;

% Save population simulation results
popSimData = [data.year', TotPopCF', TotPopSim', popSim'];
writematrix(popSimData, 'InputData/popSimData.csv');

%% -----------------------------------------------------------------------
%  Construct Saving Rates
% ------------------------------------------------------------------------
% Set constant saving rates with exception for Pol Pot regime (year 1975)
sigmaK = ones(1, Hor) * KX_SRate;  sigmaK(1,6) = 0;
sigmaX = ones(1, Hor) * KX_SRate;  sigmaX(1,6) = 0;
sigmaH = ones(Coh, Hor) .* SRate(:,2);  sigmaH(:,6) = 0;
sigmaL = ones(Coh, Hor) .* SRate(:,3);  sigmaL(:,6) = 0;

% Counterfactual (constant) saving rates
sigmaK_cf = ones(1, Hor) * KX_SRate;
sigmaX_cf = ones(1, Hor) * KX_SRate;
sigmaH_cf = ones(Coh, Hor) .* SRate(:,2);
sigmaL_cf = ones(Coh, Hor) .* SRate(:,3);

%% -----------------------------------------------------------------------
%  Estimate Optimal Gamma Using Nonlinear Solver
% ------------------------------------------------------------------------
InputHL = struct( ...
    'z', z, 'alpha', alpha, 'beta', beta, 'delta', delta, ...
    'rho', rho, 'eta', eta, 'lambda', lambda, 'ggy', ggy, ...
    'Hor', Hor, 'sigmaK', sigmaK, 'sigmaX', sigmaX, ...
    'TotPop', TotPopSim, 'theta', theta, 'popL', popL, ...
    'popH', popH, 'pop', popSim, 'sigmaL', sigmaL, ...
    'sigmaH', sigmaH, 'wdata', wdata, ...
    'wdataH', wdataH, 'wdataL', wdataL);

gamma_init = ones(11,1) * 0.1;  % Initial guess for gamma
options = optimoptions(@fsolve, ...
    'Algorithm', 'levenberg-marquardt', ...
    'PlotFcns', @optimplotfval);

bestGamma = fsolve(@(gamma) SearchGammaHL(gamma, InputHL), gamma_init, options);
writematrix(bestGamma, 'InputData/bestGamma.csv');

%% -----------------------------------------------------------------------
%  Create Table for Gamma and Saving Rates
% ------------------------------------------------------------------------
gamma = bestGamma ./ sum(bestGamma);  % Normalize gamma weights
Work_sigmaH = sigmaH(4:14,1);         % Working-age high-skill saving
Work_sigmaL = sigmaL(4:14,1);         % Working-age low-skill saving
AgeL = 15:5:65;
AgeH = 19:5:69;

n = length(gamma);
cohort_name = strings(1,n);

for j = 1:n
    cohort_name(j) = AgeL(j) + " - " + AgeH(j);
end

Gamma_Table(cohort_name, gamma, Work_sigmaH, Work_sigmaL, n, 'Tables/gamma_sigma.tex');

%% -----------------------------------------------------------------------
%  Plot Wage Results
% ------------------------------------------------------------------------
PlotWage(bestGamma, InputHL);
