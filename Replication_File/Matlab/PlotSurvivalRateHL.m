
%% Age-specific Survival Rates for High- and Low-skill Population
sH = sH_SolowHL;  
sL = sL_SolowHL;    
sH_cf = sH_cf_SolowHL; 
sL_cf = sL_cf_SolowHL;
sL0 = sL0_SolowHL;  
sL0_cf = sL0_cf_SolowHL;
sH0 = sH0_SolowHL;  
sH0_cf = sH0_cf_SolowHL;

%% Time Path Survival Rates High and Low Skill Cohort 00-01 - Cohort 10-14 
figure(1); clf;
plot(year, sH0(1,:),'-+','color', [0.8 0 0.3],...
    'MarkerFaceColor', [0.6 0 0.3], 'MarkerSize',3,'linewidth',1.5)
hold on;
plot(year, sH(1,:),'-s', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH(2,:),'-*', 'color', [0.8 0 0.6],...
    'MarkerFaceColor', [0.8 0 0.6], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH(3,:),'-^', 'color', [0 0.6 0.6],...
      'MarkerFaceColor',[0 0.6 0.6], 'MarkerSize',3,'linewidth',1.5)

plot(year, sL0(1,:),':+','color', [0.6 0 0.3],...
    'MarkerFaceColor', [0.6 0 0.3], 'MarkerSize',3,'linewidth',2)
plot(year, sL(1,:),':s', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, sL(2,:),':*', 'color', [0.8 0 0.6],...
    'MarkerFaceColor', [0.8 0 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, sL(3,:),':^', 'color', [0 0.6 0.6],...
      'MarkerFaceColor',[0 0.6 0.6], 'MarkerSize',3,'linewidth',2)

xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Survival rate','Interpreter','latex','FontSize',15)
legend('High cohort 0-1','High cohort 1-4','High cohort 5',...
       'High cohort 10','Low cohort 0-1',...
       'Low cohort 1-4','Low cohort 5',...
       'Low Cohort 10','Interpreter','latex','FontSize',...
        10,'location','southeast','numcolumns',2);

% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/HLSur1.pdf"); 

%% Time Path Survival High/Low Cohort 15-19 - Cohort 30-34  
figure(2); clf;
plot(year, sH(4,:),'-+','color', [0.6 0 0.6],...
    'MarkerFaceColor', [0.6 0 0.6], 'MarkerSize',3,'linewidth',1.5)
hold on;
plot(year, sH(5,:),'--s', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH(6,:),'--*', 'color', [0.6 0 0],...
    'MarkerFaceColor', [0.6 0 0], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH(7,:),'--^', 'color', [0 0.5 0],...
      'MarkerFaceColor',[0 0.5 0], 'MarkerSize',3,'linewidth',1.5)
  
plot(year, sL(4,:),':+','color', [0.6 0 0.6],...
    'MarkerFaceColor', [0.6 0 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, sL(5,:),':s', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, sL(6,:),':*', 'color', [0.6 0 0],...
    'MarkerFaceColor', [0.6 0 0], 'MarkerSize',3,'linewidth',2)
plot(year, sL(7,:),':^', 'color', [0 0.5 0],...
      'MarkerFaceColor',[0 0.5 0], 'MarkerSize',3,'linewidth',2)

xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Survival rate','Interpreter','latex','FontSize',15)
legend('High cohort 15','High cohort 20','High cohort 25',...
    'High cohort 30','Low cohort 15','Low cohort 20',...
    'Low cohort 25','Low cohort 30','Interpreter','latex',...
    'FontSize',10,'location','southeast','numcolumns',2);
% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/HLSur2.pdf");

%% Time Path Survival High/Low 35-39 - Cohort 50-54  
figure(3); clf;
plot(year, sH(8,:),'-+','color', [0.6 0 0.6],...
    'MarkerFaceColor', [0.6 0 0.6], 'MarkerSize',3,'linewidth',1.5)
hold on
plot(year, sH(9,:),'-s', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH(10,:),'-*', 'color', [0.4 0 0],...
    'MarkerFaceColor', [0.4 0 0], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH(11,:),'-^', 'color', [0 0.4 0],...
      'MarkerFaceColor',[0 0.4 0], 'MarkerSize',3,'linewidth',1.5)
  
plot(year, sL(8,:),':+','color', [0.6 0 0.6],...
    'MarkerFaceColor', [0.6 0 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, sL(9,:),':s', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, sL(10,:),':*', 'color', [0.4 0 0],...
    'MarkerFaceColor', [0.4 0 0], 'MarkerSize',3,'linewidth',2)
plot(year, sL(11,:),':^', 'color', [0 0.4 0],...
      'MarkerFaceColor',[0 0.4 0], 'MarkerSize',3,'linewidth',2)

xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Survival rate','Interpreter','latex','FontSize',15)
legend('High cohort 35','High cohort 40','High cohort 45',...
    'High cohort 50', 'Low cohort 35','Low cohort 40',...
    'Low cohort 45','Low cohort 50','Interpreter','latex',...
    'FontSize',10,'location','southeast','numcolumns',2);
% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');      
exportgraphics(gcf,"Graphs/HLSur3.pdf");

%% Time Path Survival High/Low Cohort 55-59 - Cohort 70-74   
figure(4); clf;
plot(year, sH(12,:),'-+','color', [0.5 0 0.5],...
    'MarkerFaceColor', [0.5 0 0.5], 'MarkerSize',3,'linewidth',1.5)
hold on
plot(year, sH(13,:),'-s', 'color', [0 0.5 0.6],...
    'MarkerFaceColor', [0 0.5 0.6], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH(14,:),'-*', 'color', [0.5 0 0],...
    'MarkerFaceColor', [0.5 0 0], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH(15,:),'-^', 'color', [0 0.4 0],...
      'MarkerFaceColor',[0 0.4 0], 'MarkerSize',3,'linewidth',1.5)
  
plot(year, sL(12,:),':+','color', [0.5 0 0.5],...
    'MarkerFaceColor', [0.5 0 0.5], 'MarkerSize',3,'linewidth',2)
plot(year, sL(13,:),':s', 'color', [0 0.5 0.6],...
    'MarkerFaceColor', [0 0.5 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, sL(14,:),':*', 'color', [0.5 0 0],...
    'MarkerFaceColor', [0.5 0 0], 'MarkerSize',3,'linewidth',2)
plot(year, sL(15,:),':^', 'color', [0 0.4 0],...
      'MarkerFaceColor',[0 0.4 0], 'MarkerSize',3,'linewidth',2)

xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Survival rate','Interpreter','latex','FontSize',15)
legend('High cohort 55','High cohort 60','High cohort 65',...
       'High cohort 70','Low cohort 55','Low cohort 60',...
       'Low cohort 65','Low cohort 70', 'Interpreter','latex',...
       'FontSize',10,'location','southeast','numcolumns',2);
% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/HLSur4.pdf");

%% Time Path Survival Cohort 75-79 - Cohort 95-99   
figure(5); clf; 
plot(year, sH(16,:),'-+','color', [0.6 0 0.6],...
    'MarkerFaceColor', [0.6 0 0.6], 'MarkerSize',3,'linewidth',1.5)
hold on
plot(year, sH(17,:),'-s', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH(18,:),'-*', 'color', [0.6 0 0],...
    'MarkerFaceColor', [0.6 0 0], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH(19,:),'-^', 'color', [0.5 0.5 0],...
      'MarkerFaceColor',[0.5 0.5 0], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH(20,:),'-+','color', [0.6 0 0.6],...
    'MarkerFaceColor', [0.6 0 0.6], 'MarkerSize',3,'linewidth',1.5)

plot(year, sL(16,:),':+','color', [0.6 0 0.6],...
    'MarkerFaceColor', [0.6 0 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, sL(17,:),':s', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, sL(18,:),':*', 'color', [0.6 0 0],...
    'MarkerFaceColor', [0.6 0 0], 'MarkerSize',3,'linewidth',2)
plot(year, sL(19,:),':^', 'color', [0.5 0.5 0],...
      'MarkerFaceColor',[0 0.5 0], 'MarkerSize',3,'linewidth',2)
plot(year, sL(20,:),':+','color', [0.6 0 0.6],...
    'MarkerFaceColor', [0.6 0 0.6], 'MarkerSize',3,'linewidth',2)

xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Survival Rate','Interpreter','latex','FontSize',15)
legend('High cohort 75', 'High cohort 80','High cohort 85',...
       'High cohort 90', 'High cohort 95', ...
       'Low cohort 75', 'Low cohort 80', 'Low cohort 85', ...
       'Low cohort 90', 'Low cohort 95', 'Interpreter','latex','FontSize',10,...
    'location','Northwest','numcolumns',2);
% Auto-formatting for ticks
ylim([0.0, 0.78]);
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/HLSur5.pdf");


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                   % Survival Counterfactual
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Time Path Survival Rates High and Low Skill Cohort 00-01 - Cohort 10-14 
figure(1); clf;
plot(year, sH0_cf(1,:),'-+','color', [0.8 0 0.3],...
    'MarkerFaceColor', [0.6 0 0.3], 'MarkerSize',3,'linewidth',1.5)
hold on;
plot(year, sH_cf(1,:),'-s', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH_cf(2,:),'-*', 'color', [0.8 0 0.6],...
    'MarkerFaceColor', [0.8 0 0.6], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH_cf(3,:),'-^', 'color', [0 0.6 0.6],...
      'MarkerFaceColor',[0 0.6 0.6], 'MarkerSize',3,'linewidth',1.5)

plot(year, sL0_cf(1,:),':+','color', [0.6 0 0.3],...
    'MarkerFaceColor', [0.6 0 0.3], 'MarkerSize',3,'linewidth',2)
plot(year, sL_cf(1,:),':s', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, sL_cf(2,:),':*', 'color', [0.8 0 0.6],...
    'MarkerFaceColor', [0.8 0 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, sL_cf(3,:),':^', 'color', [0 0.6 0.6],...
      'MarkerFaceColor',[0 0.6 0.6], 'MarkerSize',3,'linewidth',2)

xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Survival rate','Interpreter','latex','FontSize',15)
legend('High cohort 0-1','High cohort 1-4','High cohort 5',...
       'High cohort 10','Low cohort 0-1',...
       'Low cohort 1-4','Low cohort 5',...
       'Low cohort 10','Interpreter','latex','FontSize',...
        10,'location','southeast','numcolumns',2);
% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/HLSur1_cf.pdf"); 

%% Time Path Survival High/Low: Cohort 15-19 - Cohort 30-34  
figure(2); clf;
plot(year, sH_cf(4,:),'-+','color', [0.6 0 0.6],...
    'MarkerFaceColor', [0.6 0 0.6], 'MarkerSize',3,'linewidth',1.5)
hold on;
plot(year, sH_cf(5,:),'-s', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH_cf(6,:),'-*', 'color', [0.6 0 0],...
    'MarkerFaceColor', [0.6 0 0], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH_cf(7,:),'-^', 'color', [0 0.5 0],...
      'MarkerFaceColor',[0 0.5 0], 'MarkerSize',3,'linewidth',1.5)
  
plot(year, sL_cf(4,:),':+','color', [0.6 0 0.6],...
    'MarkerFaceColor', [0.6 0 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, sL_cf(5,:),':s', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, sL_cf(6,:),':*', 'color', [0.6 0 0],...
    'MarkerFaceColor', [0.6 0 0], 'MarkerSize',3,'linewidth',2)
plot(year, sL_cf(7,:),':^', 'color', [0 0.5 0],...
      'MarkerFaceColor',[0 0.5 0], 'MarkerSize',3,'linewidth',2)

xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Survival rate','Interpreter','latex','FontSize',15)
legend('High cohort 15','High cohort 20','High cohort 25',...
    'High cohort 30','Low cohort 15','Low cohort 20',...
    'Low cohort 25','Low cohort 30','Interpreter','latex',...
    'FontSize',10,'location','southeast','numcolumns',2);
% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/HLSur2_cf.pdf");

%% Time Path Survival High/Low Cohort 35-39 - Cohort 50-54  
figure(3); clf;
plot(year, sH_cf(8,:),'-+','color', [0.6 0 0.6],...
    'MarkerFaceColor', [0.6 0 0.6], 'MarkerSize',3,'linewidth',1.5)
hold on
plot(year, sH_cf(9,:),'-s', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH_cf(10,:),'-*', 'color', [0.4 0 0],...
    'MarkerFaceColor', [0.4 0 0], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH_cf(11,:),'-^', 'color', [0 0.4 0],...
      'MarkerFaceColor',[0 0.4 0], 'MarkerSize',3,'linewidth',1.5)
  
plot(year, sL_cf(8,:),':+','color', [0.6 0 0.6],...
    'MarkerFaceColor', [0.6 0 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, sL_cf(9,:),':s', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, sL_cf(10,:),':*', 'color', [0.4 0 0],...
    'MarkerFaceColor', [0.4 0 0], 'MarkerSize',3,'linewidth',2)
plot(year, sL_cf(11,:),':^', 'color', [0 0.4 0],...
      'MarkerFaceColor',[0 0.4 0], 'MarkerSize',3,'linewidth',2)

xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Survival rate','Interpreter','latex','FontSize',15)
legend('High cohort 35','High cohort 40','High cohort 45',...
    'High cohort 50', 'Low cohort 35','Low cohort 40',...
    'Low cohort 45','Low cohort 50','Interpreter','latex',...
    'FontSize',10,'location','southeast','numcolumns',2);
% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');      
exportgraphics(gcf,"Graphs/HLSur3_cf.pdf");

%% Time Path Survival High/Low Cohort 55-59 - Cohort 70-74   
figure(4); clf;
plot(year, sH_cf(12,:),'-+','color', [0.5 0 0.5],...
    'MarkerFaceColor', [0.5 0 0.5], 'MarkerSize',3,'linewidth',1.5)
hold on
plot(year, sH_cf(13,:),'-s', 'color', [0 0.5 0.6],...
    'MarkerFaceColor', [0 0.5 0.6], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH_cf(14,:),'-*', 'color', [0.5 0 0],...
    'MarkerFaceColor', [0.5 0 0], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH_cf(15,:),'-^', 'color', [0 0.4 0],...
      'MarkerFaceColor',[0 0.4 0], 'MarkerSize',3,'linewidth',1.5)
  
plot(year, sL_cf(12,:),':+','color', [0.5 0 0.5],...
    'MarkerFaceColor', [0.5 0 0.5], 'MarkerSize',3,'linewidth',2)
plot(year, sL_cf(13,:),':s', 'color', [0 0.5 0.6],...
    'MarkerFaceColor', [0 0.5 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, sL_cf(14,:),':*', 'color', [0.5 0 0],...
    'MarkerFaceColor', [0.5 0 0], 'MarkerSize',3,'linewidth',2)
plot(year, sL_cf(15,:),':^', 'color', [0 0.4 0],...
      'MarkerFaceColor',[0 0.4 0], 'MarkerSize',3,'linewidth',2)

xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Survival rate','Interpreter','latex','FontSize',15)
legend('High cohort 55','High cohort 60','High cohort 65',...
       'High cohort 70','Low cohort 55','Low cohort 60',...
       'Low cohort 65','Low cohort 70', 'Interpreter','latex',...
       'FontSize',10,'location','southeast','numcolumns',2);
% Auto-formatting for ticks
ylim padded;
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/HLSur4_cf.pdf");

%% Time Path Survival Cohort 75-79 - Cohort 95-99   
figure(5); clf;   
plot(year, sH_cf(16,:),'-+','color', [0.6 0 0.6],...
    'MarkerFaceColor', [0.6 0 0.6], 'MarkerSize',3,'linewidth',1.5)
hold on
plot(year, sH_cf(17,:),'-s', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH_cf(18,:),'-*', 'color', [0.6 0 0],...
    'MarkerFaceColor', [0.6 0 0], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH_cf(19,:),'-^', 'color', [0.5 0.5 0],...
      'MarkerFaceColor',[0.5 0.5 0], 'MarkerSize',3,'linewidth',1.5)
plot(year, sH_cf(20,:),'-+','color', [0.6 0 0.6],...
    'MarkerFaceColor', [0.6 0 0.6], 'MarkerSize',3,'linewidth',1.5)

plot(year, sL_cf(16,:),':+','color', [0.6 0 0.6],...
    'MarkerFaceColor', [0.6 0 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, sL_cf(17,:),':s', 'color', [0 0 0.6],...
    'MarkerFaceColor', [0 0 0.6], 'MarkerSize',3,'linewidth',2)
plot(year, sL_cf(18,:),':*', 'color', [0.6 0 0],...
    'MarkerFaceColor', [0.6 0 0], 'MarkerSize',3,'linewidth',2)
plot(year, sL_cf(19,:),':^', 'color', [0.5 0.5 0],...
      'MarkerFaceColor',[0 0.5 0], 'MarkerSize',3,'linewidth',2)
plot(year, sL_cf(20,:),':+','color', [0.6 0 0.6],...
    'MarkerFaceColor', [0.6 0 0.6], 'MarkerSize',3,'linewidth',2)

xlabel('Year','Interpreter','latex','FontSize',15)
ylabel('Survival rate','Interpreter','latex','FontSize',15)
legend('High cohort 75', 'High cohort 80','High cohort 85',...
       'High cohort 90', 'High cohort 95', ...
       'Low cohort 75', 'Low cohort 80', 'Low cohort 85', ...
       'Low cohort 90', 'Low cohort 95', 'Interpreter','latex','FontSize',9.5,...
    'location','Northwest','numcolumns',2);
% Auto-formatting for ticks
ylim([0.07, 0.73]);
set(gca, 'YTickMode', 'auto');
ytickformat('%.2f');
box on;
grid off;
hold off; 
set(gcf, 'WindowStyle', 'normal');
exportgraphics(gcf,"Graphs/HLSur5_cf.pdf");