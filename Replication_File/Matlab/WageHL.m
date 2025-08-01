function [wm_model, wH_model, wL_model] = WageHL(gamma, Y, L, PHI, InputHL)
%==========================================================================
% WageHL.m
%
% Computes normalized average wages per cohort for:
%   - All workers (wm_model)
%   - High-skilled workers (wH_model)
%   - Low-skilled workers (wL_model)
%
% INPUTS:
%   gamma   - Vector of productivity weights by cohort (11x1)
%   Y       - Total output over time (matrix: time x 1)
%   L       - Total labor supply over time (matrix: time x 1)
%   PHI     - Relative productivity of low-skill vs high-skill labor
%   InputHL - Struct with model parameters and data:
%               .beta   - Labor share in production
%               .rho    - Elasticity of substitution in production
%               .eta    - Substitution elasticity between skills
%               .lambda - Productivity share of high-skilled labor
%               .theta  - Share of high-skilled labor (11xT)
%               .pop    - Population by cohort (C x T)
%
% OUTPUTS:
%   wm_model - Normalized average wage for all workers (11x1)
%   wH_model - Normalized average wage for high-skilled workers (11x1)
%   wL_model - Normalized average wage for low-skilled workers (11x1)
%
% Normalization is done using the wage level of the first cohort (age 15–19).
%==========================================================================

    %% Unpack input parameters
    beta   = InputHL.beta;
    rho    = InputHL.rho;
    eta    = InputHL.eta;
    lambda = InputHL.lambda;
    theta  = InputHL.theta;    
    pop    = InputHL.pop; 

    %% Base wage component (common across skill groups)
    w_tild = beta .* gamma .* (Y ./ L) .* (L ./ pop(4:14,:)).^(1 - rho); 

    %% Compute low-skill wages
    wL = (1 - lambda) .* ((1 - theta(4:14,:)).^(eta - 1)) .* (PHI.^(rho - eta)) .* w_tild;
    wL_avg = mean(wL, 2);  % Average over time
    wL_model = wL_avg / wL_avg(1); % Normalized to low-skill wage at age 15–19

    %% Compute high-skill wages
    wH = lambda .* (theta(4:14,:).^(eta - 1)) .* w_tild;
    wH_avg = mean(wH, 2); 
    wH_model = wH_avg / wL_avg(1);  

    %% Compute total average wage (weighted by skill share)
    wm = theta(4:14,:) .* wH + (1 - theta(4:14,:)) .* wL;
    wm_avg = mean(wm, 2);
    wm_model = wm_avg / wm_avg(1);

end
