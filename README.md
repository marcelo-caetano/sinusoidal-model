<!-- # SM Major.Minor.Patch-alpha.Build

### What's new in version Major.Minor.Patch-alpha.Build

### New functions/features

### Deprecated functions/features

### Backwards compatibility

### Bug fixes

### Thanks -->

# Sinusoidal Modeling (SM) Release Notes

## SM 0.7.0-alpha.1

---

Sinusoidal Model (SM) version 0.7.0 alpha release build 1

Run the script `run_sm.m` inside the folder `sinusoidal-model-master` for an example of how to use the code. NOTE: You must change directories and go into `sinusoidal-model-master` to run `run_sm.m` because `run_sm.m` uses a relative path to point to the audio file and also because the folder `sinusoidal-model-master` is not automatically added to the Matlab search path.

The file `run_sm_dependency.txt` lists all file dependencies.

### What's new in version 0.7.0-alpha.1

- Updated functions in folder +tools/+spec/ to also handle odd FFT size

### New functions/features

- Updated all functions in folder +tools/+spec/ to be able to handle even or odd size of the DFT
- Added functions `tools.spec.nyq_ind.m` and `tools.spec.nyq_bin.m`
- Added functions `tools.spec.bishift.m` and `tools.spec.ibinshift.m`
- Added functions `tools.spec.mkbin.m` and `tools.spec.mkfreq.m`

### Deprecated functions/features

- Deprecated function `tools.spec.nyq.m`

### Bug fixes

- Several small bug fixes

## SM 0.6.0-alpha.1

---

Sinusoidal Model (SM) version 0.6.0 alpha release build 1

Run the script `run_sm.m` inside the folder `sinusoidal-model-master` for an example of how to use the code. NOTE: You must change directories and go into `sinusoidal-model-master` to run `run_sm.m` because `run_sm.m` uses a relative path to point to the audio file and also because the folder `sinusoidal-model-master` is not automatically added to the Matlab search path.

The file `run_sm_dependency.txt` lists all file dependencies.

### What's new in version 0.6.0-alpha.1

- Refactored _peak-to-peak frequency matching_

- Refactored _partial tracking_ as an independent module

- Refactored _parameter estimation_ as an independent module

- Added ability to recognize _symmetrical spectral peaks_, which happen when the center of the main lobe is exactly between two frequency bins

- Refactored _spectrum scaling functions_

- Added _power scaling quadratic interpolation_ to the sinusoidal parameter estimation methods

- Moved all _FFT spectrum conversion functions_ to folder `./+tools/+fft2/`

- Refactored codebase into low-level core functionality and high-level calls to core functions

### New functions/features

- Function `SM/freq_matching.m` was completely refactored into several local functions called as subroutines

- Partial tracking step has a dedicated function `SM/partial_tracking.m`, which calls the functions `SM/peak2peak_freq_matching.m` and `SM/freq_matching.m`

- Introduced power scaling sinusoidal parameter estimation in functions `XQIFFT/xqifft.m` and `XQIFFT/interp_pow_scaling.m`

- Added functions `tools.sin.is2ptpeak.m`, `tools.sin.is3ptpeak.m`, `tools.sin.ispeak.m`

- Added function `tools.math.quadfit.m` with improved implementation of quadratic fit that also handles _symmetrical spectral peaks_

- Introduced subroutine `SM/parameter_estimation.m`

- Updated function `SM/peak_picking.m` inside _parameter estimation_ to handle _regular_ and _symmetrical_ spectral peaks

- Standardized all flags inside the code base

- Low-level core functions: `tools.fft2.fft2scaled_mag_spec.m`, `tools.fft2.fft2spec_param.m`, `tools.math.quadfit.m`, `tools.fft2.scaled_mag_spec2lin_mag_spec.m`, `tools.sin.maxnumpeak.m`

- High-level functions: `SM/mag_spec_scaling.m`, `SM/parameter_estimation.m`, `SM/interp_mag_spec.m`, `SM/revert_mag_spec_scaling.m`, `SM/trunc_spec_peak.m`

### Deprecated functions/features

- Deprecated function `SM/maxnumpeak.m`

### Backwards compatibility

- Latest version is not backwards compatible due to API changes to core functionality in folder `./+STFT/`. Updated and reordered output arguments of functions `+STFT/stft.m` and `+STFT/istft.m`

### Bug fixes

- Fixed bug in function `maxnumpeak.m` and replaced it by core function `tools.sin.maxnumpeak.m` and high-level function `SM/max_num_peak.m`

## SM 0.5.0-alpha.4

---

Sinusoidal Model (SM) version 0.5.0 alpha release build 4

Run the script `run_sm.m` inside the folder `sinusoidal-model-master` for an example of how to use the code. NOTE: You must change directories and go into `sinusoidal-model-master` to run `run_sm.m` because `run_sm.m` uses a relative path to point to the audio file and also because the folder `sinusoidal-model-master` is not automatically added to the Matlab search path.

The file `run_sm_dependency.txt` lists all file dependencies.

## What's new in version 0.5.0-alpha.4

- Rebuild of previous version after standardization of nomenclature of entire codebase

## SM 0.5.0-alpha.3

---

Sinusoidal Model (SM) version 0.5.0 alpha release build 3

Run the script `run_sm.m` inside the folder `sinusoidal-model-master` for an example of how to use the code. NOTE: You must change directories and go into `sinusoidal-model-master` to run `run_sm.m` because `run_sm.m` uses a relative path to point to the audio file and also because the folder `sinusoidal-model-master` is not automatically added to the Matlab search path.

The file `run_sm_dependency.txt` lists all file dependencies.

### What's new in version 0.5.0-alpha.3

- Rebuild of previous version after small bug fix

### Bug fixes

- Fixed small bug in script `run_sm.m`

## SM 0.5.0-alpha.2

---

Sinusoidal Model (SM) version 0.5.0 alpha release build 2

Run the script `run_sm.m` inside the folder `sinusoidal-model-master` for an example of how to use the code. NOTE: You must change directories and go into `sinusoidal-model-master` to run `run_sm.m` because `run_sm.m` uses a relative path to point to the audio file and also because the folder `sinusoidal-model-master` is not automatically added to the Matlab search path.

The file `run_sm_dependency.txt` lists all file dependencies.

### What's new in version 0.5.0-alpha.2

- Rebuild of previous version with small bug fix

### Bug fixes

- Fixed small bug in function `+tools/+dsp/causal_offset.m`

## SM 0.5.0-alpha.1

---

Sinusoidal Model (SM) version 0.5.0 alpha release build 1

Run the script `run_sm.m` inside the folder `sinusoidal-model-master` for an example of how to use the code. NOTE: You must change directories and go into `sinusoidal-model-master` to run `run_sm.m` because `run_sm.m` uses a relative path to point to the audio file and also because the folder `sinusoidal-model-master` is not automatically added to the Matlab search path.

The file `run_sm_dependency.txt` lists all file dependencies.

### What's new in version 0.5.0-alpha.1

- Refactored folder tools and subfolders within as packages to make the functions comprising the kernel functionality run in dedicated protected namespaces
- Automated calculation of the frequency difference for partial matching

### New functions/features

- Renamed folder `tools/` as `+tools/` to make it a package
- Renamed all subfolders inside `+tools/` as packages
- Added function `+tools/+f0/reference_f0.m`

### Deprecated functions/features

- Renamed several functions to make it easier to understand what they do
- Refactored function `+tools/+dsp/framesize.m` according to the single responsibility principle

### Backwards compatibility

- Matlab packages require a different syntax to call the functions inside packages, making version 0.5.0-alpha.1 totally backwards incompatible with previous versions

## SM 0.4.0-alpha.1

---

Sinusoidal Model (SM) version 0.4.0 alpha release build 1

Run the script `run_sm.m` inside the folder `sinusoidal-model-master` for an example of how to use the code. NOTE: You must change directories and go into `sinusoidal-model-master` to run `run_sm.m` because `run_sm.m` uses a relative path to point to the audio file and also because the folder `sinusoidal-model-master` is not automatically added to the Matlab search path.

The file `run_sm_dependency.txt` lists all file dependencies.

### What's new in version 0.4.0-alpha.1

- Updated spectral conversion functions
- Automated calculation of the signal-to-resynthesis error ratio (SRER)
- Revised spectral conversion functions
- Added power spectrum scaling functions

### New functions/features

- Renamed folder `/Resources` as `/tools`
- Added function `/tools/wav/srer.m` to calculate the SRER
- Added revised spectral conversion functions in `/tools/spec/`
- Updated input arguments of function `/SM/maxnumpeak.m`
- Added functions `/tools/dsp/lin2pow.m` and `/tools/dsp/pow2lin.m` for power spectrum scaling

### Deprecated functions/features

- Replaced several deprecated functions in /`tools/spec/{fft2mag, fft2ph, fft2pms, fft2pps, fft2lms, fs2hs, hs2fs}.m`

- Replaced deprecated functions in `/SM/{phase_unwrap, scale_magspec, unscale_magspec}.m`

### Backwards compatibility

- Input arguments of function /SM/maxnumpeak.m changed, so call inside `/SM/sinusoidal_analysis.m` was updated accordingly

### Bug fixes

- Fixed bug in scaling of the magnitude spectrum for flags `nne` and `lin` in function `/SM/sinusoidal_analysis.m`

## SM 0.3.1-alpha.4

---

Sinusoidal Model (SM) version 0.3.1 alpha release build 4

Run the script `run_sm.m` inside the folder `sinusoidal-model-master` for an example of how to use the code. NOTE: You must change directories and go into `sinusoidal-model-master` to run `run_sm.m` because `run_sm.m` uses a relative path to point to the audio file and also because the folder `sinusoidal-model-master` is not automatically added to the Matlab search path.

The file `run_sm_dependency.txt` lists all file dependencies.

### What's new in version 0.3.1-alpha.4

- Rebuild of version 0.3.1-alpha.3 after namespace change. Now the function `/SM/sinusoidal_analysis.m` explicitly calls the short-time Fourier transform as `STFT.stft.m` instead of the implicit call with the 'import' directive.

### New functions/features

- No new functions or features

### Deprecated functions/features

- No deprecated functions or features

### Backwards compatibility

- No backwards compatibility issues

### Bug fixes

- No bug fixes

## SM 0.3.1-alpha.3

---

Sinusoidal Model (SM) version 0.3.1 alpha release build 3

Run the script `run_sm.m` inside the folder `sinusoidal-model-master` for an example of how to use the code. NOTE: You must change directories and go into `sinusoidal-model-master` to run `run_sm.m` because `run_sm.m` uses a relative path to point to the audio file and also because the folder `sinusoidal-model-master` is not automatically added to the Matlab search path.

The file `run_sm_dependency.txt` lists all file dependencies.

### What's new in version 0.3.1-alpha.3

- Rebuild of version 0.3.1-alpha.2 after small bug fix. See 'Bug fixes' for further details

### New functions/features

- No new functions or features

### Deprecated functions/features

- No deprecated functions or features

### Backwards compatibility

- No backwards compatibility issues

### Bug fixes

- Fixed name of function `peak2peak_freq_matching.m` inside function definition after renaming file.

### Thanks

- Thanks to Philippe Depalle for testing version 0.3.1-alpha.2

## SM 0.3.1-alpha.2

---

Sinusoidal Model (SM) version 0.3.1 alpha release build 2

Run the script `run_sm.m` inside the folder `sinusoidal-model-master` for an example of how to use the code. NOTE: You must change directories and go into `sinusoidal-model-master` to run `run_sm.m` because `run_sm.m` uses a relative path to point to the audio file and also because the folder `sinusoidal-model-master` is not automatically added to the Matlab search path.

The file `run_sm_dependency.txt` lists all file dependencies.

### What's new in version 0.3.1-alpha.2

- Rebuild of version 0.3.1-alpha.1 after function rename. See 'Backwards compatibility' for details.

### New functions/features

- No new functions or features

### Deprecated functions/features

- No deprecated functions or features

### Backwards compatibility

- Renamed function `SM/peak2peak.m` as `SM/peak2peak_freq_matching.m` to avoid conflict with Matlab's own `peak2peak.m` introduced in R2012a

### Bug fixes

- No bug fixes

### Thanks

- Thanks to Philippe Depalle for testing SM 0.3.1-alpha.1

## SM 0.3.1-alpha.1

---

Sinusoidal Model (SM) version 0.3.1 alpha release build 1

Run the script `run_sm.m` inside the folder `sinusoidal-model-master` for an example of how to use the code. NOTE: You must change directories and go into `sinusoidal-model-master` to run `run_sm.m` because `run_sm.m` uses a relative path to point to the audio file and also because the folder `sinusoidal-model-master` is not automatically added to the Matlab search path.

The file `run_sm_dependency.txt` lists all file dependencies.

### What's new in version 0.3.1-alpha.1

- Folder `+STFT` is a Matlab package that creates the namespace `STFT/stft.m`. Use the syntax `STFT.stft.m` to call SM's implementation of the short-time Fourier transform

### New functions/features

- Added function `/Resources/misc/isfrac.m`
- Updated function `/Resources/misc/isint.m`
- The functions `/Resources/misc/{iseven,isodd}.m` operate on multidimensional arrays now

### Deprecated functions/features

- No deprecated function or features

### Backwards compatibility

- Matlab R2018b introduced the syntax FUN(ARRAY,'all') to call several functions (e.g., SUM/PROD/MAX/MIN/MEDIAN/MEAN/STD/VAR/MODE/ALL/ANY), where the flag 'all' means apply FUN over all elements of ARRAY. Previous versions do not accept this syntax, resulting in bug fix \#0.3.1-bug.2

### Bug fixes

- \#0.3.1-bug.1 - Updated call to function `Resources/dsp/cfw.m` inside function `/OLA/sof.m` (line 108) to correct bug 'Undefined function or variable cfw'
- \#0.3.1-bug.2 - Updated calls to functions `SUM/PROD/MAX/MIN/MEDIAN/MEAN/STD/VAR/MODE/ALL/ANY` to guarantee backwards compatibility
- \#0.3.1-bug.3 - Created namespace `+STFT/stft.m` to avoid conflict with Matlab's own `stft.m` introduced in R2019a. Use the syntax `STFT.stft.m` to call SM's implementation of the short-time Fourier transform

### Thanks

- Thanks to Samuel Poirot for testing version 0.3.0-alpha.2 and for the bug report

## SM 0.3.0-alpha.2

---

Sinusoidal Model (SM)

Run the Matlab script `sm_run_sm.m` for an example of how to use the code.

The file `sm_run_sm_dependency.txt` lists all file dependencies.

### What's new in version 0.3.0-alpha.2

- Added folders with data and audio

### New features

- Same as 0.3.0-alpha.1

### Deprecated functions/features

- Same as 0.3.0-alpha.1

### Backwards compatibility

- Same as 0.3.0-alpha.1

### Bug fixes

- Same as 0.3.0-alpha.1

## SM 0.3.0-alpha.1

---

Sinusoidal Model (SM)

Run the Matlab script `sm_run_sm.m` for an example of how to use the code.

The file `sm_run_sm_dependency.txt` lists all file dependencies.

### What's new in version 0.3.0-alpha.1

- Vectorized sinusoidal re-synthesis
- Restructured and modularized code
- Added standard partial tracking
- Added plotting functions

### New features

- Added prefix 'sm\_' to all functions to avoid conflict with native Matlab functions
- Fully vectorized analysis + re-synthesis
- Fully restructured
- Fully modularized
- Auxiliary plotting functions

### Deprecated functions/features

- `zpad.m` -> `flexpad.m`
- `swipep.m` -> `swipep_mod.m`
- Folder ./SM totally restructured

### Backwards compatibility

- Tested on Matlab R2018b
- WARNING! Matlab R2016a does not accept the syntax used in the call to max/min

### Bug fixes

- No bug fixes in 0.3.0-alpha.1

## SM 0.2.0

---

Sinusoidal Model (SM)

Run the Matlab script `run_sinusoidal_model_production.m`

The file `run_sinusoidal_model_production_dependencies.txt` lists all file dependencies.

### What's new in version 0.2.0

- Function `sinusoidal_analysis.m` is now fully vectorized and blazing fast compared to the previous frame-by-frame version. Benchmarking results with over 100 sounds indicate that the vectorized sinusoidal analysis takes between 5% and 10% of the time the frame-by-frame sinusoidal analysis took.
- All code is structured and organized into folders
- All subroutines now have a dedicated function
- Added help and comments to most functions
- Renamed variables following a unified nomenclature
- Reordered the input arguments to all functions following a consistent structure where data arguments are followed by option flags

### Bug fixes

- Fixed bug in absolute threshold function `absdb.m`
- Fixed bug in relative threshold function `reldb.m`

## SM 0.1.0

---

Sinusoidal Model (SM)

### Initial release
