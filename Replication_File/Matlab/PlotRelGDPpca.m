
clc;

year = data.year;

%% Load Relative GDP Per Capita
RelGDPpca_Malthus = readmatrix("InputData/RelGDPpca_Malthus.csv", 'NumHeaderLines', 0);
RelGDPpca_Solow   = readmatrix("InputData/RelGDPpca_Solow.csv", 'NumHeaderLines', 0);

%% Gross Growth Rates from 1955 Onward
% Compute year-over-year gross growth rates (i.e., Xt / Xt-1)

% Preallocate growth rate arrays
ggY_SolowHL     = zeros(1, Hor);

ggK_SolowHL     = zeros(1, Hor);
ggK_SolowHL(1,1)= ggK0_SolowHL;
ggL_SolowHL     = zeros(1, Hor);
ggL_SolowHL(1,1)= ggL0_SolowHL;
ggX_SolowHL     = zeros(1, Hor);
ggX_SolowHL(1,1)= ggX0_SolowHL;

ggY_cf_SolowHL  = zeros(1, Hor);

ggK_cf_SolowHL  = zeros(1, Hor);
ggK_cf_SolowHL(1,1)= ggK0_cf_SolowHL;
ggL_cf_SolowHL  = zeros(1, Hor);
ggL_cf_SolowHL(1,1)= ggL0_cf_SolowHL;
ggX_cf_SolowHL  = zeros(1, Hor);
ggX_cf_SolowHL(1,1)= ggX0_cf_SolowHL;

ggy_SolowHL     = zeros(1, Hor);
ggy_SolowHL(1,1) = ggy;

ggy_cf_SolowHL  = zeros(1, Hor);
ggy_cf_SolowHL(1,1) = ggy;

% Gross growth rates for aggregate output, capital, and land
ggY_SolowHL(:,2:end)    = Y_SolowHL(:,2:end) ./ Y_SolowHL(:,1:end-1);
ggK_SolowHL(:,2:end)    = K_SolowHL(:,2:end) ./ K_SolowHL(:,1:end-1);
ggL_SolowHL(1,2:end)    = L_SolowHL(:,2:end) ./ L_SolowHL(:,1:end-1);
ggX_SolowHL(1,2:end)    = X_SolowHL(:,2:end) ./ X_SolowHL(:,1:end-1);

ggY_cf_SolowHL(:,2:end) = Y_cf_SolowHL(:,2:end) ./ Y_cf_SolowHL(:,1:end-1);
ggK_cf_SolowHL(:,2:end) = K_cf_SolowHL(:,2:end) ./ K_cf_SolowHL(:,1:end-1);
ggL_cf_SolowHL(:,2:end) = L_cf_SolowHL(:,2:end) ./ L_cf_SolowHL(:,1:end-1);
ggX_cf_SolowHL(:,2:end) = X_cf_SolowHL(:,2:end) ./ X_cf_SolowHL(:,1:end-1);

% Gross growth rates for GDP per capita 
ggy_SolowHL(1,2:end) = y_SolowHL(:,2:end) ./ y_SolowHL(:,1:end-1);
ggy_cf_SolowHL(1,2:end)  = y_cf_SolowHL(:,2:end) ./ y_cf_SolowHL(:,1:end-1);

%% Time paths Total Population (AC-CF)
figure(1); clf;
plot(year, log(TotPopSim_SolowHL/TotPopSim_SolowHL(1)),'-+', 'color', [0 0.3 0.6],...
    'MarkerFaceColor', [0 0.3 0.6], 'MarkerSize',3,'linewidth',2)
hold on;
plot(year, log(TotPopCF_SolowHL/TotPopCF_SolowHL(1)),':s','color',[0 0.4 0],...
      'MarkerFaceColor',[0 0.4 0], 'MarkerSize',3,'linewidth',2)

xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Total population (log, normalized to 1950)','Interpreter','latex','FontSize',15)
legend('Actual','Counterfactual','Interpreter','latex','FontSize',13,...
        'location','northwest');

% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off;
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/timeTot.pdf");

%% Labor and Population
figure(2); clf;
colororder([0 0 0.6; 0.5 0 0.2]);  

yyaxis right;
plot(year, log(L_SolowHL/L_SolowHL(1)), '-o', 'color', [0 0 0.5], ...
    'MarkerFaceColor', [0 0 0.5], 'MarkerSize', 3, 'linewidth', 2);
hold on;
plot(year, log(L_cf_SolowHL/L_cf_SolowHL(1)), ':', 'color', [0 0 0.6], ...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize', 3, 'linewidth', 2);
ylabel('Total labor (log, normalized to 1950)','Interpreter','latex','FontSize',15);

yyaxis left;
plot(year, log(TotPopSim_SolowHL/TotPopSim_SolowHL(1)), '-+', 'color', [0.5 0 0.2], ...
    'MarkerFaceColor', [0.5 0 0.2], 'MarkerSize', 3, 'linewidth', 2);
plot(year, log(TotPopCF_SolowHL/TotPopCF_SolowHL(1)), ':s', 'color', [0.5 0 0.4], ...
    'MarkerFaceColor', [0.5 0 0.4], 'MarkerSize', 3, 'linewidth', 2);
xlabel('Year','Interpreter','latex','FontSize',15);
ylabel('Total population (log, normalized to 1950)','Interpreter','latex','FontSize',15);

legend('Actual labor','Counterfactual labor','Actual population','Counterfactual population', ...
       'Interpreter','latex','FontSize',12, 'Location','northwest', 'NumColumns', 2);

% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off;
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf, "Graphs/LaPop.pdf");

%% Relative GDP per capita Effect: Actual vs. Counterfactual: Three Lines
figure(2); clf;
plot(year, RelGDPpca_SolowHL,'->', 'color', [0.7 0 0],...
    'MarkerFaceColor', [0.7 0 0], 'MarkerSize',3,'linewidth',2);

hold on;
plot(year, RelGDPpca_Solow,'-.+', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',2);

plot(year, RelGDPpca_Malthus,'--*', 'color', [0 0.4 0],...
    'MarkerFaceColor', [0 0.4 0], 'MarkerSize',3,'linewidth',2);

xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Relative GDP per capita','Interpreter','latex','FontSize',15)
legend('Baseline model', 'Special case I', 'Special case II', 'Interpreter','latex','FontSize',13,...
        'location','northeast');

% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off;
set(gcf, 'WindowStyle', 'normal');
%exportgraphics(gcf,"Graphs/GDPPC_compr2.pdf");

%% Log Relative GDP per capita Effect: Actual vs. Counterfactual: Three Lines
figure(3); clf;
plot(year, log(RelGDPpca_SolowHL),'->', 'color', [0.7 0 0],...
    'MarkerFaceColor', [0.7 0 0], 'MarkerSize',3,'linewidth',2);

hold on;
plot(year, log(RelGDPpca_Solow),'-.+', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',2);

plot(year, log(RelGDPpca_Malthus),'--*', 'color', [0 0.4 0],...
    'MarkerFaceColor', [0 0.4 0], 'MarkerSize',3,'linewidth',2);

xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Relative GDP per capita (log scale)','Interpreter','latex','FontSize',15)
legend('Baseline model', 'Special case I', 'Special case II', 'Interpreter','latex','FontSize',13,...
        'location','northeast');

% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off;
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/LogGDPPC_compr2.pdf");

%% Relative GDP per capita Effect: Actual vs. Counterfactual
figure(4); clf;
plot(year, log(RelGDPpca_SolowHL),'-s', 'color', [0.7 0 0],...
    'MarkerFaceColor', [0.7 0 0], 'MarkerSize',3,'linewidth',2)
xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Relative GDP per capita (log scale)','Interpreter','latex','FontSize',15)

% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off;
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/LogGDPPC.pdf"); 

%% Special case I
figure(5); clf;
plot(year, log(RelGDPpca_Solow),'-.+', 'color', [0 0 0.6],...
    'MarkerFaceColor',[0 0 0.6], 'MarkerSize',3,'linewidth',2)
xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Relative GDP per capita (log scale)','Interpreter','latex','FontSize',15)

% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off;
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/LogGDPPC1.pdf");

%% Special cases II
figure(6); clf;
plot(year, log(RelGDPpca_Malthus),'--*', 'color', [0 0.4 0],...
    'MarkerFaceColor', [0 0.4 0], 'MarkerSize',3,'linewidth',2)
xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Relative GDP per capita (log scale)','Interpreter','latex','FontSize',15)

% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off;
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/LogGDPPC2.pdf");

%% 5-Year Gross Growth Rate of GDP per Capita
figure(7); clf;
plot(year, ggy_SolowHL,'-+', 'color', [0 0.3 0.6],...
    'MarkerFaceColor', [0 0.3 0.6], 'MarkerSize',3,'linewidth',2)
hold on;
plot(year, ggy_cf_SolowHL,':s','color',[0 0.4 0],...
      'MarkerFaceColor',[0 0.4 0], 'MarkerSize',3,'linewidth',2)
xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('5-year gross growth rate','Interpreter','latex','FontSize',15)
legend('Actual', 'Counterfactual', 'Interpreter','latex','FontSize',13,...
        'location','northwest');
% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off;
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/ggy.pdf");

%% 5-Year Gross Growth Rate of Capital K
figure(8); clf;
plot(year, ggK_SolowHL,'-+', 'color', [0 0.3 0.6],...
    'MarkerFaceColor', [0 0.3 0.6], 'MarkerSize',3,'linewidth',2)
hold on;
plot(year, ggK_cf_SolowHL,':s','color',[0 0.4 0],...
      'MarkerFaceColor',[0 0.4 0], 'MarkerSize',3,'linewidth',2)
xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('5-year gross growth rate','Interpreter','latex','FontSize',15)
legend('Actual', 'Counterfactual', 'Interpreter','latex','FontSize',13,...
        'location','northwest');
% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/ggK.pdf");

%% 5-Year Gross Growth Rate of Labor L
figure(9); clf;
plot(year, ggL_SolowHL,'-+', 'color', [0 0.3 0.6],...
    'MarkerFaceColor', [0 0.3 0.6], 'MarkerSize',3,'linewidth',2)
hold on;
plot(year, ggL_cf_SolowHL,':s','color',[0 0.4 0],...
      'MarkerFaceColor',[0 0.4 0], 'MarkerSize',3,'linewidth',2)
xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('5-year gross growth rate','Interpreter','latex','FontSize',15)
legend('Actual', 'Counterfactual', 'Interpreter','latex','FontSize',13,...
        'location','northwest');

% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/ggL.pdf");

%% 5-Year Gross Growth Rate of Land X
figure(10); clf;
ggX_SolowHL = round(ggX_SolowHL, 4);
ggX_cf_SolowHL = round(ggX_cf_SolowHL, 4);
figure(10); clf;
plot(year, ggX_SolowHL,'-+', 'color', [0 0.3 0.6],...
    'MarkerFaceColor', [0 0.3 0.6], 'MarkerSize',3,'linewidth',2)
hold on;
plot(year, ggX_cf_SolowHL,':s','color',[0 0.4 0],...
      'MarkerFaceColor',[0 0.4 0], 'MarkerSize',3,'linewidth',2)
xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('5-year gross growth rate','Interpreter','latex','FontSize',15)
legend('Actual', 'Counterfactual', 'Interpreter','latex','FontSize',13,...
        'Location','northwest');

ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/ggX.pdf");

%% 2010 Age Distribution
figure(11); clf;
% Vector with start years for each cohort
Coh_vec=[0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100];

plot(Coh_vec,PopSim_SolowHL(:,13),'-+', 'color', [0 0.3 0.6],...
    'MarkerFaceColor', [0 0.3 0.6], 'MarkerSize',3,'linewidth',2)
hold on;
plot(Coh_vec,PopCF_SolowHL(:,13),':s','color',[0 0.4 0],...
      'MarkerFaceColor',[0 0.4 0], 'MarkerSize',3,'linewidth',2)
     
xlabel('Cohorts (start year)','Interpreter','latex','FontSize',15)
ylabel('Total population (thousands)','Interpreter','latex','FontSize',15)
legend('Actual','Counterfactual',...
   'Interpreter','latex','FontSize',14,'location','northeast','numcolumns',1);

% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.0f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/Age2010.pdf");  

%% Three Years: 1950, 1970, 1990 Age Distribution
figure(12); clf;
plot(Coh_vec, PopSim_SolowHL(:,1),'-+','color', [0.7 0 0.7],...
    'MarkerFaceColor', [0.7 0 0.7], 'MarkerSize',3,'linewidth',2)
hold on;
plot(Coh_vec, PopSim_SolowHL(:,5),'-*', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',2)
plot(Coh_vec, PopSim_SolowHL(:,9),'-o', 'color', [0.6 0 0],...
    'MarkerFaceColor', [0.6 0 0 ],'MarkerSize',3,'linewidth',2)

plot(Coh_vec, PopCF_SolowHL(:,1),':>','color', [0.7 0 0.7],...
    'MarkerFaceColor', [0.7 0 0.7], 'MarkerSize',3,'linewidth',2)
plot(Coh_vec, PopCF_SolowHL(:,5),':>', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',2)

plot(Coh_vec, PopCF_SolowHL(:,9),':>', 'color', [0.6 0 0],...
    'MarkerFaceColor', [0.6 0 0 ],'MarkerSize',3,'linewidth',2)

xlabel('Cohorts (start year)','Interpreter','latex','FontSize',15)
ylabel('Total population (thousands)','Interpreter','latex','FontSize',15)
legend('1950 Actual ', '1970 Actual', '1990 Actual', ... 
      '1950 Counterfactual', '1970 Counterfactual', '1990 Counterfactual', ...
     'Interpreter','latex','FontSize',14,'location','northeast','numcolumns',2);

% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.0f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/Age4yrs.pdf");  

%% Working-age to Non-working-age Population Ratio: Actual vs. Counterfactual, 1950–2015
% Working-to-non-working population ratio
Nonwk = sum(PopSim_SolowHL(1:3,:)) + sum(PopSim_SolowHL(15:end,:));
Wk = sum(PopSim_SolowHL(4:14,:));
Nonwk_cf = sum(PopCF_SolowHL(1:3,:)) + sum(PopCF_SolowHL(15:end,:));
Wk_cf = sum(PopCF_SolowHL(4:14,:));
Actwkr = Wk./Nonwk;
Cofwkr = Wk_cf./Nonwk_cf;

figure(13); clf;
plot(year, Actwkr,'-+','color', [0 0.3 0.6],...
    'MarkerFaceColor', [0 0.3 0.6], 'MarkerSize',3,'linewidth',2)
hold on;
plot(year, Cofwkr,':o','color', [0 0.4 0],...
     'MarkerFaceColor', [0 0.4 0], 'MarkerSize',4,'linewidth',2)
hold off;
xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Working-age to non-working-age ratio','Interpreter','latex','FontSize',15)
legend('Actual','Counterfactual','Interpreter','latex','FontSize',14,...
        'location','northwest');

% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/WKRatio.pdf"); 

%% Relative Capital per Worker Effect
figure(14); clf;
plot(year, ke_SolowHL,'-d', 'color', [0.6 0 0.7],...
    'MarkerFaceColor', [0.6 0 0.7], 'MarkerSize',3,'linewidth',2)
hold on;
xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Relative capital per worker (log difference)','Interpreter','latex','FontSize',15)

% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off;
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/ke.pdf");

%% Relative Land per Worker Effect
figure(15); clf;
plot(year, xe_SolowHL,'-+', 'color', [0 0 0.5],...
    'MarkerFaceColor', [0 0 0.5], 'MarkerSize',3,'linewidth',2)
hold on;
xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Relative land per worker (log difference)','Interpreter','latex','FontSize',15)

% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off;
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/xe.pdf");

%% Relative Labor-to-Population Ratio
figure(16); clf;
plot(year, le_SolowHL,'-.<', 'color', [0 0.5 0.5],...
    'MarkerFaceColor', [0 0.5 0.5], 'MarkerSize',3,'linewidth',2)
hold on;
xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Relative labor-to-population ratio (log difference)','Interpreter','latex','FontSize',15)

% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off;
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/le.pdf");

%% Log GDP per Capita
figure(17); clf;
plot(year, log(y_SolowHL),'->', 'color', [0 0.3 0.6],...
    'MarkerFaceColor', [0 0.3 0.6], 'MarkerSize',3,'linewidth',2);

hold on;
plot(year, log(y_cf_SolowHL),'-.+', 'color', [0 0.4 0],...
    'MarkerFaceColor', [0 0.4 0], 'MarkerSize',3,'linewidth',2);
xlabel('Year', 'FontSize', 14, 'Interpreter', 'latex');
ylabel('GDP per capita (log scale)', 'FontSize', 15, 'Interpreter', 'latex');
legend('Actual', 'Counterfactual', 'Interpreter','latex','FontSize',13,...
        'location','northwest');

% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off;
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/log_ycf.pdf");

%% Log Capital
figure(18); clf;
plot(year, log(K_SolowHL),'-d', 'color', [0.7 0 0],...
    'MarkerFaceColor', [0.7 0 0], 'MarkerSize',3,'linewidth',2)

hold on;
plot(year, log(K_cf_SolowHL),'-.+', 'color', [0 0.3 0.6],...
    'MarkerFaceColor', [0 0.3 0.6], 'MarkerSize',3,'linewidth',2);
xlabel('Year', 'FontSize', 14, 'Interpreter', 'latex');
ylabel('Capital (log scale)', 'FontSize', 15, 'Interpreter', 'latex');
legend('Actual', 'Counterfactual', 'Interpreter','latex','FontSize',13,...
        'location','northwest');

% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off;
exportgraphics(gcf,"Graphs/Log-K-input.pdf");

%% Log GDP per Capita
figure(20); clf;
plot(year, y_SolowHL,'->', 'color', [0 0.3 0.6],...
    'MarkerFaceColor', [0 0.3 0.6], 'MarkerSize',3,'linewidth',2);

hold on;
plot(year, y_cf_SolowHL,'-.+', 'color', [0 0.4 0],...
    'MarkerFaceColor', [0 0.4 0], 'MarkerSize',3,'linewidth',2);
xlabel('Year', 'FontSize', 14, 'Interpreter', 'latex');
ylabel('GDP per capita', 'FontSize', 15, 'Interpreter', 'latex');
legend('Actual', 'Counterfactual', 'Interpreter','latex','FontSize',13,...
        'location','northwest');

% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off;
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/ycf.pdf");


