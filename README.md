# Dispersion
This repository accompanies the publication

> I. Márton, L. Sarkadi, ["Study of the effect of higher-order dispersions on photoionisation induced by ultrafast laser pulses applying a classical theoretical method"](https://www.nature.com/articles/s41598-022-18034-w), Scientific Reports, **12**, 13841 (2022).

In this article, we investigated the effect of higher-order dispersion on ultrafast photoionisation. To do that we first needed to generate waveforms of ultrafast pulses shaped with higher-order dispersions. This is what the *Waveform.m* Octave script calculates.

# Basic usage of Waveform.m
The properties of the incoming ultrafast laser pulse must be defined:<br>
1. The laser intensity is determined by the 'Intensity' variable (line 9) in units of $\frac{W}{cm^2}$.
2. The intensity full width at half maximum (FWHM) is defined by the 'PulseWidth' variable (line 10) in units of femtoseconds (fs).<br>
3. The central wavelength is defined by the 'Wavelength' variable (line 11) in units of nanometers.
4. The carrier-envelope phase (CEP) is defined by the vector 'CEP_value' (line 6) in units of degrees. Example: if the vector contains the values '0', '120', and '240', it means the script calculates these three CEP values.
5. The value(s) of the higher-order dispersion(s) are given by the vector 'value'. Similarly to the CEP values, the code calculates with all the dispersion values given by the vector 'value'. The type of higher-order dispersion is defined by the 'GDD = value(i_Dispersion);' command (line 19). There are three different types of higher-order dispersion this code can calculate, namely the second-order dispersion or group-delay dispersion (GDD), third-order dispersion (TOD), or fourth-order dispersion (FOD). If we replace the 'GDD' in the command line with 'TOD' or 'FOD', the script will calculate the TOD and FOD respectively with the values given by the 'value' vector. The code calculates first the Gaussian transform-limited pulse, with the given intensity, FWHM, central wavelength, and CEP values, then it calculates the pulses shaped with higher-order dispersion(s) according to the chapter 'The theory of dispersion' in the above-mentioned article. The code writes out only the temporal profile(s) of the ultrashort pulses that were shaped with higher-order dispersion.<br>
## Invoking the script
The script is written in Octave programming language and therefore requires an Octave interpreter. The code can be invoked with the source('Waveform.m') command.
## Output files generated by Waveform.m
The script generates four types of output files. The names of the files contain the properties of the ultrashort laser pulse.<br>
1. The names of the text files consisting of the temporal profile of the electric field have the following form: 'waveForm_1e+15Wcm_7fs_0CEP_0GDD_90TOD_0FOD.txt'. It means this file contains the temporal profile of the pulse that was shaped with $0 fs^2$ GDD, $0 fs^4$ FOD, and $90 fs^3$ FOD. The incoming, or transform-limited pulse has an intensity of $10^{15}\frac{W}{cm^2}$ intensity, 7 fs FWHM, and 0 degrees of CEP. These text files consist of three columns. The first column stands for the time, the second stands for the real part of the electric field, and the third column means the absolute value of the electric field. The measurement unit is given by (Hartree) atomic units. The number of waveForm text files is equal to the number of CEP values in the 'CEP_value' vector multiplied by the number of higher-order dispersion values in the 'value' vector.<br>

2. The names of .jpg files showing the temporal profile of the electric field has the following form: 'Graph_1e+15Wcm_7fs_0CEP0GDD_90TOD_0FOD.jpg'. Apart from the CEP, the file name contains the properties of the pulse it depicts, similar to the previous one. The depicted electric fields have 0-degree CEP values and therefore the number of files is equal to the number of dispersion values in the 'value' vector.<br>

3. The names of the text files consisting of the Wigner function of the ultrashort laser pulse have the following form:'Wigner_1e+15Wcm_7fs_0GDD_90TOD_0FOD.txt'. The file name contains the properties of the pulse, and the number of text files containing the Wigner distributions is equal to the number of dispersion values in the 'value' vector. These text files consist of three columns. The first column stands for the time, the second stands for the angular frequency, and the third column stands for the values of the Wigner function. The measurement unit is given by (Hartree) atomic units.<br>

4. The names of .jpg files showing the Wigner function of the ultrashort laser pulse have the following form: 'Wigner_1e+15Wcm_7fs_0GDD_0TOD_500FOD.jpg'. The file name contains the properties of the pulse it depicts, and the number of .jpg files containing the Wigner distributions is equal to the number of dispersion values in the 'value' vector.

# The CTMC_RKPD_SCR_OMP_CPP_GDD.cpp file
The CTMC_RKPD_SCR_OMP_CPP_GDD.cpp is a code to simulate the ionization processes of atoms induced with ultrashort laser pulses with the classical-trajectory Monte Carlo method. The code uses GNU Scientific Library, and OpenMP, and therefore is capable of exploiting the advantage of Shared Memory Parallelism. 
## Basic usage
The variable 'z_target' in the main function stands for the atomic number of the atom or ion. The variable 'N_electron' in the main function stands for the number of electrons in the atom or ion. The variable 'Num' in the main function stands for the number of trajectories the program is calculating for a given ultrafast pulse. The code requires waveForm file(s) that are the output of the Waveform.m script. The CTMC program reads in the waveform(s) of the ultrafast laser pulse given by the waveform files and executes the simulation. Every time the program is finished with a simulation, it renames the file 'waveForm_...' to 'awaveForm_...'. As the program reads in every file starting with 'waveForm_', one should not place files in the working folder with that name, unless it stands for an ultrashort pulse and has the format discussed previously. The 'dBinding_energy_of_elements' variable stands for the binding energies of atoms and ions required in CTMC calculations. As it contains the binding energies of 36 elements, it can simulate ionisation processes for atoms having atomic numbers not bigger than 36.
The code can be compiled with the

     g++ CTMC_RKPD_SCR_OMP_CPP_GDD.cpp -fopenmp -o CTMC_RKPD_SCR_OMP_CPP_GDD -lgsl -lgslcblas -lm

command and can be invoked with the

     ./CTMC_RKPD_SCR_OMP_CPP_GDD Number_of_threads

command where 'Number_of_threads' is the number of threads the program can use during the execution. The format of the code output is 'Statistics_Na_1e+15Wcm_7fs_0CEP_0GDD_0TOD_500FOD_1e-06epsilon.txt', where 'Na' refers to the element or ion (with the electrical charge of the ion), the '1e+15'
 refers to the intensity in $\frac{W}{cm^2}$, the CEP, and the three kinds of higher-order dispersions. The '1e-06epsilon' refers to the parameter that determines the precisity of the integration of the applied Dormand-Prince method. The first ten lines of the file contains general information about the calculations. In the first line we can see the atomic number, the number of electrons, and the charge of the electron. The second line shows the masses of the target (atom or ion) and electron respectively.
