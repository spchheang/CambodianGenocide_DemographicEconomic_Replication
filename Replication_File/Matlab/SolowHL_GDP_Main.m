% -------------------------------------------------------------------------
% Main simulation file: SolowHL_GDP_Main.m
%
% Purpose:
%   This script simulates and analyzes the impact of different substitution
%   parameters (rho and eta) on GDP and GDP per capita within a Solow-type 
%   growth model that distinguishes between high-skilled and low-skilled labor.
%
% Description:
%   The script executes four scenarios using combinations of (rho, eta) and 
%   evaluates their implications for actual and counterfactual economic outcomes.
%   It simulates population structure, calibrates production parameters,
%   computes capital, land, labor, and output, and produces relative GDP 
%   and GDP per capita metrics. Final results are summarized in LaTeX tables 
%   and used to generate figures.
%
% Dependencies (supporting scripts):
%   1. LoadInputData.m        - Loads demographic and wage data
%   2. SimulatePopulationHL.m - Simulates population with high/low-skill structure
%   3. SearchGammaHL.m        - Estimates optimal productivity parameters (gamma)
%   4. LaborHL.m              - Computes effective labor inputs
%   5. OutputYHL.m            - Calculates GDP, capital, land, and growth components
%   6. SolowHL_GDP_Table.m    - Generates LaTeX tables for GDP outcomes
%
% Outputs:
%   - Simulated time series of GDP and GDP per capita (actual and counterfactual)
%   - Relative GDP and GDP per capita comparisons across scenarios
%   - Decomposition of output effects (capital, land, labor)
%   - LaTeX-formatted output tables and graph figures
% -------------------------------------------------------------------------

clear; 
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
lambda = 2/3;                % High-skilled productivity parameter
ggy = 1.011;                 % Growth rate of output
KX_SRate = 0.0855;           % Saving rate for Capital and Land

%% Define simulation scenarios for substitution parameters (rho, eta) 
rho_values = [0.9, 0.9, 0.5 0.5];
eta_values = [0.9, 0.5, 0.9 0.5];
n = length(rho_values);      % Number of scenarios

%% Define simulation scenarios for (piH, piL)
piH = 0.29505;       % Probabilities of being high-skill
piL = 0.10;          % Probabilities of being low-skill

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

%% Initialize storage containers for results
Y_all = cell(1, n); K_all = cell(1, n); X_all = cell(1, n); L_all = cell(1, n);
Y_cf_all = cell(1, n); K_cf_all = cell(1, n); X_cf_all = cell(1, n); L_cf_all = cell(1, n);
ggK0_all = cell(1, n); ggX0_all = cell(1, n); ggL0_all = cell(1, n); ggP0_all = cell(1, n);
ggK0_cf_all = cell(1, n); ggX0_cf_all = cell(1, n); ggL0_cf_all = cell(1, n); ggP0_cf_all = cell(1, n);
TotPopSim_all = cell(1, n); TotPopCF_all = cell(1, n); PopSim_all = cell(1, n); PopCF_all = cell(1, n);
RelGDP_all = cell(1, n); RelGDPpca_all = cell(1, n);

sH_all     = cell(1, n);
sL_all     = cell(1, n);
sH_cf_all  = cell(1, n);
sL_cf_all  = cell(1, n);
sL0_all    = cell(1, n);
sL0_cf_all = cell(1, n);
sH0_all    = cell(1, n);
sH0_cf_all = cell(1, n);

%% Loop through each scenario
for i = 1:n
    % Set current scenario parameters
    rho = rho_values(i);
    eta = eta_values(i);

    params = struct('piH', piH, 'piL', piL);
    
    % Simulate population structure
    results   = SimulatePopulationHL(data, params);
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

    % Store results
    PopSim_all{i}    = popSim;
    TotPopSim_all{i} = TotPopSim;
    PopCF_all{i}     = popCF;
    TotPopCF_all{i}  = TotPopCF;

    sH_all{i}     = results.sH;
    sL_all{i}     = results.sL;
    sH_cf_all{i}  = results.sH_cf;
    sL_cf_all{i}  = results.sL_cf;
    sL0_all{i}    = results.sL0;
    sL0_cf_all{i} = results.sL0_cf;
    sH0_all{i}    = results.sH0;
    sH0_cf_all{i} = results.sH0_cf;

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

    [Y, K, X, ggK0, ggX0, ggL0, ggP0] = OutputYHL(L, Omega_tild, InputHL);

    % Store actual results
    Y_all{i} = Y; K_all{i} = K; X_all{i} = X; L_all{i} = L;
    ggK0_all{i} = ggK0; ggX0_all{i} = ggX0; ggL0_all{i} = ggL0; ggP0_all{i} = ggP0;

    %% Compute counterfactual labor and output
    InputHL_cf = struct('z', z, 'alpha', alpha, 'beta', beta, ...
        'rho', rho, 'eta', eta, 'lambda', lambda, 'delta', delta, ...
        'ggy', ggy, 'Hor', Hor, 'wdata', wdata, ...
        'sigmaK', sigmaK_cf, 'sigmaX', sigmaX_cf, ...
        'sigmaL', sigmaL_cf, 'sigmaH', sigmaH_cf, ...
        'theta', theta_cf, 'popL', popL_cf, 'popH', popH_cf, ...
        'pop', popCF, 'TotPop', TotPopCF);

    [L_cf, Omega_tild_cf] = LaborHL(bestGamma, InputHL_cf);

    [Y_cf, K_cf, X_cf, ggK0_cf, ggX0_cf, ggL0_cf, ggP0_cf] = OutputYHL(L_cf, Omega_tild_cf, InputHL_cf);

    % Store counterfactual results
    Y_cf_all{i} = Y_cf; K_cf_all{i} = K_cf; X_cf_all{i} = X_cf; L_cf_all{i} = L_cf;
    ggK0_cf_all{i} = ggK0_cf; ggX0_cf_all{i} = ggX0_cf; ggL0_cf_all{i} = ggL0_cf; ggP0_cf_all{i} = ggP0_cf;

    %% Compute relative output metrics
    RelGDP_all{i} = Y_all{i} ./ Y_cf_all{i};  % Relative GDP
    RelGDPpca_all{i} = (Y_all{i} ./ TotPopSim_all{i}) ./ (Y_cf_all{i} ./ TotPopCF_all{i});  % Relative GDP per capita
end


%% Get the GDP and GDP per Capita in 2010
% Preallocate the RelGDP matrix
RelGDP = zeros(n, 1); RelGDPpca = zeros(n, 1); mod_name = strings(n,1);

% Extract the (1,13) value from each cell of RelGDP_all{i}
for j = 1:n
    RelGDP(j,1) = RelGDP_all{1,j}(1, 13);
    RelGDPpca(j,1) = RelGDPpca_all{1,j}(1, 13);
    mod_name(j) = "$\rho$ = " + rho_values(j) + " and " + "$\eta$ = " + eta_values(j);
end

% Make the table
SolowHL_GDP_Table(mod_name, RelGDP, RelGDPpca, n, 'Tables/SolowHL_GDP.tex');

%% Extract the first set (rho=0.9, and eta=0.9)
RelGDPpca_SolowHL = RelGDPpca_all{1,1};
PopSim_SolowHL    = PopSim_all{1,1};
PopCF_SolowHL     = PopCF_all{1,1};
TotPopSim_SolowHL = TotPopSim_all{1,1};
TotPopCF_SolowHL  = TotPopCF_all{1,1};

sH_SolowHL     = sH_all{1,1};    
sL_SolowHL     = sL_all{1,1};     
sH_cf_SolowHL  = sH_cf_all{1,1};  
sL_cf_SolowHL  = sL_cf_all{1,1}; 
sL0_SolowHL    = sL0_all{1,1};   
sL0_cf_SolowHL = sL0_cf_all{1,1}; 
sH0_SolowHL    = sH0_all{1,1};   
sH0_cf_SolowHL = sH0_cf_all{1,1};

Y_SolowHL = Y_all{1,1};
K_SolowHL = K_all{1,1}; 
X_SolowHL = X_all{1,1};
L_SolowHL = L_all{1,1};
ggK0_SolowHL = ggK0_all{1,1}; 
ggX0_SolowHL = ggX0_all{1,1}; 
ggL0_SolowHL = ggL0_all{1,1}; 
ggP0_SolowHL = ggP0_all{1,1};

Y_cf_SolowHL = Y_cf_all{1,1};
K_cf_SolowHL = K_cf_all{1,1}; 
X_cf_SolowHL = X_cf_all{1,1};
L_cf_SolowHL = L_cf_all{1,1};
ggK0_cf_SolowHL = ggK0_cf_all{1,1}; 
ggX0_cf_SolowHL = ggX0_cf_all{1,1}; 
ggL0_cf_SolowHL = ggL0_cf_all{1,1}; 
ggP0_cf_SolowHL = ggP0_cf_all{1,1};

%% GDP per Capita, Labor-Population Ratio, Capital per Worker, Land per Worker
% Compute actual and counterfactual series based on simulated outputs

% GDP per capita
y_SolowHL     = Y_SolowHL ./ TotPopSim_SolowHL;      % Actual
y_cf_SolowHL  = Y_cf_SolowHL ./ TotPopCF_SolowHL;    % Counterfactual

% Labor to population ratio
l_SolowHL     = L_SolowHL ./ TotPopSim_SolowHL;      
l_cf_SolowHL  = L_cf ./ TotPopCF_SolowHL;           

% Capital per worker
k_SolowHL     = K_SolowHL ./ L_SolowHL;             
k_cf_SolowHL  = K_cf_SolowHL ./ L_cf_SolowHL;        

% Land per worker
x_SolowHL     = X_SolowHL ./ L_SolowHL;             
x_cf_SolowHL  = X_cf_SolowHL ./ L_cf_SolowHL;   

%% Decomposition Effect: Relative GDP per Capita Effect
%  Log Relative GDP per Capita
ye_SolowHL = log(y_SolowHL) -log(y_cf_SolowHL);

% Relative Capital per Worker Effect
ke_SolowHL = alpha.*(log(k_SolowHL) - log(k_cf_SolowHL));

% Relative Land per Worker effect 
xe_SolowHL = (1-alpha-beta).*(log(x_SolowHL) - log(x_cf_SolowHL)); 

% Relative Labor-to-Population Effect
le_SolowHL = log(l_SolowHL) - log(l_cf_SolowHL);

%% Plot all figures
run PlotRelGDPpca.m;
run PlotFertility.m;
run PlotSurvivalRate.m;
run PlotSurvivalRateHL.m;
run PlotMigrationFactor.m;
run PlotSavingRate.m;
run PlotThreeCountries.m;

