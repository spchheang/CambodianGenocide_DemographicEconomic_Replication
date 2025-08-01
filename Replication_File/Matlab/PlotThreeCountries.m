clc;

%% Load Population Data for Three Countries
% Files contain total population (normalized to 1950) and age structure
Cam  = readmatrix("inputdata/cam_relpop1950.csv",  'NumHeaderLines', 1);  % Cambodia
Thai = readmatrix("inputdata/thai_relpop1950.csv", 'NumHeaderLines', 1);  % Thailand
Viet = readmatrix("inputdata/viet_relpop1950.csv", 'NumHeaderLines', 1);  % Vietnam

% Load population fraction by cohort for two key years: 1975 and 2010
Fraction1975 = readmatrix("inputdata/fracpop4_1975.csv", 'NumHeaderLines', 1);
Fraction2010 = readmatrix("inputdata/fracpop4_2010.csv", 'NumHeaderLines', 1);

%% Prepare Data for Analysis
Coh_vec  = 0:5:100;  % Cohort start years
year    = Cam(:,1)';     % Time series (year)

% Log of total population relative to 1950
CamPop = Cam(:,25)';
THPop  = Thai(:,25)';
VNPop  = Viet(:,25)';

% Transpose fraction matrices for plotting 
F1975 = Fraction1975';
F2010 = Fraction2010';

%% Figure 1: Total Population of Three Countries Relative to 1950 (Log Scale)
figure(1); clf;

plot(year, CamPop, '-+', 'Color', [0 0 0.6], ...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize', 3, 'LineWidth', 2);
hold on;
plot(year, THPop, '->', 'Color', [0 0.4 0], ...
    'MarkerFaceColor', [0 0.4 0], 'MarkerSize', 3, 'LineWidth', 2);
plot(year, VNPop, '--o', 'Color', [0.7 0 0], ...
    'MarkerFaceColor', [0.7 0 0], 'MarkerSize', 3, 'LineWidth', 2);

xlabel('Year', 'Interpreter', 'latex', 'FontSize', 15);
ylabel('Total population (log, normalized to 1950)', ...
    'Interpreter', 'latex', 'FontSize', 15);
legend('Cambodia', 'Thailand', 'Vietnam', ...
    'Interpreter', 'latex', 'FontSize', 13, 'Location', 'northwest');

ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off;

set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf, "Graphs/4time.pdf");

%% Figure 2: Reproductive Age Groups (15-45) in 1975 by Country
figure(2); clf;

hb = bar(Coh_vec(4:10), F1975(4:10, :)', 'BarWidth', 1.1);
hb(1).FaceColor = [0 0 0.6];   % Cambodia
hb(2).FaceColor = [0 0.4 0];   % Thailand
hb(3).FaceColor = [0.7 0 0];   % Vietnam

xlabel('Cohorts (start year)', 'Interpreter', 'latex', 'FontSize', 15);
ylabel('Fraction of population', 'Interpreter', 'latex', 'FontSize', 15);
legend('Cambodia', 'Thailand', 'Vietnam', ...
    'Interpreter', 'latex', 'FontSize', 11, 'Location', 'northeast');

ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off;

set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf, "Graphs/bar1975.pdf");

%% Figure 3: Older Age Groups (50–80) in 2010 by Country
figure(3); clf;

hb = bar(Coh_vec(11:17), F2010(11:17, :)', 'BarWidth', 1.1);
hb(1).FaceColor = [0 0 0.6];   % Cambodia
hb(2).FaceColor = [0 0.4 0];   % Thailand
hb(3).FaceColor = [0.7 0 0];   % Vietnam

xlabel('Cohorts (start year)', 'Interpreter', 'latex', 'FontSize', 15);
ylabel('Fraction of population', 'Interpreter', 'latex', 'FontSize', 15);
legend('Cambodia', 'Thailand', 'Vietnam', ...
    'Interpreter', 'latex', 'FontSize', 11, 'Location', 'northeast');

ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off;

set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf, "Graphs/bar2010.pdf");
