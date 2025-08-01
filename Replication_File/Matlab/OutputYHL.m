function [Y, K, X, ggK0, ggX0, ggL0, ggP0] = OutputYHL(L, Omega_tild, inputYHL)
%OUTPUTYHL Simulates output, capital, and land dynamics over time.
%
%   This function computes the time path of aggregate output (Y), capital (K),
%   and land productivity (X), based on effective labor (L), adjusted saving rate
%   (Omega_tild), and a Cobb-Douglas production function with capital, labor,
%   and land as inputs.
%
%   Inputs:
%       L           - Effective labor matrix [1 x T]
%       Omega_tild  - Adjusted saving rate [1 x T]
%       inputYHL    - Struct with model parameters:
%                       TotPop  : Total population matrix [1 x T]
%                       sigmaK  : Capital saving rate
%                       sigmaX  : Land investment rate
%                       alpha   : Capital share
%                       beta    : Labor share
%                       delta   : Capital depreciation rate
%                       ggy     : Target output growth rate
%                       z       : Land share
%                       Hor     : Time horizon
%
%   Outputs:
%       Y      - Output time path [1 x Hor]
%       K      - Capital stock time path [1 x Hor]
%       X      - Land productivity time path [1 x Hor]
%       ggK0   - Initial capital growth rate
%       ggX0   - Initial land productivity growth rate
%       ggL0   - Initial labor growth rate
%       ggP0   - Initial population growth rate

    %% === Unpack Inputs ===
    TotPop = inputYHL.TotPop;
    sigmaK = inputYHL.sigmaK;
    sigmaX = inputYHL.sigmaX;
    alpha  = inputYHL.alpha;   
    beta   = inputYHL.beta;   
    delta  = inputYHL.delta;   
    ggy    = inputYHL.ggy;     
    z      = inputYHL.z;       
    Hor    = inputYHL.Hor;     

    %% === Compute Growth Rates ===
    ggP = TotPop(:,2:end) ./ TotPop(:,1:end-1);      % Population growth
    ggL = L(:,2:end) ./ L(:,1:end-1);                % Labor growth

    % Total saving rate across factors (weighted sum)
    sigma = beta .* Omega_tild + alpha .* sigmaK + z .* sigmaX;
    ggsigma = sigma(:,2:5) ./ sigma(:,1:4);          % Growth in saving rate

    % Backcast pre-1955 values using mean (1955–1970)
    ggP = [mean(ggP(1,1:4)), ggP];
    ggL = [mean(ggL(1,1:4)), ggL];
    ggsigma = [mean(ggsigma(:,1:4), 2), ggsigma];

    %% === Initialize Time Paths ===
    Y = ones(1, Hor);      % Output
    K = ones(1, Hor);      % Capital
    X = ones(1, Hor);      % Land productivity
    ggK = ones(1, Hor);    % Capital growth

    %% === Initial Conditions ===
    % Initial land productivity growth rate consistent with ggy
    ggX_temp = (ggy^(1 - alpha) * ggP(1)^(1 - alpha) * ...
                ggsigma(1)^(-alpha) * ggL(1)^(-beta))^(1 / z);
    ggX = ones(1, Hor) .* ggX_temp;

    % Capital growth rate in first period
    ggK(1) = (ggsigma(1) * ggL(1)^beta * ggX(1)^z)^(1 / (1 - alpha));

    % Calibrate initial capital stock
    K(1) = ((sigma(1) / (ggK(1) - 1 + delta)) * L(1)^beta * X(1)^z)^(1 / (1 - alpha));

    % Initial output
    Y(1) = K(1)^alpha * L(1)^beta * X(1)^z;

    %% === Recursive Dynamics over Time ===
    for j = 1:Hor-1
        K(j+1) = sigma(j) * Y(j) + (1 - delta) * K(j);     % Capital accumulation
        X(j+1) = ggX(j) * X(j);                            % Land productivity growth
        Y(j+1) = K(j+1)^alpha * L(j+1)^beta * X(j+1)^z;    % Output production
    end

    %% === Output Initial Growth Rates ===
    ggK0 = ggK(1);    % Initial capital growth
    ggX0 = ggX(1);    % Initial land productivity growth
    ggL0 = ggL(1);    % Initial labor growth
    ggP0 = ggP(1);    % Initial population growth
end
