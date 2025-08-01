function [Y, K, X] = OutputY(L, Omega, InputY)
% OutputY - Computes the dynamic evolution of output (Y), capital stock (K), and land (X)
%           over time using a production function.
%
% This function simulates the recursive progression of output, capital, and land 
% across multiple time periods. It incorporates demographic data, economic parameters, 
% input shares, and saving rates to model the production process.
%
% Inputs:
%   L        - Effective labor matrix [1 x T]
%   Omega    - Adjusted saving rate [1 x T]
%   InputY   - Struct containing model parameters and population data, including:
%              TotPop   - Total population matrix
%              sigmaK   - Capital saving rate
%              sigmaX   - Technology saving rate 
%              alpha    - Capital share
%              beta     - Labor share
%              delta    - Capital depreciation rate
%              ggy      - Initial output growth rate
%              z        - Land share
%              Hor      - Number of time periods
%
% Outputs:
%   Y      - Output time path [1 x Hor]
%   K      - Capital stock time path [1 x Hor]
%   X      - Land productivity time path [1 x Hor]

    % Extract inputs
    TotPop     = InputY.TotPop;
    sigmaK     = InputY.sigmaK;
    sigmaX     = InputY.sigmaX;
    alpha      = InputY.alpha;
    beta       = InputY.beta;
    delta      = InputY.delta;
    ggy        = InputY.ggy;
    z          = InputY.z;
    Hor        = InputY.Hor;

    % --- Growth rates ---
    ggP = TotPop(:,2:end) ./ TotPop(:,1:end-1);        % Population growth
    ggL = L(:,2:end) ./ L(:,1:end-1);                  % Labor growth

    sigma = beta .* Omega + alpha .* sigmaK + z .* sigmaX;
    ggsigma = sigma(:,2:5) ./ sigma(:,1:4);            % Saving rate growth

    % --- 1950 Backcasting (mean of 1955-1970) ---
    ggP = [mean(ggP(1,1:4)), ggP];
    ggL = [mean(ggL(1,1:4)), ggL];
    ggsigma = [mean(ggsigma(:,1:4),2), ggsigma];

    % --- Initialize Vectors ---
    Y = ones(1, Hor);
    K = ones(1, Hor);
    X = ones(1, Hor);
    ggK = ones(1, Hor);

    % --- Initial Values ---
    ggX_temp = (ggy^(1 - alpha) * ggP(1)^(1 - alpha) * ...
                ggsigma(1)^(-alpha) * ggL(1)^(-beta))^(1 / z);
    ggX = ones(1, Hor) .* ggX_temp;

    ggK(1) = (ggsigma(1) * ggL(1)^beta * ggX(1)^z)^(1 / (1 - alpha));
    K(1) = ((sigma(1) / (ggK(1) - 1 + delta)) * L(1)^beta * X(1)^z)^(1 / (1 - alpha));
    Y(1) = K(1)^alpha * L(1)^beta * X(1)^z;

    % --- Recursive Dynamics ---
    for j = 1:Hor-1
        K(j+1) = sigma(j) * Y(j) + (1 - delta) * K(j);
        X(j+1) = ggX(j) * X(j);
        Y(j+1) = K(j+1)^alpha * L(j+1)^beta * X(j+1)^z;
    end
    
end
