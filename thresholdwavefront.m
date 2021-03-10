%% Dr. Ford Versypt, Haryana Thomas 09/07/2020
% Outputs the wave front propagation curve at a given concentration
% threshold. Default threshold value = 1
%Inputs
    % data: concentration values at each time and position
    % spatialdomain: logspace set of values between 0 and max r value
    % timespan: logspace set of values between 0 and max time value
% Output
    % Propagation of the wavefront over a period of time
    % Wavefront - The points at which the concentration equals 1 
    
%% The required input data 
function [tvalue,rvalue] = thresholdwavefront(spatialdomain,timespan,data)
    r = spatialdomain;
    t = timespan;
    % Variables for storing wavefront data
    tvalue = [];
    rvalue = [];
    wavefrontvalue = [];
    
    % Iterates through conc values to obtain the first zeta values at which the
    % concentration equals one
    for j = 1:length(t)
        concvalues = data(j,:);
        i = length(r);
        while concvalues(i) < 1 && i > 1
            i = i-1;
        end
        rvalue = [rvalue,r(i)];
        tvalue = [tvalue,t(j)];
        wavefrontvalue = [wavefrontvalue,concvalues(i)];
    end
end

