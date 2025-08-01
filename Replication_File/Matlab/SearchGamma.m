function SSE = SearchGamma(gamma, Input)
%   SeachGamma Computes SSE between model-generated and empirical wages.
%
%   Inputs:
%       gamma   - Vector of gamma parameters (11x1)
%       Input  - Struct with model inputs and parameters
%
%   Output:
%       SSE     - Sum of squared errors between model and actual wages

    %% Unpack Structure Fields
    wdata    = Input.wdata;

    %% Effective Potential Labor
    [L, Omega] = Labor(gamma, Input);
    
    %% Output Y 
    [Y] = OutputY(L, Omega, Input);

    %% Compute Wages
    [wage_model] = Wage(gamma, Y, L, Input);
    % Actual wage data
    wage_data = wdata(4:14,:);            

    %% Compute SSE
    SSE = norm(wage_model - wage_data);

    %% Visualization (optional)
    W_model = [zeros(3,1); wage_model; zeros(7,1)];
    Coh_vec = 0:5:100;

    plot(Coh_vec, W_model, '-.o', 'Color', [0 0.4 0.6], ...
         'MarkerFaceColor', [0 0.4 0.6], 'MarkerSize', 3, 'LineWidth', 2);
    hold on;
    plot(Coh_vec, wdata, '->', 'Color', [0.8 0.4 0], ...
         'MarkerFaceColor', [0.8 0.4 0], 'MarkerSize', 3, 'LineWidth', 2);
    hold off;

    xlabel('Cohorts (Start Year)', 'Interpreter', 'latex', 'FontSize', 15);
    ylabel('Relative Average Wage Rate', 'Interpreter', 'latex', 'FontSize', 15);
    legend("Wage Model", "Wage Data", 'Interpreter', 'latex', 'FontSize', 12, 'Location', 'northeast');
end
