% Haryana Thomas November 4, 2020 (Election day)
% Goal - Obtain concentration profiles at two different diffusion coefficients

%%
 function varD_concoverkm = CellularSignalingVarD(radius,time,rho,DC,Fo,km)
        n = length(DC) ;
        varD_concoverkm = cell(n, 1) ;
        for i = 1:length(DC)
            D = DC(i);
            alpha = Fo*rho/(D*km);                           
            output = CellularSignalingAnalytical(radius,time,rho,D,alpha);
            varD_concoverkm{i} = output;
        end
 end   