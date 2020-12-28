# SM 0.3.1-alpha.3
Sinusoidal Model (SM) version 0.3.1 alpha release build 3

Run the script 'run_sm.m' inside the folder 'sinusoidal-model-master' for an example of how to use the code. NOTE: You must change directories and go into 'sinusoidal-model-master' to run 'run_sm.m' because 'run_sm.m' uses a relative path to point to the audio file and also because the folder 'sinusoidal-model-master' is not automatically added to the Matlab search path.

The file 'run_sm_dependency.txt lists all file dependencies.

## What's new in version 0.3.1-alpha.3
- Rebuild of version 0.3.1-alpha.2 after small bug fix. See 'Bug fixes' for further details

## New functions/features
- No new functions or features

## Deprecated functions/features
- No deprecated functions or features

## Backwards compatibility
- No backwards compatibility issues

## Bug fixes
- Fixed name of function 'peak2peak_freq_matching.m' inside function definition after renaming file.

## Thanks
- Thanks to Philippe Depalle for testing version 0.3.1-alpha.2

# SM 0.3.1-alpha.2
Sinusoidal Model (SM) version 0.3.1 alpha release build 2

Run the script 'run_sm.m' inside the folder 'sinusoidal-model-master' for an example of how to use the code. NOTE: You must change directories and go into 'sinusoidal-model-master' to run 'run_sm.m' because 'run_sm.m' uses a relative path to point to the audio file and also because the folder 'sinusoidal-model-master' is not automatically added to the Matlab search path.

The file 'run_sm_dependency.txt lists all file dependencies.

## What's new in version 0.3.1-alpha.2
- Rebuild of version 0.3.1-alpha.1 after function rename. See 'Backwards compatibility' for details.

## New functions/features
- No new functions or features

## Deprecated functions/features
- No deprecated functions or features

## Backwards compatibility
- Renamed function 'SM/peak2peak.m' as 'SM/peak2peak_freq_matching.m' to avoid conflict with Matlab's own 'peak2peak.m' introduced in R2012a

## Bug fixes
- No bug fixes

## Thanks
- Thanks to Philippe Depalle for testing SM 0.3.1-alpha.1

# SM 0.3.1-alpha.1
Sinusoidal Model (SM) version 0.3.1 alpha release build 1

Run the script 'run_sm.m' inside the folder 'sinusoidal-model-master' for an example of how to use the code. NOTE: You must change directories and go into 'sinusoidal-model-master' to run 'run_sm.m' because 'run_sm.m' uses a relative path to point to the audio file and also because the folder 'sinusoidal-model-master' is not automatically added to the Matlab search path.

The file 'run_sm_dependency.txt lists all file dependencies.

## What's new in version 0.3.1-alpha.1

- Folder +STFT is a Matlab package that creates the namespace STFT/stft.m. Use the syntax STFT.stft.m to call SM's implementation of the short-time Fourier transform

## New functions/features

- Added function /Resources/misc/isfrac.m
- Updated function /Resources/misc/isint.m
- The functions '/Resources/misc/{iseven,isodd}.m' operate on multidimensional arrays now

## Deprecated functions/features

- No deprecated function or features

## Backwards compatibility

- Matlab R2018b introduced the syntax FUN(ARRAY,'all') to call several functions (e.g., SUM/PROD/MAX/MIN/MEDIAN/MEAN/STD/VAR/MODE/ALL/ANY), where the flag 'all' means apply FUN over all elements of ARRAY. Previous versions do not accept this syntax, resulting in bug fix \#0.3.1-bug.2

## Bug fixes

- \#0.3.1-bug.1 - Updated call to function Resources/dsp/cfw.m inside function /OLA/sof.m (line 108) to correct bug 'Undefined function or variable cfw'
- \#0.3.1-bug.2 - Updated calls to functions SUM/PROD/MAX/MIN/MEDIAN/MEAN/STD/VAR/MODE/ALL/ANY to guarantee backwards compatibility
- \#0.3.1-bug.3 - Created namespace (+STFT/stft.m) to avoid conflict with Matlab's own 'stft.m' introduced in R2019a. Use the syntax STFT.stft.m to call SM's implementation of the short-time Fourier transform

## Thanks
- Thanks to Samuel Poirot for testing version 0.3.0-alpha.2 and for the bug report

# SM 0.3.0-alpha.2
Sinusoidal Model (SM)

Run the Matlab script 'sm_run_sm.m' for an example of how to use the code.

The file 'sm_run_sm_dependency.txt lists all file dependencies.

## What's new in version 0.3.0-alpha.2

- Added folders with data and audio

## New features

- Same as 0.3.0-alpha.1

## Deprecated functions/features

- Same as 0.3.0-alpha.1

## Backwards compatibility

- Same as 0.3.0-alpha.1

## Bug fixes

- Same as 0.3.0-alpha.1

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