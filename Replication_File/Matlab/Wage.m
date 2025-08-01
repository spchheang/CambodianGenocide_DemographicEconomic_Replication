function [wage_model] = Wage(gamma, Y, L, Input)
%==========================================================================
% Wage.m
%
% Computes cohort-specific and normalized average wages based on model 
% inputs and gamma parameters.
%
% INPUTS:
%   gamma  - Vector of gamma parameters (11x1)
%   Y      - Matrix of output levels (Years x Cohorts)
%   L      - Matrix of labor input (Years x Cohorts)
%   Input  - Struct containing model parameters:
%            .beta   - Labor share in production
%            .rho    - Substitution parameter
%            .pop    - Total population matrix (Cohorts x Years)
%
% OUTPUT:
%   wage_model - Normalized average wage per cohort (11x1), 
%                relative to the youngest working cohort (cohort 15)
%
%==========================================================================

    % Extract model parameters
    beta = Input.beta;
    rho  = Input.rho;
    pop  = Input.pop;

    %----------------------------------------------------------------------
    % Compute wage for each cohort over time
    %----------------------------------------------------------------------
    wage = beta * (Y ./ L) .* gamma .* (L ./ pop(4:14,:)).^(1 - rho);

    % Compute average wage across time for each cohort
    wage_avg = mean(wage, 2);

    % Normalize wages relative to cohort 15 (youngest)
    wage_model = wage_avg / wage_avg(1);

end
