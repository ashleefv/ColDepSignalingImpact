%% Function to solve the dimensionless cellular signaling equation 
function concoverkmdata = CellularSignalingDimensionless(zeta,Tau,alpha)
    concoverkmdata = [];
    for i = 1:length(Tau)
        A = abs(zeta-1)./sqrt(Tau(i));
        B = abs(zeta+1)./sqrt(Tau(i));
        concoverkm_unitless = alpha*sqrt(Tau(i)./(4*zeta.^2)).*(((exp(-A.^2)-exp(-B.^2))/sqrt(pi()))-A.*erfc(A)+B.*erfc(B));
        concoverkmdata = [concoverkmdata;concoverkm_unitless];
    end
end