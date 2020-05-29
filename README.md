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