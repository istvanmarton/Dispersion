# Dispersion
This repository accompanies the publication

> I. Márton, L. Sarkadi, ["Study of the effect of higher-order dispersions on photoionisation induced by ultrafast laser pulses applying a classical theoretical method"](https://www.nature.com/articles/s41598-022-18034-w), Scientific Reports, **12**, 13841 (2022).

In this article we investigated the effect of higher-order dispersion on ultrafast photoionisation. In order to do that we first needed to generate waveforms of ultrafast pulses shaped with higher-order dispersions. This is what the *Waveform.m* Octave script does according to the chapter 'The theory of dispersion' in the above mentioned article.

#Basic usage for Waveform.m
The properties of the incoming ultrafast laser pulse must be defined.<br>
The laser intensity is determined by the 'Intensity' variable (line 9) in units of $\frac{W}{cm^2}$.<br>
The intensity full width at half maximum (FWHM) is defined by the 'PulseWidth' variable (line 10) in units of femtoseconds (fs).<br>
The central wavelength is defined by the 'Wavelength' variable (line 11) in units of nanometers.<br>
The carrier-envelope phase (CEP) is defined by the vector 'CEP_value' (line 6) in units of degrees. Example: if the vector contains the values '0', '120', and '240', it means the script calculates these three CEP values.
The values of the higher-order dispersion is given by the vector 'value'. Similarly to the CEP values, the code calculates with all the dispersion values given by the vector 'value'. The type of higher-order dispersion is defined by the 'GDD = value(i_Dispersion);' command (line 19). There are three different types of higer-order dispersion this code can calculate, namely the second-order dispersion or group-delay dispersion (GDD), third-order dispersion (TOD), or fourth-order dispersion (FOD). If we replace the 'GDD' in the command line to TOD or FOD, the script will calculate the TOD and FOD respectively with the values given by the 'value' vector.<br>
The script generates three types of output files.<br>
