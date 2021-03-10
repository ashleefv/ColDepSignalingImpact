% Haryana Thomas August 10, 2020
% function to solve the dimensional solution to the intercellular communication
% diffusion equation used in Francis & Polsson.
%% Function to solve the dimensional cellular signaling equation

function concoverkm = CellularSignalingAnalytical(radius,time,rho,D,alpha)
    concoverkm = [];
    for j = 1:length(time)
            A = ((radius-rho).^2)./(4*D.*time(j));
            B = ((radius+rho).^2)./(4*D.*time(j));
            coeff = sqrt((4*D/pi()).*time(j));
            C = abs(radius-rho)./sqrt(4*D.*time(j));
            E = (radius+rho)./sqrt(4*D.*time(j));  
            F = abs(radius-rho);
            G = (radius+rho);
            concoverkm = [concoverkm;(alpha./(2*radius)).*(coeff.*((exp(-A)-exp(-B)))-F.*erfc(C)+G.*erfc(E))];          
    end
end