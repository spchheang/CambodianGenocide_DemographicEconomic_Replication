function [data] = LoadInputData()
% LoadInputData - Loads and organizes demographic and economic input data for simulation.
%
% This function imports multiple CSV files containing actual and counterfactual
% demographic information, wage and saving rates, migration factors, and population
% statistics. It then preprocesses these datasets to construct a structured output 
% (`data`) that serves as a comprehensive input for simulation models of population
% dynamics and economic outcomes.
%
% Output:
%   data - A struct containing:
%       - Population matrices (actual and counterfactual)
%       - Survival and fertility rates (actual and counterfactual)
%       - Migration factors and female fractions
%       - Wage and saving rate data
%       - Psi parameters for simulation shocks
%       - Time and cohort settings
   
    %% Load input data
    % Actual survival rate including fertility rate
    S     = readmatrix("InputData/survivalrate.csv", 'NumHeaderLines', 1);  
    % Counterfactual survival rate including fertility rate
    CFS   = readmatrix("InputData/survivalcf.csv", 'NumHeaderLines', 1);  
    % Actual Population
    P     = readmatrix("InputData/pop.csv", 'NumHeaderLines', 1);           
    % Migration Factor     
    MIG   = readmatrix("InputData/mig_factor.csv", 'NumHeaderLines', 1);   
    % UN migration
    MC    = readmatrix("InputData/agg_mig.csv", 'NumHeaderLines', 1);       
    % Wage rates: 2010 CSES data
    Wdata = readmatrix("InputData/pred_wage2010.csv", 'NumHeaderLines', 1); 
    % Saving rates from Thailand and Indonesia
    CohSRate  = readmatrix("InputData/thai_indo_srates.csv", 'NumHeaderLines', 1); 
    % Log Saving rates from Thailand
    log_SR = readmatrix("InputData/thai_log_srates.csv", 'NumHeaderLines', 1);

    %% Prepare data
    % Set constants
    Hor = 14;   % number of 5-year intervals
    Coh = 21;   % number of cohorts

    % Average wage 2010 CSES
    wdata = Wdata(:,3);
    wdataH = Wdata(:,13);
    wdataL = Wdata(:,12);

    % Thailand cohort saving rates
    SRate = CohSRate(:,2:4);

    % Actual Population in UN Data
    Pop = P(:,3:23)';
    TotPop = P(:,2)';
    
    % Aggregate UN migration
    UN_AggM = MC(:,3)'; % United Nations
    % Time vector
    year = 1950:5:2015;

    % Survival Rates
    s0    = S(:,2)';       % age 0-1
    s     = S(:,3:22)';    % ages 1-95
    s0_cf = CFS(:,2)';
    s_cf  = CFS(:,3:22)';
    
    % Fertility Rates
    n    = [ zeros(3,Hor); S(:,23:29)' ; zeros(11,Hor)];
    n_cf = [ zeros(3,Hor); CFS(:,23:29)' ; zeros(11,Hor)];

    % Migration Factors
    m    = MIG(:,2:21)';
    m_cf = MIG(:,22:41)';

    % Fraction of Females
    frf = [ zeros(3,Hor); P(:,25:31)'; zeros(11,Hor)];

    % Initialize population in 1950 for simulation matrices
    pop_sim = zeros(Coh,Hor); pop_sim(:,1) = P(1,3:23)';
    pop_cf  = zeros(Coh,Hor); pop_cf(:,1)  = P(1,3:23)';

    % Set psi parameters
    psi_val = 0.000;  % You can change to 0.005 if needed

    psi0    = ones(1,Hor) * psi_val;
    psi     = ones(Coh-1,Hor) * psi_val;
    psi(4:end,6) = -0.25;

    psi0_cf = ones(1,Hor) * psi_val;
    psi_cf  = ones(Coh-1,Hor) * psi_val;

    % Final struct
    data = struct('pop_sim', pop_sim, 'pop_cf', pop_cf, ...
                  's', s, 's0', s0, 's_cf', s_cf, 's0_cf', s0_cf, ...
                  'n', n, 'n_cf', n_cf, ...
                  'm', m, 'm_cf', m_cf, ...
                  'frf', frf, ...
                  'Hor', Hor, 'Coh', Coh, ...
                  'psi', psi, 'psi0', psi0, ...
                  'psi_cf', psi_cf, 'psi0_cf', psi0_cf, ...
                  'year', year, 'SRate', SRate, 'log_SR', log_SR, ...
                  'wdata', wdata, 'wdataH', wdataH, 'wdataL', wdataL, ...
                  'TotPop', TotPop, 'Pop', Pop, 'UN_AggM', UN_AggM);
end
