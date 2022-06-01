# Audio-Equalizer
User-friendly GUI audio equalizer with signal and filter analysis using MATLAB

 ## Table of Contents
* [Project Description](#project-description)
* [Sample Run](#sample-run)
* [Author](#author)

## Project Description
This is an audio equalizer created using MATLAB. The GUI was created using ML app designer.

- The equalizer gives the user control over 9 frequency ranges (0 Hz- 16 kHz)
- The audio can be processed using FIR (finite impulse response) or IIR (infinite impulse response)
- User can generate a total of 27 detailed analysis figures for the used filter ,every frequency band and the final composite signal.
  
**Analysis contains data like:**
  - For filters:
    + Magnitude & Phase in the freq. domain
    + Impulse response
    + Step response
  - For the output signal:
    + Representation in the time domain
    + Magnitude and phase in  the freq. domain

## Sample Run

**Main UI**

![main](https://user-images.githubusercontent.com/90573502/171467461-e3d3b828-c7c5-4c3d-97d2-6bb28beb4352.jpg)

- Upon pressing the 'ANALYZE' button, 27 figures will be generated containing data for every frequency band. The data is related to the used filter and the enhanced signal in the time and frequency domain. The last analysis is for the composite signal (which is the final sum of all the frequency bands after enhancement)

## Author
[Adham Mohamed](https://github.com/adhammohamed1)
