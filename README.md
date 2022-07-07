<!-- # SM Major.Minor.Patch-alpha.Build

### What's new in version Major.Minor.Patch-alpha.Build

### New functions/features in version Major.Minor.Patch-alpha.Build

### Deprecated functions/features in version Major.Minor.Patch-alpha.Build

### Backwards compatibility in version Major.Minor.Patch-alpha.Build

### Bug fixes in version Major.Minor.Patch-alpha.Build

### Thanks -->

# Sinusoidal Modeling (SM) Release Notes

SM is a set of Matlab functions that implement several algorithms for sinusoidal analysis and resynthesis of isolated sounds with (or without) partial tracking. All the code is freely available as open-source `.m` files.

## Quick Setup

1. Download and unzip the files to a folder (e.g., `/userhome/myfolder`)
2. Start Matlab
3. Open the SM folder (e.g., `/userhome/myfolder`) in Matlab (Navigate to `/userhome/myfolder/sinusoidal-model-master/` under the **Current Folder** menu)
4. Run the script `run_sm.m` to generate the example (type `run_sm.m` in the _**Command Window**_ or click on _**Run**_ from the _**Editor**_).
5. Add your own sounds to the `./audio` subfolder, open and edit `run_sm.m` appropriately to analyze/resynthesize your own sounds

WARNING! Before running the code for the first time, you must add the folder `sinusoidal-model-master` and all its subfolders to the Matlab search path. The script `run_sm.m` automatically adds the folder (and all subfolders) of the currently running script (`run_sm.m`) to the path. So the folder structure and the location of the script `run_sm.m` in that folder structure are important. If you change the location of `run_sm.m` (or if anything goes wrong), add the SM folder (e.g., `/userhome/myfolder/sinusoidal-model-master/`) to your Matlab path by hand (right click on the folder `/userhome/myfolder/sinusoidal-model-master/` in the _**Current Folder**_ menu and choose _**Add to path > Selected Folders and Subfolders**_).

## Dependencies

The file `run_sm_dependency.txt` lists all file dependencies. All required `.m` files can be found in this SMT repository. However, the SMT also requires the Matlab signal processing toolbox.

## Acknowledgements

This project has received funding from the European Union’s Horizon 2020 research and innovation programme under the Marie Sklodowska-Curie grant agreement No 831852 (MORPH)

## SM 0.11.0-alpha.1

Sinusoidal Model (SM) version 0.11.0 alpha release build 1

## What's new in version 0.11.0-alpha.1

- Further improvements to harmonic selection
- Harmonic selection fully integrated into sinusoidal analysis
- Choice of harmonic selection of partials (_after_ partial tracking) or strict harmonic selection of spectral peaks (_without_ partial tracking)

## New functions/features in version 0.11.0-alpha.1

- Added low-level function `+tools/+harm/harm_part_sel.m`
- Added low-level function `+tools/+harm/harm_peak_sel.m`
- Updated high-level function `SM/harmonic_selection.m`
- Added logical flag `HARMSELFLAG` to function `SM/sinusoidal_analysis.m` to enable/disable harmonic selection
- Added logical flag `PTRACKFLAG` to function `SM/sinusoidal_analysis.m` to enable/disblable partial tracking
- Added text flag `PTRACKALGFLAG` to function `SM/sinusoidal_analysis.m` to select partial tracking algorithm

## Backwards compatibility in version 0.11.0-alpha.1

- New harmonic selection feature resulted in API changes to high-level functions inside the folder `SM/`
  - Additional input arguments in a different order in function `SM/sinusodal_analysis.m`
  - Different order of input arguments in function `SM/sinusoidal_analysis.m`
  - Additional arguments in function `SM/sinusoidal_resynthesis.m`
  - Different order of input arguments in function `+tools/+harm/harm_peak_sel.m`

## Bug fixes in version 0.11.0-alpha.1

- Fixed bug in function `+tools/+harm/harm_peak_sel.m`

## SM 0.10.0-alpha.1

Sinusoidal Model (SM) version 0.10.0 alpha release build 1

### What's new in version 0.10.0-alpha.1

- Improved harmonic selection

### New functions/features in version 0.10.0-alpha.1

- Replaced deprecated function `SM/track2harm.m` with `SM/harmonic_selection.m`

## SM 0.9.0-alpha.1

Sinusoidal Model (SM) version 0.9.0 alpha release build 1

### What's new in version 0.9.0-alpha.1

- Added selection of partial track segments using duration as criterion
  - `DURTHRES` is the threshold for the minimum duration of the segments of partial tracks
  - `GAPTHRES` is the threshold for the duration of the gaps between partial track segments to connect over

### New functions/features in version 0.9.0-alpha.1

- Low-level partial duration in folder `+tools/+track`
  - `+tools/+track/dur.m`
  - `+tools/+track/durgap.m`
  - `+tools/+track/durtrack.m`
  - `+tools/+track/trimtrack.m`
- High-level partial duration function `SM/partial_track_duration.m`

### Backwards compatibility in version 0.9.0-alpha.1

- New peak selection feature resulted in API changes to high-level functions inside the folder `SM/`
  - Additional input arguments in a different order in function `SM/sinusodal_analysis.m`
  - Different order of output arguments in function `SM/sinusoidal_analysis.m`
  - Additional arguments in function `SM/sinusoidal_resynthesis.m`
  - Different order of input arguments in function `SM/sinusoidal_peak_selection.m`

### Bug fixes in version 0.9.0-alpha.1

- Fixed bug in function `+tools/+psel/spec_trough.m` when the spectral peaks and troughs found are not consistent
  - Added local function to check condition `ntrough == npeak+1`
  - Added local function to fix frames where `ntrough != npeak+1`

## SM 0.8.0-alpha.1

Sinusoidal Model (SM) version 0.8.0 alpha release build 1

### What's new in version 0.8.0-alpha.1

- Analytic calculation of the discrete Fourier transform (DFT) of modulated windows
- Selection of spectral peaks as sinusoids using several criteria, namely spectral shape, spectral range, relative spectral energy and absolute spectral energy

### New functions/features in version 0.8.0-alpha.1

- Analytical DFT of windows in folder `+tools/+dft`
  - `tools.dft.mkwin.m`
  - `tools.dft.rect.m`
  - `tools.dft.hann.m`
  - `tools.dft.hamming.m`
  - `tools.dft.blackman.m`
  - `tools.dft.blackmanharris.m`
  - `tools.dft.dirichlet.m`
  - `tools.dft.doubledirich.m`
  - `tools.dft.tripledirich.m`
  - `tools.dft.quaddirich.m`
  - `tools.dft.posbin.m`
  - `tools.dft.negbin.m`
  - `tools.dft.init_ph.m`
  - `tools.dft.ph_advance.m`
  - `tools.dft.phasedft.m`
- Low-level peak selection routines in folder `+tools/+psel`
  - `+tools/+psel/peaksel.m`
  - `+tools/+psel/spec_trough.m`
  - `+tools/+psel/is2pttroughl.m`
  - `+tools/+psel/is2pttroughr.m`
  - `+tools/+psel/is3pttrough.m`
  - `+tools/+psel/istrough.m`
  - `+tools/+psel/rangediff.m`
  - `+tools/+psel/mkbinrange.m`
  - `+tools/+psel/peak_shape.m`
  - `+tools/+psel/spec_peak_shape.m`
- Reusable subroutines in folder `+tools/+algo`
  - `+tools/+algo/findIndFirstLastTrueVal.m`
- High-level peak selection function
  - `SM/sinusoidal_peak_selection.m`
- Math
  - `tools.math.dotprod.m`
  - `tools.math.vecnorm.m`
- Miscellaneous
  - `tools.misc.mkeven.m`
  - `tools.misc.mkodd.m`

### Deprecated functions/features in version 0.8.0-alpha.1

- Function `SM/reldb.m` was replaced by `+tools/+psel/peak_reldb.m` and function `SM/absdb.m` was removed

### Backwards compatibility in version 0.8.0-alpha.1

- New peak selection feature resulted in API changes to high-level functions inside the folder `SM/`
  - Additional arguments in function `SM/sinusodal_analysis.m`
  - Additional routine `SM/sinusoidal_peak_selection.m` inside `SM/sinusodal_analysis.m`

### Bug fixes in version 0.8.0-alpha.1

- Several small bug fixes and improvements across the codebase

## SM 0.7.0-alpha.2

Sinusoidal Model (SM) version 0.7.0 alpha release build 2

### Bug fixes in version 0.7.0-alpha.2

- \#0.7.0-bug.1 - Corrected bug in previous version where the `data/` folder was missing

### Thanks in version 0.7.0-alpha.2

- Thanks to Alberto Acquilino for testing version 0.7.0-alpha.1

## SM 0.7.0-alpha.1

Sinusoidal Model (SM) version 0.7.0 alpha release build 1

### What's new in version 0.7.0-alpha.1

- Updated functions in folder +tools/+spec/ to also handle odd FFT size

### New functions/features in version 0.7.0-alpha.1

- Updated all functions in folder +tools/+spec/ to be able to handle even or odd size of the DFT
- Added functions `tools.spec.nyq_ind.m` and `tools.spec.nyq_bin.m`
- Added functions `tools.spec.bishift.m` and `tools.spec.ibinshift.m`
- Added functions `tools.spec.mkbin.m` and `tools.spec.mkfreq.m`

### Deprecated functions/features in version 0.7.0-alpha.1

- Deprecated function `tools.spec.nyq.m`

### Bug fixes in version 0.7.0-alpha.1

- Several small bug fixes

## SM 0.6.0-alpha.1

Sinusoidal Model (SM) version 0.6.0 alpha release build 1

### What's new in version 0.6.0-alpha.1

- Refactored _peak-to-peak frequency matching_

- Refactored _partial tracking_ as an independent module

- Refactored _parameter estimation_ as an independent module

- Added ability to recognize _symmetrical spectral peaks_, which happen when the center of the main lobe is exactly between two frequency bins

- Refactored _spectrum scaling functions_

- Added _power scaling quadratic interpolation_ to the sinusoidal parameter estimation methods

- Moved all _FFT spectrum conversion functions_ to folder `./+tools/+fft2/`

- Refactored codebase into low-level core functionality and high-level calls to core functions

### New functions/features in version 0.6.0-alpha.1

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

### Deprecated functions/features in version 0.6.0-alpha.1

- Deprecated function `SM/maxnumpeak.m`

### Backwards compatibility in version 0.6.0-alpha.1

- Latest version is not backwards compatible due to API changes to core functionality in folder `./+STFT/`. Updated and reordered output arguments of functions `+STFT/stft.m` and `+STFT/istft.m`

### Bug fixes in version 0.6.0-alpha.1

- Fixed bug in function `maxnumpeak.m` and replaced it by core function `tools.sin.maxnumpeak.m` and high-level function `SM/max_num_peak.m`

## SM 0.5.0-alpha.4

Sinusoidal Model (SM) version 0.5.0 alpha release build 4

## What's new in version 0.5.0-alpha.4

- Rebuild of previous version after standardization of nomenclature of entire codebase

## SM 0.5.0-alpha.3

Sinusoidal Model (SM) version 0.5.0 alpha release build 3

### What's new in version 0.5.0-alpha.3

- Rebuild of previous version after small bug fix

### Bug fixes in version 0.5.0-alpha.3

- Fixed small bug in script `run_sm.m`

## SM 0.5.0-alpha.2

Sinusoidal Model (SM) version 0.5.0 alpha release build 2

### What's new in version 0.5.0-alpha.2

- Rebuild of previous version with small bug fix

### Bug fixes in version 0.5.0-alpha.2

- Fixed small bug in function `+tools/+dsp/causal_offset.m`

## SM 0.5.0-alpha.1

Sinusoidal Model (SM) version 0.5.0 alpha release build 1

### What's new in version 0.5.0-alpha.1

- Refactored folder tools and subfolders within as packages to make the functions comprising the kernel functionality run in dedicated protected namespaces
- Automated calculation of the frequency difference for partial matching

### New functions/features in version 0.5.0-alpha.1

- Renamed folder `tools/` as `+tools/` to make it a package
- Renamed all subfolders inside `+tools/` as packages
- Added function `+tools/+f0/reference_f0.m`

### Deprecated functions/features in version 0.5.0-alpha.1

- Renamed several functions to make it easier to understand what they do
- Refactored function `+tools/+dsp/framesize.m` according to the single responsibility principle

### Backwards compatibility in version 0.5.0-alpha.1

- Matlab packages require a different syntax to call the functions inside packages, making version 0.5.0-alpha.1 totally backwards incompatible with previous versions

## SM 0.4.0-alpha.1

Sinusoidal Model (SM) version 0.4.0 alpha release build 1

### What's new in version 0.4.0-alpha.1

- Updated spectral conversion functions
- Automated calculation of the signal-to-resynthesis error ratio (SRER)
- Revised spectral conversion functions
- Added power spectrum scaling functions

### New functions/features in version 0.4.0-alpha.1

- Renamed folder `/Resources` as `/tools`
- Added function `/tools/wav/srer.m` to calculate the SRER
- Added revised spectral conversion functions in `/tools/spec/`
- Updated input arguments of function `/SM/maxnumpeak.m`
- Added functions `/tools/dsp/lin2pow.m` and `/tools/dsp/pow2lin.m` for power spectrum scaling

### Deprecated functions/features in version 0.4.0-alpha.1

- Replaced several deprecated functions in /`tools/spec/{fft2mag, fft2ph, fft2pms, fft2pps, fft2lms, fs2hs, hs2fs}.m`

- Replaced deprecated functions in `/SM/{phase_unwrap, scale_magspec, unscale_magspec}.m`

### Backwards compatibility in version 0.4.0-alpha.1

- Input arguments of function /SM/maxnumpeak.m changed, so call inside `/SM/sinusoidal_analysis.m` was updated accordingly

### Bug fixes in version 0.4.0-alpha.1

- Fixed bug in scaling of the magnitude spectrum for flags `nne` and `lin` in function `/SM/sinusoidal_analysis.m`

## SM 0.3.1-alpha.4

Sinusoidal Model (SM) version 0.3.1 alpha release build 4

### What's new in version 0.3.1-alpha.4

- Rebuild of version 0.3.1-alpha.3 after namespace change. Now the function `/SM/sinusoidal_analysis.m` explicitly calls the short-time Fourier transform as `STFT.stft.m` instead of the implicit call with the 'import' directive.

### Bug fixes in version 0.3.1-alpha.4

- No bug fixes

## SM 0.3.1-alpha.3

Sinusoidal Model (SM) version 0.3.1 alpha release build 3

### What's new in version 0.3.1-alpha.3

- Rebuild of version 0.3.1-alpha.2 after small bug fix. See 'Bug fixes' for further details

### Bug fixes in version 0.3.1-alpha.3

- Fixed name of function `peak2peak_freq_matching.m` inside function definition after renaming file.

### Thanks in version 0.3.1-alpha.3

- Thanks to Philippe Depalle for testing version 0.3.1-alpha.2

## SM 0.3.1-alpha.2

Sinusoidal Model (SM) version 0.3.1 alpha release build 2

### What's new in version 0.3.1-alpha.2

- Rebuild of version 0.3.1-alpha.1 after function rename. See 'Backwards compatibility' for details.

### Backwards compatibility in version 0.3.1-alpha.2

- Renamed function `SM/peak2peak.m` as `SM/peak2peak_freq_matching.m` to avoid conflict with Matlab's own `peak2peak.m` introduced in R2012a

### Thanks in version 0.3.1-alpha.2

- Thanks to Philippe Depalle for testing SM 0.3.1-alpha.1

## SM 0.3.1-alpha.1

---

Sinusoidal Model (SM) version 0.3.1 alpha release build 1

### What's new in version 0.3.1-alpha.1

- Folder `+STFT` is a Matlab package that creates the namespace `STFT/stft.m`. Use the syntax `STFT.stft.m` to call SM's implementation of the short-time Fourier transform

### New functions/features in version 0.3.1-alpha.1

- Added function `/Resources/misc/isfrac.m`
- Updated function `/Resources/misc/isint.m`
- The functions `/Resources/misc/{iseven,isodd}.m` operate on multidimensional arrays now

### Deprecated functions/features in version 0.3.1-alpha.1

- No deprecated function or features

### Backwards compatibility in version 0.3.1-alpha.1

- Matlab R2018b introduced the syntax FUN(ARRAY,'all') to call several functions (e.g., SUM/PROD/MAX/MIN/MEDIAN/MEAN/STD/VAR/MODE/ALL/ANY), where the flag 'all' means apply FUN over all elements of ARRAY. Previous versions do not accept this syntax, resulting in bug fix \#0.3.1-bug.2

### Bug fixes in version 0.3.1-alpha.1

- \#0.3.1-bug.1 - Updated call to function `Resources/dsp/cfw.m` inside function `/OLA/sof.m` (line 108) to correct bug 'Undefined function or variable cfw'
- \#0.3.1-bug.2 - Updated calls to functions `SUM/PROD/MAX/MIN/MEDIAN/MEAN/STD/VAR/MODE/ALL/ANY` to guarantee backwards compatibility
- \#0.3.1-bug.3 - Created namespace `+STFT/stft.m` to avoid conflict with Matlab's own `stft.m` introduced in R2019a. Use the syntax `STFT.stft.m` to call SM's implementation of the short-time Fourier transform

### Thanks in version 0.3.1-alpha.1

- Thanks to Samuel Poirot for testing version 0.3.0-alpha.2 and for the bug report

## SM 0.3.0-alpha.2

Sinusoidal Model (SM)

### What's new in version 0.3.0-alpha.2

- Added folders with data and audio

## SM 0.3.0-alpha.1

Sinusoidal Model (SM)

### What's new in version 0.3.0-alpha.1

- Vectorized sinusoidal re-synthesis
- Restructured and modularized code
- Added standard partial tracking
- Added plotting functions

### New features in version 0.3.0-alpha.1

- Added prefix 'sm\_' to all functions to avoid conflict with native Matlab functions
- Fully vectorized analysis + re-synthesis
- Fully restructured
- Fully modularized
- Auxiliary plotting functions

### Deprecated functions/features in version 0.3.0-alpha.1

- `zpad.m` -> `flexpad.m`
- `swipep.m` -> `swipep_mod.m`
- Folder ./SM totally restructured

### Backwards compatibility in version 0.3.0-alpha.1

- Tested on Matlab R2018b
- WARNING! Matlab R2016a does not accept the syntax used in the call to max/min

### Bug fixes in version 0.3.0-alpha.1

- No bug fixes in 0.3.0-alpha.1

## SM 0.2.0

### What's new in version 0.2.0

- Function `sinusoidal_analysis.m` is now fully vectorized and blazing fast compared to the previous frame-by-frame version. Benchmarking results with over 100 sounds indicate that the vectorized sinusoidal analysis takes between 5% and 10% of the time the frame-by-frame sinusoidal analysis took.
- All code is structured and organized into folders
- All subroutines now have a dedicated function
- Added help and comments to most functions
- Renamed variables following a unified nomenclature
- Reordered the input arguments to all functions following a consistent structure where data arguments are followed by option flags

### Bug fixes in version 0.2.0

- Fixed bug in absolute threshold function `absdb.m`
- Fixed bug in relative threshold function `reldb.m`

## SM 0.1.0

Sinusoidal Model (SM)

### Initial release
