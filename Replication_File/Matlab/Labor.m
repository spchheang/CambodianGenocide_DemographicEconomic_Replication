function [L, Omega] = Labor(gamma, Input)
%Labor Computes effective labor (L) and adjusted saving rate (Omega)
%
%   Input:
%       Input - Struct with fields:
%           gamma   : gamma parameter vector
%           rho     : substitution parameter
%           sigmaW  : saving rate for workers
%           pop     : simulated population matrix
%
%   Outputs:
%       L           : effective labor
%       Omega       : adjusted saving rate

    % Unpack Input
    rho     = Input.rho;
    sigmaW  = Input.sigmaW;
    pop     = Input.pop;
    
   %% Effective labor: L
   L = (sum(gamma.*(pop(4:14,:).^rho))).^(1/rho);
   
   %% Compute Adjusted Saving Rate: Omega
   top = gamma .* sigmaW(4:14,:) .* (pop(4:14,:).^rho);
    
   Omega = sum(top) ./ (L.^rho);

end
