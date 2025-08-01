function results = SimulatePopulationHL(data, params)
% SimulatePopulationHL Simulates population dynamics under actual and counterfactual scenarios
%
% This function models the evolution of population cohorts over time, disaggregated by high- and low-skill groups.
% It incorporates survival, fertility, migration, and skill transmission processes, adjusting survival rates 
% dynamically based on skill composition and intergenerational transmission probabilities.
%
% The model accounts for both a baseline (actual) scenario and a counterfactual scenario, allowing comparisons 
% of demographic outcomes under different assumptions about skill formation (piH, piL) and related parameters.
%
% INPUTS:
%   data   - Structure containing cohort-specific matrices:
%            pop_sim, pop_cf   : Initial population distributions (actual, counterfactual)
%            s, s0             : Survival rates by cohort and initial cohort
%            n, m, frf         : Fertility, migration, and female ratio factors
%            psi, psi0         : Skill-related survival adjustments/shock (cohort and initial)
%            Hor, Coh          : Number of time periods and cohort groups
%   params - Structure containing key parameters:
%            piH, piL          : Probabilities of high-skill transmission from parents to children
%
% OUTPUT:
%   results - Structure containing simulation results:
%             popSim, popCF    : Total simulated populations over time
%             popH, popL       : High- and low-skill population paths (actual)
%             popH_cf, popL_cf : High- and low-skill population paths (counterfactual)
%             TotPop*          : Total populations across all cohorts (H, L, Sim, CF)
%             theta, theta_cf  : Fraction of high-skilled individuals over time
%             sH, sL           : Survival rates for high- and low-skilled (actual)
%             sH_cf, sL_cf     : Survival rates (counterfactual)
%             sH0, sL0         : Initial survival rates (actual and counterfactual)

    
    %% Unpack data
    pop_sim = data.pop_sim;
    pop_cf  = data.pop_cf;
    s       = data.s;
    s0      = data.s0;
    s_cf    = data.s_cf;
    s0_cf   = data.s0_cf;
    n       = data.n;
    n_cf    = data.n_cf;
    m       = data.m;
    m_cf    = data.m_cf;
    frf     = data.frf;
    Hor     = data.Hor;
    Coh     = data.Coh;
    psi     = data.psi;
    psi0    = data.psi0;
    psi_cf  = data.psi_cf;
    psi0_cf = data.psi0_cf;
    
    %% Unpack parameters
    piH = params.piH;
    piL = params.piL;
    
    % Initialize matrices
    theta     = ones(Coh, Hor);
    theta_cf  = ones(Coh, Hor);
    popSim    = ones(Coh, Hor);
    popCF     = ones(Coh, Hor);
    popH      = ones(Coh, Hor);
    popL      = ones(Coh, Hor);
    popH_cf   = ones(Coh, Hor);
    popL_cf   = ones(Coh, Hor);
    sH        = ones(Coh-1, Hor);
    sL        = ones(Coh-1, Hor);
    sH_cf     = ones(Coh-1, Hor);
    sL_cf     = ones(Coh-1, Hor);
    sL0       = ones(1, Hor);
    sL0_cf    = ones(1, Hor);
    sH0       = ones(1, Hor);
    sH0_cf    = ones(1, Hor);
    tau       = ones(1, Hor);
    tau_cf    = ones(1, Hor);
    tot_nbH   = ones(1, Hor);
    tot_nbL   = ones(1, Hor);
    tot_nbHcf = ones(1, Hor);
    tot_nbLcf = ones(1, Hor);
    
    % Initial theta steady-state value
    theta_SS = piL / (1 + piL - piH);
    theta(:,1) = theta_SS;
    theta_cf(:,1) = theta_SS;
    
    % Initial population split by skill
    popSim(:,1) = pop_sim(:,1);
    popCF(:,1) = pop_cf(:,1);
    popH(:,1) = theta(:,1) .* pop_sim(:,1);
    popL(:,1) = (1 - theta(:,1)) .* pop_sim(:,1);
    popH_cf(:,1) = theta_cf(:,1) .* pop_cf(:,1);
    popL_cf(:,1) = (1 - theta_cf(:,1)) .* pop_cf(:,1);
       
    %% Simulating High/Low Pop 
    
    % popualtion in 1950
    for i=1:Coh
        popH(i,1) = theta(i,1)*popSim(i,1);
        popH_cf(i,1) = theta_cf(i,1)*pop_cf(i,1);
        popL(i,1) = (1-theta(i,1))*popSim(i,1);
        popL_cf(i,1) = (1-theta_cf(i,1))*pop_cf(i,1);
        
    end  
        
    % sum H and L population in 1950
    popSim(:,1) = popH(:,1) + popL(:,1);
    popCF(:,1) = popH_cf(:,1) + popL_cf(:,1);
    
    % survival rates cohor 0-1, 1-4, 5-9,...
    for i=1:Hor  
        
         sH0(1,i) = (1+psi0(1,i))*s0(1,i);
         sH0_cf(1,i) = (1+psi0_cf(1,i))*s0_cf(1,i);
           
         for j=1:Coh-1
    
             sH(j,i) = (1+psi(j,i))*s(j,i);
             sH_cf(j,i) = (1+psi_cf(j,i))*s_cf(j,i);
            
         end 
    end 
    
    % initial tau at 1950 (equals to theta at the steady state level: theta_SS)
    tau(1,1) = theta_SS;
    tau_cf(1,1) = theta_SS;
    
    % Low-skilled survival rates in 1950 (when psi is not equal to zero)
    sL0(1,1) = (s0(1,1)*(1-((1+psi0(1,1))*tau(1,1))))/(1-tau(1,1));
    sL(:,1) = (s(:,1).*(1-((1+psi(:,1)).*theta(1:end-1,1))))./(1-theta(1:end-1,1));
    
    sL0_cf(1,1) = (s0_cf(1,1)*(1-((1+psi0_cf(1,1))*tau_cf(1,1))))/(1-tau_cf(1,1));
    sL_cf(:,1) = (s_cf(:,1).*(1-((1+psi_cf(:,1)).*theta_cf(1:end-1,1))))./(1-theta_cf(1:end-1,1));
    
        
    % simulating High-skilled pop
    for i=1:Hor
        
        if i>1
            % tau: fraction of high-skilled children
            tau(1,i) = tot_nbH(1,i)/(tot_nbH(1,i)+tot_nbL(1,i));
            tau_cf(1,i) = tot_nbHcf(1,i)/(tot_nbHcf(1,i)+tot_nbLcf(1,i));
        
             % low-skilled newborn survivial rates
            sL0(1,i) = (s0(1,i)*(1-((1+psi0(1,i))*tau(1,i))))/(1-tau(1,i));
            sL0_cf(1,i) = (s0_cf(1,i)*(1-((1+psi0_cf(1,i))*tau_cf(1,i))))/(1-tau_cf(1,i));
        end 
        
        if i<Hor
            % Generate New-born Size at t for t+1 (Simulation, Counterfactual)
            tot_nbH(1,i)= sum((5.*sH0(1,i).*n(4:10,i).*m(4:10,i).*frf(4:10,i).*popH(4:10,i)));
            tot_nbHcf(1,i)= sum((5.*sH0_cf(1,i).*n_cf(4:10,i).*m_cf(4:10,i).*frf(4:10,i).*popH_cf(4:10,i)));
    
            tot_nbL(1,i)= sum((5.*sL0(1,i).*n(4:10,i).*m(4:10,i).*frf(4:10,i).*popL(4:10,i)));
            tot_nbLcf(1,i)= sum((5.*sL0_cf(1,i).*n_cf(4:10,i).*m_cf(4:10,i).*frf(4:10,i).*popL_cf(4:10,i)));
    
            % Total New-born high-skilled
            popH(1,i+1)   = piH*tot_nbH(1,i)   + piL*tot_nbL(1,i);
            popH_cf(1,i+1)= piH*tot_nbHcf(1,i) + piL*tot_nbLcf(1,i);
    
            % Total New-born Low-skilled
            popL(1,i+1)   = (1-piH)*tot_nbH(1,i)   + (1-piL)*tot_nbL(1,i);
            popL_cf(1,i+1)= (1-piH)*tot_nbHcf(1,i) + (1-piL)*tot_nbLcf(1,i);
    
            % size population of new-born
            popSim(1,i+1) = popH(1,i+1)+popL(1,i+1); 
            popCF(1,i+1) = popH_cf(1,i+1)+popL_cf(1,i+1); 
    
             % Theta for newborn from 1955
            theta(1,i+1) = popH(1,i+1)/popSim(1,i+1);
            theta_cf(1,i+1) = popH_cf(1,i+1)/popCF(1,i+1);
    
            % update next cohorts in next periods up to ages 100  
            % high-skilled pop
            popH(2:end,i+1) = sH(1:end,i).*m(1:end,i).*popH(1:end-1,i);
            popH_cf(2:end,i+1) = sH_cf(1:end,i).*m_cf(1:end,i).*popH_cf(1:end-1,i);
            % low-skilled pop
            popL(2:end,i+1) = sL(1:end,i).*m(1:end,i).*popL(1:end-1,i);
            popL_cf(2:end,i+1) = sL_cf(1:end,i).*m_cf(1:end,i).*popL_cf(1:end-1,i);
            % total pop
            popSim(2:end,i+1) = popH(2:end,i+1) + popL(2:end,i+1);
            popCF(2:end,i+1) = popH_cf(2:end,i+1) + popL_cf(2:end,i+1);
    
            % update theta: fraction of high-skilled cohorts from 5 onward 
            theta(2:end,i+1) = popH(2:end,i+1)./popSim(2:end,i+1);
            theta_cf(2:end,i+1) = popH_cf(2:end,i+1)./popCF(2:end,i+1);
    
            % update Low-skilled survival rates 1955 onward
            sL(1:end,i+1) = (s(1:end,i+1).*(1-((1+psi(1:end,i+1)).*theta(1:end-1,i+1))))./(1-theta(1:end-1,i+1));
            sL_cf(1:end,i+1) = (s_cf(1:end,i+1).*(1-((1+psi_cf(1:end,i+1)).*theta_cf(1:end-1,i+1))))./(1-theta_cf(1:end-1,i+1));  
        end 
    end
    
    % Total Population 
    TotPopH=sum(popH);
    TotPopL=sum(popL); 
    TotPopH_cf=sum(popH_cf); 
    TotPopL_cf=sum(popL_cf);
    
    TotPopSim=sum(popSim); % Simulation
    TotPopCF=sum(popCF); 
    %% Pack results
    results.popSim   = popSim;
    results.popCF    = popCF;
    results.TotPopSim = TotPopSim;
    results.TotPopCF  = TotPopCF;
    results.popH     = popH;
    results.popL     = popL;
    results.popH_cf  = popH_cf;
    results.popL_cf  = popL_cf;
    results.TotPopH     = TotPopH;
    results.TotPopL     = TotPopL;
    results.TotPopH_cf  = TotPopH_cf;
    results.TotPopL_cf  = TotPopL_cf;
    results.theta    = theta;
    results.theta_cf = theta_cf;

    results.sH        = sH;
    results.sL        = sL;
    results.sH_cf     = sH_cf;
    results.sL_cf     = sL_cf;
    results.sL0       = sL0;
    results.sL0_cf    = sL0_cf;
    results.sH0       = sH0 ;
    results.sH0_cf    = sH0_cf;

end


