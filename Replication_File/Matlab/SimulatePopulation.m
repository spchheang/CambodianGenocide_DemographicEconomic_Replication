function results = SimulatePopulation(data)
% SimulatePopulation Simulates actual and counterfactual population dynamics
%
% INPUT:
%   data - structure with population, survival, fertility, migration matrices
%
% OUTPUT:
%   results - structure with simulated actual and counterfactual populations
    
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
    
   % Simulation of Actual and Counterfactual population regardless of skill

    for i=1:Hor-1
       
        % Generate Total New-born Size (Simulation, Counterfactual)
        pop_sim(1,i+1) = sum((5*s0(1,i).*n(4:10,i).*m(4:10,i).*frf(4:10,i).*pop_sim(4:10,i)));
        pop_cf(1,i+1) = sum((5*s0_cf(1,i).*n_cf(4:10,i).*m_cf(4:10,i).*frf(4:10,i).*pop_cf(4:10,i)));
            
        % Pop size ages 5-100+
        for k=1:Coh-1
            pop_sim(k+1,i+1)= s(k,i).*m(k,i).*pop_sim(k,i);
            pop_cf(k+1,i+1)= s_cf(k,i).*m_cf(k,i).*pop_cf(k,i);
        end 
       
    end
    
    %Total Population
    TotPopSim =sum(pop_sim); % Simulation
    TotPopCF  =sum(pop_cf);  % Counterfactual
    
    %% Pack results
    results.pop_sim   = pop_sim;
    results.pop_cf    = pop_cf;
    results.TotPopSim = TotPopSim;
    results.TotPopCF  = TotPopCF;

end


