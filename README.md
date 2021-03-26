# ColDepSignalingImpact
Collagen Deposition Impact on Intercellular Signaling in Diabetic Kidney Disease

[![DOI](https://zenodo.org/badge/346521454.svg)](https://zenodo.org/badge/latestdoi/346521454)

## Overview 
This mathematical model describes the effect of collagen deposition in the mesangial matrix on the signaling range of mesangial cells. This model consists of multiple parts: a mathematical model to describe the concentration profile of signaling molecules from the surface of the cell, an analysis of the concentration profile at the the threshold concentration to obtain its propagation distance over a period of time, and a mathematical model to describe the variation of the diffusion coefficient due to collagen deposition.

## Collagen Deposition in Diabetic Kidney Disease Boosts Intercellular Signaling: A Mathematical Model
### Code Authors
Haryana Y. Thomas and Ashlee N. Ford Versypt, 
Dept. of Chemical & Biological Engineering,
University at Buffalo, The State University of New York.

Corresponding author: A. N. Ford Versypt, ashleefv@buffalo.edu

### Preprint
https://www.biorxiv.org/content/10.1101/2021.03.25.437068v1

### Scripts
#### Main file
* CellularSignaling.m
This is the **main** file and it contains the function calls for each of the model components. Additionally it contains the parameters used for each part of the model.

#### Supporting function files
The rest of the files below are function files that are called in the main file and are not meant to be run independently.

* CellularSignalingAnalytical.m
This file contains the function for obtaining the concentration profile of the signaling molecules and is called in the main file.

* CellularSignalingDimensionless.m
This file contains the function for obtaining the dimensionless concentration profile. This file is only used for verification purposes and is not part of the model.

* CellularSignalingVarD.m
This file contains the function for obtaining the concentration profiles of the signaing molecules for different diffusion coefficients at any time point.

* HinderedDiffusion.m
This file contains the function for calculating the diffusion coefficient dependence on the volume fraction of the collagen in the mesangial matrix for given fiber radius and signaling molecule radius.

* MultipleDiffusionCoeff.m
This file contains a function that is called within the main file to obtain a continuous set of diffusion coefficient for a range of input values of volume fraction, signaling molecule radius and fiber radius.

* thresholdwavefront.m
This file contains the function that calculates the propagation distance of the threshold concentration.

### Recommended Supplementary Packages
export_fig for exporting MATLAB figures https://github.com/altmany/export_fig

distinguishable_colors for obtaining a larger color scheme than the default amount given by MATLAB for the concentration profiles https://www.mathworks.com/matlabcentral/fileexchange/29702-generate-maximally-perceptually-distinct-colors
