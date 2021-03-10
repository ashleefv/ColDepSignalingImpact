% Haryana Thomas 09/18/20
% A function to calculate the diffusion coefficient of molecules using the
% stokes einstein equation and equation for diffusion through porous materials
% Inputs
    % kb - Boltzman's constant (m^2*kg/s^2/k)
    % T - Temperature (k)
    % mu - viscosity of water at 310k (kg/m/s)
    % rs - solute radius (cm)
    % rf - fiber radius (cm)
    % phi - matrix volume fraction
% Outputs
    % D0 - Free diffusion coefficient (cm^2/s)
    % D - Hindered diffusion coefficient(cm^2/s)
    
function output = HinderedDiffusion(rs,phi,rf)
m2_to_cm2 = 10000;
m_to_cm = 100;
kb = 1.38e-23*m2_to_cm2;
T = 310;
mu = 7e-4/m_to_cm;
Do = kb*T./(6*pi()*mu.*rs);

lambda = rs./rf;
f = (1+lambda.^2).*phi;
b = 0.174.*log(59.6./lambda);
D = Do.*exp(-pi()*(phi.^b)).*exp(-0.84.*(f.^1.09));
output = D;
end