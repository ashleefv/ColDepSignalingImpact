# ColDepSignalingImpact
Collagen Deposition Impact on Intercellular Signaling in Diabetic Kidney Disease

DOI to be updated.
[![DOI](https://zenodo.org/badge/346521454.svg)](https://zenodo.org/badge/latestdoi/346521454)

## Overview to be updated
This mathematical model describes the dynamic process of extracellular matrix remodeling in the vicinity of a primary tumor at the onset 
of metastasis. The biological network under investigation consists of cancer cells, two populations of collagen fibers,
and two enzymes that react to remodel the microenvironment, impacting cancer cell migration away from the primary tumor.

# Update this paper title
## Excess Collagen Deposition During Diabetic Kidney Disease Enhances Intercellular Signaling: A Mathematical Model
### Code Authors
Haryana Y. Thomas and Ashlee N. Ford Versypt, 
Dept. of Chemical & Biological Engineering,
University at Buffalo, The State University of New York.
Corresponding author: A. N. Ford Versypt, ashleefv@buffalo.edu

### Scripts to be Updated

* solve_pdepd_CancerECM.m
This file includes the model definition and the parameters. The model is solved using MATLAB's built in pdepe function.
It can be run as a stand alone script or to be called as a subroutine by localsensitivity_CancerECM.m

* localsensitivity_CancerECM.m
This file conducts a local sensitivity analysis of the model.

### Recommended Supplementary Package
export_fig for exporting MATLAB figures: https://github.com/altmany/export_fig
