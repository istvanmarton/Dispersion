# Dispersion
This repository accompanies the publication

> I. Márton, L. Sarkadi, ["Study of the effect of higher-order dispersions on photoionisation induced by ultrafast laser pulses applying a classical theoretical method"](https://www.nature.com/articles/s41598-022-18034-w), Scientific Reports, **12**, 13841 (2022).

In this article we investigated the effect of higher-order dispersion on ultrafast photoionisation. In order to do that we first needed to generate waveforms of ultrafast pulses shaped with higher-order dispersions. This is what the *Waveform.m* Octave script does.

#Basic usage for Waveform.m
The properties of the incoming ultrafast laser pulse must be defined.
The laser intensity is determined by the 'Intensity' variable (line 9) in units of $\frac{W}{cm^2}$.
The intensity full width at half maximum (FWHM) is defined by the 'PulseWidth' variable (line 10) in units of femtoseconds.
The central wavelength is defined by the 'Wavelength' variable (line 11) in units of nanometers.
