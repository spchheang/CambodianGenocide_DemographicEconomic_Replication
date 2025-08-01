function PlotWage(gamma, InputHL)
%==========================================================================
% PlotWage.m
%
% Plots model-generated average wages by cohort (all, high-skilled, low-skilled)
% and compares them to 2010 CSES data.
%
% INPUTS:
%   gamma    - Vector of gamma parameters (11x1)
%   InputHL  - Struct containing:
%       .wdata   - Observed average wage (2010 CSES)
%       .wdataH  - Observed high-skilled wage
%       .wdataL  - Observed low-skilled wage
%       .beta, .rho, .eta, .lambda, .theta, .pop - model parameters
%
% OUTPUT:
%   PDF figures saved to "Graphs/" folder.
%==========================================================================

    %% Unpack wage data
    wdata  = InputHL.wdata;
    wdataH = InputHL.wdataH;
    wdataL = InputHL.wdataL;

    %% Compute model outputs
    [L, Omega_tild, PHI] = LaborHL(gamma, InputHL);
    Y = OutputYHL(L, Omega_tild, InputHL);
    [wm_model, wH_model, wL_model] = WageHL(gamma, Y, L, PHI, InputHL);

    %% Prepare cohort vector and padded results
    Coh_vec  = 0:5:100;
    pad_zeros = @(w) [zeros(3,1); w; zeros(7,1)];

    W_model  = pad_zeros(wm_model);
    WH_model = pad_zeros(wH_model);
    WL_model = pad_zeros(wL_model);

    %% Plot 1: Model vs 2010 CSES data (average wages)
    figure(1); clf;
    plot(Coh_vec, W_model, '-.o', 'Color', [0 0 0.6], ...
         'MarkerFaceColor', [0 0 0.6], 'MarkerSize', 3, 'LineWidth', 2);
    hold on;
    plot(Coh_vec, wdata, '->', 'Color', [0.8 0.4 0], ...
         'MarkerFaceColor', [0.8 0.4 0], 'MarkerSize', 3, 'LineWidth', 2);

    xlabel('Cohorts (start year)', 'Interpreter', 'latex', 'FontSize', 15);
    ylabel('Average relative wage', 'Interpreter', 'latex', 'FontSize', 15);
    legend("Model", "2010 CSES data", 'Interpreter', 'latex', 'FontSize', 12, 'Location', 'northeast');
    tidyPlot();
    exportgraphics(gcf, "Graphs/WageModelvs2010CSES.pdf");

    %% Plot 2: High-skilled vs Low-skilled model wages
    figure(2); clf;
    plot(Coh_vec, WH_model, '->', 'Color', [0 0.4 0], ...
         'MarkerFaceColor', [0 0.4 0], 'MarkerSize', 3, 'LineWidth', 2);
    hold on;
    plot(Coh_vec, WL_model, '-.o', 'Color', [0.8 0.4 0], ...
         'MarkerFaceColor', [0.8 0.4 0], 'MarkerSize', 3, 'LineWidth', 2);

    xlabel('Cohorts (start year)', 'Interpreter', 'latex', 'FontSize', 15);
    ylabel('Average relative wage', 'Interpreter', 'latex', 'FontSize', 15);
    legend("High-skilled", "Low-skilled", 'Interpreter', 'latex', 'FontSize', 12, 'Location', 'northeast');
    tidyPlot();
    exportgraphics(gcf, "Graphs/WageHLModel.pdf");

    %% Plot 3: High-skilled vs Low-skilled observed wages
    figure(3); clf;
    plot(Coh_vec, wdataH, '->', 'Color', [0.8 0 0.6], ...
         'MarkerFaceColor', [0.8 0 0.6], 'MarkerSize', 3, 'LineWidth', 2);
    hold on;
    plot(Coh_vec, wdataL, '-.o', 'Color', [0 0 0.6], ...
         'MarkerFaceColor', [0 0 0.6], 'MarkerSize', 3, 'LineWidth', 2);

    xlabel('Cohorts (start year)', 'Interpreter', 'latex', 'FontSize', 15);
    ylabel('Average relative wage', 'Interpreter', 'latex', 'FontSize', 15);
    legend("High-skilled", "Low-skilled", 'Interpreter', 'latex', 'FontSize', 12, 'Location', 'northeast');
    tidyPlot();
    exportgraphics(gcf, "Graphs/WageHL2010CSES.pdf");

end

%% Helper Function for Plot Styling
function tidyPlot()
    ylim padded;
    set(gca, 'YTickMode', 'auto');
    ytickformat('%.2f');
    box on;
    grid off;
    set(gcf, 'WindowStyle', 'normal');
end
