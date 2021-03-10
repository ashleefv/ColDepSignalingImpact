% Haryana Thomas August 10, 2020 - February 19, 2020
% Solving and visulazing the dimensional concentration profiles, propagation distance,
% diffusivity, and variable diffusion concentration profiles for signaling molecules within the 
% mesangium.

%% Dimensionlal Inputs
    % time: dimensional time
    % radius: dimensional distance
        % Note: Each section/figure has its own time and radius specification
        % because each figure works best with different discretization steps.     
% Dimensionless Inputs
    % Tau: Nondimensional time
    % Zeta: Nondimensional radial distance
% Outputs:
    % C(r,t): Concentration profiles for signaling molecules (figure 1a)
    % r(t): propagation distance for signaling molecule at threshold conc., Km (figure 1b)
    % ESD(phi,rs): Effective signaling distance (ESD) for varying volume fraction (phi) and solute radius (rs) (Figure 3)
    % C(r,t,D): Concentration profiles for varying diffusion coefficients (figure 4)
    % Code verification sections

%% Input Parameters
D = 1.42e-6;                                        % Diffusion coefficient for the base case (cm^2/s) - Used in figures 1a and b
km = 1e-14;                                         % Threshold concentration (mol/cm^3)
rho = 5e-4;                                         % Cell radius (cm)
NA = 6.02*10^23;                                    % Avogadro's constant  (molecules/mol)
SA = 4*pi()*rho^2;                                  % Surface area of sphere (cm^2)
Fo =100/NA/SA;                                      % Molar secretion rate units (mol/cm^2/s)

% Input parameter for verification purposes
alpha = Fo*rho/(D*km);                              % Dimensionless parameter used for base case

%% Dimensional concentration profiles (Figures 1a)

%%{
    radius = linspace(0.0005,0.01,10000);
    time = [1.0e-3,1.0e-2,1.0e-1,1.0e0,1e+1,1e+2,1e+3,1e+4,1e+5,1e+6,1e+7,1e+8];  % using this instead of logspace to print out legend in scientific notation
    dimensionalprofile = CellularSignalingAnalytical(radius,time,rho,D,alpha);
    
% Plots    
    figure(10);
    colors = distinguishable_colors(length(time));
    for j = 1:length(time)
        curr_color = colors(j,:);
        plot(radius,dimensionalprofile(j,:),'displayname', ['t = 1E' num2str(log10(time(j))) ' s'],'color',curr_color)
        hold on
    end
    xlabel('r (cm)'); ylabel('C/{k_m}'), 
    legend('-Dynamiclegend')

    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w'); grid on;
    export_fig('Research/Figures/conc_profile','-r1000','-a4', '-q101', '-painters', '-png');

%% Propagation distance profile (figure 1b)
    radius_pd = linspace(0.0005,0.01,10000);
    time_pd = logspace(-3,8,96)';              % Large number of time steps to obtain smooth curve for propagation distance plot
    dimensionalprofile = CellularSignalingAnalytical(radius_pd,time_pd,rho,D,alpha);
    
    figure(11);
    [tvalue,rvalue] = thresholdwavefront(radius_pd,time_pd,dimensionalprofile);
    semilogx(tvalue,rvalue)
    xlabel('t (s)'),ylabel('r (cm)'), axis([1e-3 1e+8,0.0005 0.001]);

    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w'); grid on;
    export_fig('Research/Figures/wavefront','-r1000','-a4', '-q101', '-painters', '-png');

%% Collagen deposition (phi) impact on diffusivity (Figure 2)

%%{
    rs = linspace(20e-8,60e-8,3);                         % units are in cm
    phi = linspace(0,0.25,100);
    rf = [5e-7,15e-7,25e-7];                             % units are in cm
    multiple_DC = MultipleDiffusionCoeff(rs,phi,rf);
    
% Plots 
    figure(20);
    for i = 1:length(rs)
        plot(phi,multiple_DC(i,:,1),'-');
        hold on
        plot(phi,multiple_DC(i,:,2),'--');
        hold on
        plot(phi,multiple_DC(i,:,3),'-.','color',[0.4660, 0.6740, 0.1880]);
        ax = gca;
        ax.ColorOrderIndex = 1;   
    end
    ax = gca;
    text(ax,0.05,1.45e-6,'r_s = 2 nm')
    text(ax,0.05,0.73e-6,'r_s = 4 nm')
    text(ax,0.05,0.18e-6,'r_s = 6 nm')
    xlabel('{\fontsize{12}\phi}'),ylabel('D $\textbf{$\left(\frac{cm^2}{s}\right)$}$','interpreter', 'latex'), 
    legend('{r_f} = 5 nm','{r_f} = 15 nm','{r_f} = 25 nm')

    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w'); grid on;
    export_fig('Research/Figures/Diffusivity','-r1000','-a4', '-q101', '-painters', '-png');

%% ESD dependence on volume fraction and solute radius (Figure 3)

%%{
    x = linspace(20e-8,60e-8,10);
    y = linspace(0.05,0.3,10);
    [soluteradius,volumefraction] = meshgrid(x,y);
    rf = 20e-7;
    DiffusionCoefficient = HinderedDiffusion(soluteradius,volumefraction,rf);
    ESD = Fo*rho./(km*DiffusionCoefficient);
    
% Surface plot with lines overlaid 
    figure(30);
    s = surf(soluteradius,volumefraction,ESD);
    s.EdgeColor = 'none';
    hold on
    plot3(soluteradius(1,:), ones(size(soluteradius(1,:)))*volumefraction(1,1), ESD(1,:),'color',[0 0.5 0], 'LineWidth',3)
    hold on
    plot3(soluteradius(3,:), ones(10)*volumefraction(3,1), ESD(3,:),'color',[0.9290, 0.6940, 0.1250], 'LineWidth',2)
    hold on
    plot3(soluteradius(5,:), ones(10)*volumefraction(5,1), ESD(5,:),'-r', 'LineWidth',2)
    hold off
    xlabel('r_{s} (cm)'),ylabel('{\fontsize{15}\phi}'),zlabel('ESD')

    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w'); set(0,'defaultAxesFontSize',10);
    export_fig('Research/Figures/surfaceplot','-r1000','-a4', '-q101', '-painters', '-png');

%% subplots of the concentration profiles of two different diffusion coefficients (figure 4)
% coefficients at different time points

%%{
    radius = linspace(0.0005,0.1,50000);
    time = logspace(1,4,4)'; 
    DC = [1e-6,1e-7];       
    varD_concprofile = CellularSignalingVarD(radius,time,rho,DC,Fo,km);
    
% Constructing the subplots at 4 different  time points
    figure(40);
    for j = 1:length(time)
        subplot(2,2,j)  
        for k = 1 : length(DC)
            plot(radius,varD_concprofile{k}(j,:))
            ax1 = gca; grid on
            hold on
        end
    end
    
    for j = 1:length(time)
        subplot(2,2,j)  
        titlestring = ['t = ',num2str(time(j)),' s'];
        xlabel('r (cm)'); ylabel('C/{k_m}'),ylim([0 2.50]),xlim([0 0.05])
        title(titlestring),legend('1e-6 cm^2/s','1e-7 cm^2/s');
        
        get(gca);set(gca,'FontSize',9,'FontName','Arial');
        set(gcf, 'Color', 'w'),grid on
    end
% Zoomed in plot for top left subplot
    ax2 = axes('OuterPosition',[.25 .61 .2 .2]);
    box on
    for k = 1 : length(DC)
        plot(radius,varD_concprofile{k}(1,:)),ylim([0 0.6]),xlim([0 0.01]),
        hold on
        
        get(gca);set(gca,'FontSize',10,'FontName','Arial');
        set(gcf, 'Color', 'w'),grid on  
    end

    export_fig('Research/Figures/VarD_subplots','-r1000','-a4', '-q101', '-painters', '-png');
    %}
%% Verification that code gives the same outputs as Francis et al. 
% The only output plot in Francis et al. that can be used to verify that our equations are being 
% solved correctly is a dimensionless plot of the propagation distance. To make sure that our 
% dimensional profile output plots are accurate, we plot the dimensionless profile to obtain the 
% dimensionless propagation distance plot which we compare to the plot in
% Francis et al. (1997). This also verifies that our thresholdwavefront function is working properly.

% Solving the dimensionless equation to obtain a dimensionless
% concentration profile
% alpha_francis = 100;
% zeta = linspace(0,100,500);
% Tau = logspace(-2,8,44)'; 
% dimensionlessprofile = CellularSignalingDimensionless(zeta,Tau,alpha_francis);

% figure;
% for i = 1:length(Tau)
%     plot(zeta,dimensionlessprofile(i,:),'displayname',['Tau = ' num2str(Tau(i))])
%     hold on
% end
% xlabel('zeta'); ylabel('Conc/km'), grid on,legend('-Dynamiclegend'),set(gcf, 'Color', 'w');

% Obtaining the propagation distance of signaling molecules as a function of time

% [tvalue,rvalue] = thresholdwavefront(zeta,Tau,dimensionlessprofile);
% semilogx(tvalue,rvalue)
% xlabel('Tau'),ylabel('Zeta'),grid on,set(gcf, 'Color', 'w');

%% Obtaining the dimensional solution by non dimensionalizing dimensionless variables
% Verification step to make sure that dimensional concentration profile
% obtained in figure 1a is the same as dimensional concentration profile
% obtained by non dimensionalizing the dimensionless variables.

% zeta = radius./rho;
% Tau = 4*D.*time./(rho^2);
% dimensionlessprofile = CellularSignalingDimensionless(zeta,Tau,alpha);
% 
% figure;
% for i = 1:length(time)
%     plot(radius,dimensionlessprofile(i,:),'displayname',['time = ' num2str(time(i))])
%     hold on
% end
% xlabel('radius (cm)'); ylabel('Conc/km'), grid on,legend('-Dynamiclegend'),set(gcf, 'Color', 'w');
