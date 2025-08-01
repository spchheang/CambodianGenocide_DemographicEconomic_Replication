

%% Aggregate Net Migration Analysis
% -------------------------------------------------------------
% This section computes the aggregate net migration from 
% age-specific migration factors and compares it with 
% United Nations aggregate migration data.
% -------------------------------------------------------------

% Load UN aggregate migration data
UN_AggM = data.UN_AggM;

% Retrieve actual and counterfactual migration factors
m = data.m;        % actual migration factors
m_cf = data.m_cf;  % counterfactual migration factors

% Compute net migrants per cohort
R = (m - 1) .* PopSim_SolowHL(1:end-1,:);      % actual net migration
R_cf = (m_cf - 1) .* PopSim_SolowHL(1:end-1,:);% counterfactual net migration

% Aggregate net migration across cohorts
AggM = sum(R);       % actual
AggM_CF = sum(R_cf); % counterfactual (not plotted here)

%% Plot: Actual Net Migration vs UN Data
figure; clf;
plot(year, UN_AggM, '-+', 'Color', [0 0 0.5], ...
    'MarkerFaceColor', [0 0 0.5], 'MarkerSize', 3, 'LineWidth', 2);
hold on;
plot(year, AggM, '--*', 'Color', [0 0.5 0], ...
    'MarkerFaceColor', [0 0.5 0], 'MarkerSize', 3, 'LineWidth', 2);

xlabel('Year', 'Interpreter', 'latex', 'FontSize', 15);
ylabel('Total migrants (thousands)', 'Interpreter', 'latex', 'FontSize', 15);
legend('United Nations', 'Actual (reconstructed)', ...
    'Interpreter', 'latex', 'FontSize', 13, 'Location', 'northwest');

ylim padded;
ytickformat('%.0f');
box on;
grid off;
hold off;

% Export plot
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf, "Graphs/Netmig.pdf");

%% Age-specific Migration Factor: Actual vs Counterfactual
% -------------------------------------------------------------
% These plots compare actual and counterfactual migration factors
% by age cohort over time.
% -------------------------------------------------------------

%% Actual vs Counterfactual Age-specific Migration Factor.
% Cohort 00-04 - Cohort 15-19
figure(1); clf;
plot(year, m(1,:),'-s', 'color', [0.7 0 0.5],...
    'MarkerFaceColor', [0.7 0 0.5], 'MarkerSize',3,'linewidth',1.5)
hold on;
plot(year, m(2,:),'-*', 'color', [0.9 0.4 0],...
    'MarkerFaceColor', [0.9  0.4 0], 'MarkerSize',3,'linewidth',1.5)
plot(year, m(3,:),'-^', 'color', [0 0.4 0],...
      'MarkerFaceColor',[0 0.4 0], 'MarkerSize',3,'linewidth',1.5)
plot(year, m(4,:),'-+','color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',4,'linewidth',1.5)
  
plot(year, m_cf(1,:),':s', 'color', [0.5 0 0.5],...
    'MarkerFaceColor', [0.5 0 0.5], 'MarkerSize',3,'linewidth',2)
plot(year, m_cf(2,:),':*', 'color', [0.8 0.4 0],...
    'MarkerFaceColor', [0.8 0.4 0], 'MarkerSize',3,'linewidth',2)
plot(year, m_cf(3,:),':^', 'color', [0 0.4 0],...
      'MarkerFaceColor',[0 0.4 0], 'MarkerSize',3,'linewidth',2)
plot(year, m_cf(4,:),':+','color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',2)

xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Migration factor','Interpreter','latex','FontSize',15)
legend('Actual cohort 0-4','Actual cohort 5',...
        'Actual cohort 10','Actual cohort 15',...
       'Counterfactual cohort 0-4','Counterfactual cohort 5',...
       'Counterfactual cohort 10','Counterfactual cohort 15',...
       'Interpreter','latex','FontSize',9,'location','southwest','numcolumns',2);

% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/mig1.pdf"); 

%% Actual vs Counterfactual Age-specific Migration Factor.
% Cohort 20-24 - Cohort 35-39
figure(2); clf;
plot(year, m(5,:),'-s', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',1.5)
hold on;
plot(year, m(6,:),'-*', 'color', [0.8 0.4 0],...
    'MarkerFaceColor', [0.8 0.4 0], 'MarkerSize',3,'linewidth',1.5)
plot(year, m(7,:),'-^', 'color', [0 0.4 0],...
      'MarkerFaceColor',[0 0.6 0], 'MarkerSize',3,'linewidth',1.5)
plot(year, m(8,:),'-+','color', [0.6 0 0.6],...
    'MarkerFaceColor', [0.6 0 0.6], 'MarkerSize',3,'linewidth',1.5)

plot(year, m_cf(5,:),':s', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, m_cf(6,:),':*', 'color', [0.8 0.4 0],...
    'MarkerFaceColor', [0.8 0.4 0], 'MarkerSize',3,'linewidth',2)
plot(year, m_cf(7,:),':^', 'color', [0 0.4 0],...
      'MarkerFaceColor',[0 0.6 0], 'MarkerSize',3,'linewidth',2)
plot(year, m_cf(8,:),':+','color', [0.6 0 0.6],...
    'MarkerFaceColor', [0.6 0 0.6], 'MarkerSize',3,'linewidth',2)

xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Migration factor','Interpreter','latex','FontSize',15)
legend('Actual cohort 20','Actual cohort 25',...
       'Actual cohort 30','Actual cohort 35',...
       'Counterfactual cohort 20','Counterfactual cohort 25',...
       'Counterfactual cohort 30','Counterfactual cohort 35',...
       'Interpreter','latex','FontSize',9.5,'location','southwest','numcolumns',2);

% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/mig2.pdf"); 


%% Actual vs Counterfactual Age-specific Migration Factor.
% Cohort 40-44 - Cohort 55-59
figure(3); clf;
plot(year, m(9,:),'-s', 'color', [0 0 0.4],...
    'MarkerFaceColor', [0 0 0.4], 'MarkerSize',3,'linewidth',1.5)
hold on;
plot(year, m(10,:),'-*', 'color', [0.7 0 0],...
    'MarkerFaceColor', [0.7 0 0], 'MarkerSize',3,'linewidth',1.5)
plot(year, m(11,:),'-^', 'color', [0 0.6 0.6],...
      'MarkerFaceColor',[0 0.6 0.6], 'MarkerSize',3,'linewidth',1.5)
plot(year, m(12,:),'-+','color', [0.8 0 0.8],...
    'MarkerFaceColor', [0.8 0 0.8], 'MarkerSize',4,'linewidth',1.5)

plot(year, m_cf(9,:),':s', 'color', [0 0 0.4],...
    'MarkerFaceColor', [0 0 0.4], 'MarkerSize',3,'linewidth',2)
plot(year, m_cf(10,:),':*', 'color', [0.7 0 0],...
    'MarkerFaceColor', [0.7 0 0], 'MarkerSize',3,'linewidth',2)
plot(year, m_cf(11,:),':^', 'color', [0 0.6 0.6],...
      'MarkerFaceColor',[0 0.6 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, m_cf(12,:),':+','color', [0.8 0 0.8],...
    'MarkerFaceColor', [0.8 0 0.8], 'MarkerSize',4,'linewidth',2)

xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Migration factor','Interpreter','latex','FontSize',15)
legend('Actual cohort 40','Actual cohort 45',...
       'Actual cohort 50','Actual cohort 55',...
       'Counterfactual cohort 40','Counterfactual cohort 45',...
       'Counterfactual cohort 50','Counterfactual cohort 55',...
       'Interpreter','latex','FontSize',9.5,'location','southeast','numcolumns',2);

% Auto-formatting for ticks
ylim([0.92, 1.035])
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/mig3.pdf"); 

%% Actual vs Counterfactual Age-specific Migration Factor.
% Cohort 60-64 - Cohort 75-79
figure(4); clf;
plot(year, m(13,:),'-s', 'color', [0 0 0.4],...
    'MarkerFaceColor', [0 0 0.4], 'MarkerSize',3,'linewidth',1.5)
hold on;
plot(year, m(14,:),'-*', 'color', [0.7 0 0],...
    'MarkerFaceColor', [0.7 0 0], 'MarkerSize',3,'linewidth',1.5)
plot(year, m(15,:),'-^', 'color', [0 0.6 0.6],...
      'MarkerFaceColor',[0 0.6 0.6], 'MarkerSize',3,'linewidth',1.5)
plot(year, m(16,:),'-+','color', [0.8 0 0.6],...
    'MarkerFaceColor', [0.8 0 0.6], 'MarkerSize',4,'linewidth',1.5)

plot(year, m_cf(13,:),':s', 'color', [0 0 0.4],...
    'MarkerFaceColor', [0 0 0.4], 'MarkerSize',3,'linewidth',2)
plot(year, m_cf(14,:),':*', 'color', [0.7 0 0],...
    'MarkerFaceColor', [0.7 0 0], 'MarkerSize',3,'linewidth',2)
plot(year, m_cf(15,:),':^', 'color', [0 0.6 0.6],...
      'MarkerFaceColor',[0 0.6 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, m_cf(16,:),':+','color', [0.8 0 0.6],...
    'MarkerFaceColor', [0.8 0 0.6], 'MarkerSize',4,'linewidth',2)

xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Migration factor','Interpreter','latex','FontSize',15)
legend('Actual cohort 60','Actual cohort 65',...
       'Actual cohort 70','Actual cohort 75',...
       'Counterfactual cohort 60','Counterfactual cohort 65',...
       'Counterfactual cohort 70','Counterfactual cohort 75',...
       'Interpreter','latex','FontSize',9.5,'location','southwest','numcolumns',2);

% Auto-formatting for ticks
ylim([0.765, 1.01]);
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/mig4.pdf"); 


%% Actual vs Counterfactual Age-specific Migration Factor.
% Cohort 80-84 - Cohort 95-99
figure(5); clf;
plot(year, m(17,:),'-+','color', [0.8 0 0.8],...
    'MarkerFaceColor', [0.8 0 0.8], 'MarkerSize',3,'linewidth',1.5)
hold on;
plot(year, m(18,:),'-s', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',1.5)
plot(year, m(19,:),'-*', 'color', [0.6 0 0],...
    'MarkerFaceColor', [0.6 0 0], 'MarkerSize',3,'linewidth',1.5)
plot(year, m(20,:),'-^', 'color', [0 0.4 0],...
  'MarkerFaceColor',[0 0.4 0], 'MarkerSize',3,'linewidth',1.5)

plot(year, m_cf(17,:),':+','color', [0.8 0 0.8],...
    'MarkerFaceColor', [0.8 0 0.8], 'MarkerSize',3,'linewidth',2)
plot(year, m_cf(18,:),':s', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, m_cf(19,:),':*', 'color', [0.6 0 0],...
    'MarkerFaceColor', [0.6 0 0], 'MarkerSize',3,'linewidth',2)
plot(year, m_cf(20,:),':^', 'color', [0 0.4 0],...
      'MarkerFaceColor',[0 0.4 0], 'MarkerSize',3,'linewidth',2)

xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Migration factor','Interpreter','latex','FontSize',15)
legend('Actual cohort 80','Actual cohort 84',...
       'Actual cohort 90', 'Actual cohort 95',...
       'Counterfactual cohort 80','Counterfactual cohort 85',...
       'Counterfactual cohort 90','Counterfactual cohort 95',...
       'Interpreter','latex','FontSize',9.5,'location','northeast','numcolumns',2);

% Auto-formatting for ticks
ylim([0.411, 1.58]);
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/mig5.pdf"); 
