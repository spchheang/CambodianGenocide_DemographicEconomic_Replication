function [L, Omega_tild, PHI] = LaborHL(gamma, inputs)
%==========================================================================
% LaborHL.m
%
% Computes:
%   - Effective labor input (L)
%   - Adjusted saving rate (Omega_tild)
%   - Skill-composition aggregator (PHI)
%
% INPUTS:
%   gamma    - (11x1) Vector of gamma weights (by cohort)
%   inputs   - Struct with model parameters and population:
%       .lambda   - Share of high-skilled individuals
%       .eta      - elasticity of substitution across skills
%       .rho      - elasticity of substitution across cohorts
%       .theta    - High-skill share matrix (cohort x year)
%       .sigmaH   - Saving rate of high-skilled
%       .sigmaL   - Saving rate of low-skilled
%       .pop      - Total population matrix (cohort x year)
%       .popH     - High-skilled population matrix
%       .popL     - Low-skilled population matrix
%
% OUTPUTS:
%   L           - Effective labor supply
%   Omega_tild  - Adjusted saving rate
%   PHI         - Skill composition aggregator
%==========================================================================

    %% Unpack input struct
    lambda  = inputs.lambda;
    eta     = inputs.eta;
    rho     = inputs.rho;
    theta   = inputs.theta;
    sigmaH  = inputs.sigmaH;
    sigmaL  = inputs.sigmaL;
    pop     = inputs.pop;
    popH    = inputs.popH;
    popL    = inputs.popL;

    %% Define working cohort range (ages 15–65)
    cohort_idx = 4:14;

    %% Skill composition aggregator: PHI
    PHI = ((1 - lambda) .* (1 - theta(cohort_idx,:)).^eta + ...
            lambda  .*      theta(cohort_idx,:).^eta ).^(1/eta);

    %% Effective population 
    pop_tild = ((1 - lambda) .* popL(cohort_idx,:).^eta + ...
                 lambda  .* popH(cohort_idx,:).^eta).^(1/eta);

    %% Effective labor input L 
    L = (sum(gamma .* pop_tild.^rho)).^(1/rho);

    %% Adjusted saving rate: Omega_tild
    numer = gamma .* (PHI.^(rho - eta)) .* ...
           ((sigmaH(cohort_idx,:) .* lambda  .* theta(cohort_idx,:).^eta) + ...
            (sigmaL(cohort_idx,:) .* (1 - lambda) .* (1 - theta(cohort_idx,:)).^eta)) .* ...
            pop(cohort_idx,:).^rho;

    Omega_tild = sum(numer) ./ (L.^rho);

end
