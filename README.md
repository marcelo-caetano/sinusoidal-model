# SM 0.3.0-alpha.1
Sinusoidal Model (SM)

Run the Matlab script 'sm_run_sm.m' for an example of how to use the code.

The file 'sm_run_sm_dependency.txt lists all file dependencies.

## What's new in version 0.3.0-alpha.1

- Vectorized sinusoidal re-synthesis
- Restructured and modularized code
- Added standard partial tracking
- Added plotting functions

## New features

- Added prefix 'sm_' to all functions to avoid conflict with native Matlab functions
- Fully vectorized analysis + re-synthesis
- Fully restructured
- Fully modularized
- Auxiliary plotting functions

## Deprecated functions/features

- zpad.m -> flexpad.m
- swipep.m -> swipep_mod.m
- Folder ./SM totally restructured

## Backwards compatibility

- Tested on Matlab R2018b
- WARNING! Matlab R2016a does not accept the syntax used in the call to max/min

## Bug fixes

- No bug fixes in 0.3.0-alpha.1

# SM 0.2.0
Sinusoidal Model (SM)

Run the Matlab script 'run_sinusoidal_model_production.m'

The file 'run_sinusoidal_model_production_dependencies.txt' lists all file dependencies.

## What's new in version 0.2.0

- Function 'sinusoidal_analysis.m' is now fully vectorized and blazing fast compared to the previous frame-by-frame version. Benchmarking results with over 100 sounds indicate that the vectorized sinusoidal analysis takes between 5% and 10% of the time the frame-by-frame sinusoidal analysis took.
- All code is structured and organized into folders
- All subroutines now have a dedicated function
- Added help and comments to most functions
- Renamed variables following a unified nomenclature
- Reordered the input arguments to all functions following a consistent structure where data arguments are followed by option flags

## Bug fixes

- Fixed bug in absolute threshold function 'absdb.m'
- Fixed bug in relative threshold function 'reldb.m'

# SM 0.1.0
Sinusoidal Model (SM)

## Initial release