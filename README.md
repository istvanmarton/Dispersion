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
 refers to the intensity in $\frac{W}{cm^2}$, the CEP, and the three kinds of higher-order dispersions. The '1e-06epsilon' refers to the parameter that determines the precisity of the integration of the applied Dormand-Prince method. The first eight lines of the file contain general information about the calculations. In the first line, we can see the atomic number, the number of electrons, and the charge of the electron. The second line shows the masses of the target (atom or ion) and electron respectively. The third line shows values relevant to the calculations and can be obtained from the masses and charges of the electron and target. The fourth line shows the binding energy in atomic units and electronvolts as well. The rest of the values in the fourth line describe the screened (Garvey) potential. Details of the Garvey potential can be found in R. H. Garvey, C. H. Jackman and A. E. S. Green, ["Independent-particle-model potentials for atoms and ions with 36<Z≤54 and a modified Thomas-Fermi atomic energy formula"](https://journals.aps.org/pra/abstract/10.1103/PhysRevA.12.1144), Physical Review A, **12**, 1144 (1975). The fifth and sixth lines show the number of excitation and ionisation events respectively. The seventh and eighth lines show the number of anomalous events. Further details are not given about the anomalous events. The rest of the file shows the relevant information about the ionised electrons in 13 columns. The quantities of the 13 columns are shown in line nine. These are the position (ex, ey, ez), the velocity (vx, vy, vz), the momentum (px, py, pz), the energy (Etotal), the kinetic and potential energies (Ekin, Epot) of the ionised electron(s) respectively. The (time_of_ionization) stands for the first moment when the energy of the electron was positive, namely when the electron ionised.
# Wigner.gnu
The Wigner.gnu is a Gnuplot script generating Wigner.eps which is Figure 1 in the article. It requires three waveform files with three corresponding Wigner functions. These files can be created with the Waveform.m script. The waveforms should be generated with $6.5 \times 10^{14} \frac{W}{cm^2}$ intensity 7 fs FWHM and 0 CEP. The three waveforms should be generated with $10 fs^2$ GDD, $90 fs^3$ TOD, and $500 fs^4$ FOD respectively.
# Energy_Momentum_CEP.m and Energy_Momentum_CEP.gnu
The Energy_Momentum_CEP.m and Energy_Momentum_CEP.gnu scripts are written to generate Figure 2 in the article. At first, we need to generate two waveforms with the Waveform.m file and calculate the electron statistics with the CTMC_RKPD_SCR_OMP_CPP_GDD.cpp code. To evaluate the output files, the Energy_Momentum_CEP.m should be used. The value vector variable in the first line refers to the CEP values of the waveforms in the calculations. The applied GDD, TOD, FOD, Intensity, and Pulsewidth (FWHM) values must be written From line 2 to line 6. The element variable refers to the atom, the calculations were performed. For processing the files a proper bin width of energy (bin_Energy) and momentum (bin_Momentum) should be set. The energy bin width is given by electronvolts, meanwhile the momentum is given by atomic units. The Energy_Momentum_CEP.gnu is for plotting the results, the energy and momentum distribution, and the two waveforms that were used in the calculations. In the .gnu file, the two CEP values (CEP1, CEP2), the applied higher-order dispersions (GDD, TOD, and FOD), the applied intensity (Intensity), FWHM (Pulsewidth), and the kind of atom (element) should be set.

# Time_Energy.m
The Time_Energy.m script is written to process the output files resulting from the CTMC calculations. To run the script, the values should be set that are typical to the CTMC calculations. These are:
1. The 'value' vector in line 1 describes the values of the higher-order dispersions. In case the calculations were performed with different TOD and FOD values, the 'GDD' variable should be modified to 'TOD' or 'FOD' in lines 23, 51, 59, and 71 respectively.
2. The applied intensity 'Intensity' in line 5 and FWHM 'Pulsewidth' in line 6.
3. The applied CEP values. 'CEP_begin' in line 7 and 'CEP_end' in line 9 stand for the minimal and maximal applied CEP values in degrees respectively. The 'CEP_step' variable stands for the step size between the maximal and minimal CEP values. For example: CEP_begin = 0, CEP_step = 120, and CEP_end = 240 it means the code vill deal with CEP values 0, 120, and 240 respectively.
4. The variable 'element' refers to the atom for which the CTMC calculations were performed.
5. The 'epsilon' variable refers to the error in the adaptive step size Runge-Kutta method.
Upon successful execution, the script has three different kinds of output files.
1. 'Unified_normed_...' files stand for the spectrum related to different higher-order dispersion values. The first column of the file is the energy in electronvolts. The second line is the normalized counts and the third line is the error of the counts.
2. 'Time_Energy_...' files stand for the photoelectron distributions as a function of ionisation time and energy. The first column of the file is the time of ionisation. The second column is the energy of the ionised electrons, and the third column stands for the normalized count rate.
3. 'totalsum_' file stands for the asymmetry parameter (see Eq. 17 in the article). The first column of the file stands for the different higher-order dispersion values. The second column is the count rate. The third column is the asymmetry parameter, and the fourth is the error belonging to the asymmetry parameter.
## Spectrum_Asymmetry_H_Kr.gnu
The Spectrum_Asymmetry_H_Kr.gnu is a Gnuplot script generating Figure 3 in the article. The script needs the output files 'Unified_normed_...' and 'totalsum_' generated by the 'Time_Energy.m' script. It is necessary to mention the script supposes that the relevant data can be found in four different directories, namely in 'GDD_H', 'TOD_H', 'FOD_H', and in 'GDD_Kr'. The output of the script is 'Spectrum_Asymmetry_H_Kr.eps'.
## Time_Energy_H_Kr.gnu
The Time_Energy_H_Kr.gnu is a Gnuplot script generating Figure 4 in the article. The script needs output files 'Time_Energy_...' generated by 'Time_Energy.m' script. It also requires corresponding Waveform files generated by Waveform.m and renamed by the CTMC code. The output of the script is 'Time_Energy_H_Kr.eps'.
# Figure 5
The 'Electron_Energy.gnu' Gnuplot script is written to output 'Electron_Energy.eps' which is Figure 5 in the article. On the left side of the figure, the energy of the ionised electron as a function of time is depicted with the applied electric field. Therefore it requires 2 files.
1. The waveform generated by 'Waveform.m', and
2. 'Electron_Energy.txt' is the output of the 'CTMC_RKPD_SCR_OMP_CPP_GDD' file, although the code requires some modification to produce the necessary file. The following lines in the 'collision_process' function should be uncommented:
   1. //FILE *fp;
   2. //fp=fopen("Electron_Energy.txt","w");
   3. //fprintf(fp,"%Lf\t%Lf\n",t, E_kin+E_pot);
   4. //fclose(fp);

The line in the function 'Statistics'

if(E_Te<0) { (local_IonisationStatist->excitation)++; (*k)++; }

should be modified to

if(E_Te<0) { (local_IonisationStatist->excitation)++; /*(*k)++; */ }

After compilation, only one core should be used with the following command:

          ./CTMC_RKPD_SCR_OMP_CPP_GDD 1

The first and second columns of the resulting 'Electron_Energy.txt' are the time and the energy of the ionised electron respectively.
On the right side of the figure, the (Garvey) potentials of the hydrogen and krypton are depicted. The potential of the hydrogen and krypton should be written to files 'H.txt' and 'Kr.txt', where the first column corresponds to the distance, and the second column corresponds to the potential energy.
# Figure 6
Figure 6 can be generated the way Figure 3 and Figure 4, but at higher intensity. The 'Spectrum_HigherIntensity.gnu' script is for plotting the spectrum, asymmetry parameters and number of ionisation events. The 'TimeEnergy_HigherIntenstity.gnu' is for plotting the distribution of the photoionised electrons as the function of energy and time of ionisation. The output files of the scripts are 'Spectrum_HigherIntensity.eps' and 'TimeEnergy_HigherIntenstity.eps' respectively.
# Figure 7,8
## Asymmetry.m
The 'Asymmetry.m' script was written to process the output files of the CTMC code to generate asymmetry maps (Figure 7), and electron distributions as a function of ionisation time and energy of electrons. The following details should be given for the script:
1. the higher-order dispersion values the calculations were performed (GDD, TOD, FOD)
2. the applied intensity (Intensity)
3. the FWHM in femtoseconds (PulseWidth)
4. the applied CEP values (CEP_begin, CEP_step, CEP_end). If CEP_begin = 0, CEP_step = 6, and CEP_end = 354, it means the code will evaluate files having CEP values of 0, 6, 12, ...365 degrees.
5. the kind of atom the calculations were performed (element)
6. the bin width of the energy in electronvolts (energy_step)
7. and the value corresponds to the step size of the ODE solver (epsilon).
The 'Asymmetry.m' script has several outputs. They are the following:
1. The plot of the distribution of electrons as a function of time of ionisation and final kinetic energy at a given GDD value. (i.e: 'Time_Energy_Na_4e12Wcm_4.5fs_0GDD_0TOD_0FOD_1e-6epsilon.png')
2. The plot of the distribution of electrons as a function of time of ionisation and final kinetic energy at a given GDD value. In this case, the positive or negative direction of the momentum of the electrons are depicted. (i.e: 'Time_Energy_directionality_Na_4e12Wcm_4.5fs_0GDD_0TOD_0FOD_1e-6epsilon.png')
3. 
