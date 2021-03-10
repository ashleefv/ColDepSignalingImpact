%% Haryana Thomas 2/22/2021
% Function that solves the hindered diffusion for multiple solute radius
% and volume fraction values. Rows vary as a function of rs and columns
% vary as a function of phi.

function DiffusionCoeff = MultipleDiffusionCoeff(rs,phi,rf)

DiffusionCoeff = zeros(length(rs),length(phi),length(rf));
for k = 1:length(rf)
    for j = 1:length(phi)
        for i = 1:length(rs)            
             DiffusionCoeff(i,j,k) = HinderedDiffusion(rs(i),phi(j),rf(k));         
        end    
    end
end
end