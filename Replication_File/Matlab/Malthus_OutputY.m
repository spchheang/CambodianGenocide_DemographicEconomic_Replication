function [Y, X] = Malthus_OutputY(L, Input)
% Malthus_OutputY Computes output (Y) and technology (X) over time using a Malthusian framework,
% based on population and labor growth, with recursive dynamics and initial backcasting.

    % Extract inputs
    TotPop     = Input.TotPop;
    beta       = Input.beta;
    ggy        = Input.ggy;
    z          = Input.z;
    Hor        = Input.Hor;

    % --- Growth rates ---
    ggP = TotPop(:,2:end) ./ TotPop(:,1:end-1);        % Population growth
    ggL = L(:,2:end) ./ L(:,1:end-1);                  % Labor growth

    % --- 1950 Backcasting (mean of 1955-1970) ---
    ggP = [mean(ggP(1,1:4)), ggP];
    ggL = [mean(ggL(1,1:4)), ggL];

    % --- Initialize Vectors ---
    Y = ones(1, Hor);
    X = ones(1, Hor);

    % --- Initial Values ---
    ggX = ones(1,Hor) * (ggy * ggP(1) * (ggL(1)^(-beta)))^(1/z);

    Y(1) = L(1)^beta * X(1)^z;

    % --- Recursive Dynamics ---
    for j = 1:Hor-1
        X(j+1) = ggX(j) * X(j);
        Y(j+1) = L(j+1)^beta * X(j+1)^z;
    end

end
