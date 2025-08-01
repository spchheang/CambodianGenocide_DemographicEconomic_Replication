%% Linear Interpolation of Thailand's Saving Rates
% Load preprocessed log saving rate data (from 'data' structure)
log_SR    = data.log_SR;
log_srate = log_SR(:,1);  % Log of average saving rate by cohort
avg_srate = log_SR(:,2);  % Arithmetic average saving rate by cohort

%% Plot 1: Log vs Average Saving Rates by Cohort
Coh_vec  = 0:5:100;  % Cohort start years

figure(1); clf;

% Plot log of average saving rates
plot(Coh_vec, log_srate, ':*', ...
    'Color', [0.6 0 0.3], ...
    'MarkerFaceColor', [0.5 0 0.3], ...
    'MarkerSize', 3, ...
    'LineWidth', 2);
hold on;

% Plot arithmetic average saving rates
plot(Coh_vec, avg_srate, '-*', ...
    'Color', [0 0 0.6], ...
    'MarkerFaceColor', [0 0 0.6], ...
    'MarkerSize', 3, ...
    'LineWidth', 2);

xlabel('Cohorts (start year)', 'Interpreter', 'latex', 'FontSize', 15);
ylabel('Saving rate', 'Interpreter', 'latex', 'FontSize', 15);
legend('Log average saving rate', 'Average saving rate', ...
    'Interpreter', 'latex', 'FontSize', 14, 'Location', 'northwest');

% Axis formatting
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off;

set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf, "Graphs/AvgSavingRate.pdf");

%% Plot 2: Saving Rates by Skill Level (High, Average, Low)
% Assumes SRate matrix: [Average, High-skilled, Low-skilled] per cohort
figure(2); clf;

% High-skilled saving rate
plot(Coh_vec, SRate(:,2), ':*', ...
    'Color', [0.6 0 0.3], ...
    'MarkerFaceColor', [0.5 0 0.3], ...
    'MarkerSize', 3, ...
    'LineWidth', 2);
hold on;

% Average saving rate
plot(Coh_vec, SRate(:,1), '-*', ...
    'Color', [0 0.6 0.4], ...
    'MarkerFaceColor', [0 0.6 0.4], ...
    'MarkerSize', 3, ...
    'LineWidth', 2);

% Low-skilled saving rate
plot(Coh_vec, SRate(:,3), '--*', ...
    'Color', [0.8 0.4 0], ...
    'MarkerFaceColor', [0.6 0.4 0], ...
    'MarkerSize', 3, ...
    'LineWidth', 2);

xlabel('Cohorts (start year)', 'Interpreter', 'latex', 'FontSize', 15);
ylabel('Saving rate', 'Interpreter', 'latex', 'FontSize', 15);
legend('High-skilled', 'Average', 'Low-skilled', ...
    'Interpreter', 'latex', 'FontSize', 14, 'Location', 'northwest');

% Axis formatting
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off;

set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf, "Graphs/SavingRate.pdf");
