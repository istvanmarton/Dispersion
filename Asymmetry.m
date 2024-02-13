pkg load statistics
GDD = 0;
TOD = 0;
FOD = 0;
Intensity = 4e12;
PulseWidth = 4.5;
CEP_begin = 0;
CEP_step = 6;
CEP_end = 354;
element = "Na";
energy_step = 0.025;
epsilon = 1e-6;
Hartree_to_eV = 27.21;
fs_to_Hartree = 41.341;

    A=[]; maxRange = 0;
    for CEP = CEP_begin:CEP_step:CEP_end
	fileName=[""];
	fileName = sprintf('Statistics_%s_%gWcm_%gfs_%gCEP_%gGDD_%gTOD_%gFOD_%gepsilon.txt',element, Intensity, PulseWidth, CEP, GDD, TOD, FOD, epsilon);
	A_CEP = [];
	A_CEP = dlmread(deblank(fileName), '\t', 9, 0);
	A = [A; A_CEP];
    end	


#This part determines the cutoff energy of the spectra.
    max_Energy = 0;
    totalsum = size(A)(1);
    if (totalsum > 0)
       max_Energy = max(A(:,10));
      if(max_Energy > maxRange) 
        maxRange = max_Energy;
      endif
   endif


#This part creates the histogram of the energy spectra.
unified = 0:(energy_step/Hartree_to_eV):maxRange;
resE=[];
    y1=[];
    	if (totalsum > 0)
    		y1 = hist(A(:,10),unified);
    		resE=[resE, y1'];
 	endif
resE = resE/max(max(resE));

if (totalsum > 0)

#This part calculates the distribution of electrons as a function of energy and time of ionisation. It also calculates the distribution of electrons having positive and negative momentum along the polarization axis of the incoming ultrashort laser pulse at a given GDD value.
	positiveB = [];
	negativeB = [];
	positiveB = A(A(:,9)>0,:);
	negativeB = A(A(:,9)<0,:);
	res = [];
	res = [A(:,13)/fs_to_Hartree, A(:,10)*Hartree_to_eV];
	res_positive = [];
	res_positive = [positiveB(:,13)/fs_to_Hartree, positiveB(:,10)*Hartree_to_eV];
	res_negative = [];
	res_negative = [negativeB(:,13)/fs_to_Hartree, negativeB(:,10)*Hartree_to_eV];
	bins{2} = energy_step/2 : energy_step : 1.05*max(res(:,2));
	[nn, bins{1}] = hist(res(:,1), length(bins{2}));
	counts = [];
	[counts] = hist3 (res, bins );
	counts_positive = [];
	[counts_positive] = hist3 (res_positive, bins );
	counts_negative = [];
	[counts_negative] = hist3 (res_negative, bins );
	factor_positive = max(max(counts_positive));
	factor_negative = max(max(counts_negative));
	factor = max(factor_negative, factor_positive);
	counts = counts/max(max(counts));
	counts_positive = counts_positive/factor;
	counts_negative = counts_negative/factor;

#This part plots the electron distribution at a given GDD value.
	fileName_timeEnergy_fig = sprintf('Time_Energy_%s_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_%gepsilon.png',element, Intensity, PulseWidth, GDD, TOD, FOD, epsilon);
	fig2d_time_E = figure();
	pcolor(bins{1} , bins{2}, counts');
	xlim([bins{1}(1) bins{1}(length(bins{1}))])
	ylim([bins{2}(1) bins{2}(length(bins{2}))])
	xlabel("Time (fs)");
	ylabel("Energy(eV)");
	colorbar();
	print(fig2d_time_E, fileName_timeEnergy_fig)

#This part plots the electron distribution at a given GDD value. The positive or negative direction of the momentum of the electrons is depicted.
	fileName_timeEnergy_fig_directionality = sprintf('Time_Energy_directionality_%s_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_%gepsilon.png',element, Intensity, PulseWidth, GDD, TOD, FOD, epsilon);
	fig2d_time_E_directionality = figure();
	pcolor(bins{1} , bins{2}, sqrt(counts_positive'));
	felirat = sprintf("%g CEP, %g GDD", CEP, GDD);
	title(felirat)
	xlabel("Time (fs)");
	ylabel("Energy(eV)");
	colorbar();
	hold on
	pcolor(bins{1} , -bins{2}, sqrt(counts_negative'));
	hold off
	xlim([bins{1}(1) bins{1}(length(bins{1}))])
	ylim([-bins{2}(length(bins{2})) bins{2}(length(bins{2}))])
	print(fig2d_time_E_directionality, fileName_timeEnergy_fig_directionality)

#This part writes out the electron distribution to a .txt file.
  	fileName_timeEnergy_text = [""];
  	fileName_timeEnergy_text = sprintf('Time_Energy_%s_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_%gepsilon.txt',element, Intensity, PulseWidth, GDD, TOD, FOD, epsilon);
  	fid = fopen(fileName_timeEnergy_text,"w");	
	for ind_t = 1:length(bins{1})
		for ind_E = 1:length(bins{2})
			fprintf(fid, "%e %e %e\n", bins{1}(ind_t), bins{2}(ind_E), counts(ind_t, ind_E));#/max(max(counts))
		end
		fprintf(fid, "\n");
	end
	fclose(fid);

#This part writes out the electron spectra to a .txt file. The positive or negative direction of the momentum of the electrons is indicated.
  	fileName_timeEnergy_text_directionality = [""];
  	fileName_timeEnergy_text_directionality = sprintf('Time_Energy_directionality_%s_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_%gepsilon.txt',element, Intensity, PulseWidth, GDD, TOD, FOD, epsilon);
  	fid = fopen(fileName_timeEnergy_text_directionality,"w");
	for ind_t = 1:length(bins{1}) #unified * Hartree_to_eV;
		for ind_E = length(bins{2}):-1:1 # CEP_begin:CEP_step:CEP_end
			fprintf(fid, "%e %e %e\n", bins{1}(ind_t), -bins{2}(ind_E), counts_negative(ind_t, ind_E));
		end
		for ind_E = 1:length(bins{2}) # CEP_begin:CEP_step:CEP_end
			fprintf(fid, "%e %e %e\n", bins{1}(ind_t), bins{2}(ind_E), counts_positive(ind_t, ind_E));
		end
		fprintf(fid, "\n");
	end
	fclose(fid);

#This part writes out the spectra of electrons at a given GDD value to a .txt file.
	fileName=[""];
    	fileName = sprintf('Unified_normed_%s_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_%gepsilon.txt',element, Intensity, PulseWidth, GDD, TOD, FOD, epsilon);
    	kiir = [];
    	kiir = [kiir; Hartree_to_eV * unified', resE];
    	save ("-ascii", fileName, "kiir");
    	kiir = [];

#This part plots the spectra of electrons at a given GDD value.
	figName = sprintf('Spectra_%s_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_%gepsilon.jpg',element, Intensity, PulseWidth, GDD, TOD, FOD, epsilon);
	fig_energy = figure();
	str_help = [""];
    	str_help = sprintf("%f",GDD);
    	str=[""];
	str = [str;str_help];
    	plot(Hartree_to_eV * unified ,resE,"-");
    	hold on
	xlabel("Energy (eV)");
	ylabel("Count");
	legend(str);
	print(fig_energy, figName)
	hold off

endif


positive = [];
negative = [];
for CEP = CEP_begin:CEP_step:CEP_end

#This part calculates the distribution of electrons as a function of energy and time of ionisation. The distributions of electrons having positive and negative momentum along the polarization axis of the incoming ultrashort laser pulse at a given GDD and CEP value are also calculated.
	fileName=[""];
	fileName = sprintf('Statistics_%s_%gWcm_%gfs_%gCEP_%gGDD_%gTOD_%gFOD_%gepsilon.txt',element, Intensity, PulseWidth, CEP, GDD, TOD, FOD, epsilon);
	A_CEP = [];
	A_CEP = dlmread(deblank(fileName), '\t', 9, 0);
	positiveB = [];
	negativeB = [];
	positiveB = A_CEP(A_CEP(:,9)>0,:);
	negativeB = A_CEP(A_CEP(:,9)<0,:);
	distr_pos = hist(positiveB(:,10),unified);
	distr_neg = hist(negativeB(:,10),unified);
	positive = [positive; distr_pos];
	negative = [negative; distr_neg];
	res = [];
	res = [A_CEP(:,13)/fs_to_Hartree, A_CEP(:,10)*Hartree_to_eV];
	res_positive = [];
	res_positive = [positiveB(:,13)/fs_to_Hartree, positiveB(:,10)*Hartree_to_eV];
	res_negative = [];
	res_negative = [negativeB(:,13)/fs_to_Hartree, negativeB(:,10)*Hartree_to_eV];
	counts = [];
	[counts] = hist3 (res, bins );
	counts_positive = [];
	[counts_positive] = hist3 (res_positive, bins );
	counts_negative = [];
	[counts_negative] = hist3 (res_negative, bins );
	factor_positive = max(max(counts_positive));
	factor_negative = max(max(counts_negative));
	factor = max(factor_negative, factor_positive);
	counts = counts/max(max(counts));
	counts_positive = counts_positive/factor;
	counts_negative = counts_negative/factor;

#This part plots the electron distribution at a given GDD and CEP value. The positive or negative direction of the momentum of the electrons and the temporal profile of the electric field are depicted.
	fileName_timeEnergy_CEP_fig_directionality = sprintf('Time_Energy_%s_%dCEP_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_%gepsilon.png',element, CEP, Intensity, PulseWidth, GDD, TOD, FOD, epsilon);
	waveForm_fileName = sprintf('awaveForm_%gWcm_%gfs_%dCEP_%gGDD_%gTOD_%gFOD.txt',Intensity, PulseWidth, CEP, GDD, TOD, FOD);
	waveform = load(waveForm_fileName);
	fig2d_time_E_directionality = figure();
	felirat = sprintf("%g CEP, %g GDD", CEP, GDD);
	pcolor(bins{1} , bins{2}, sqrt(counts_positive'));
	title(felirat)
	xlabel("Time (fs)");
	ylabel("Energy(eV)");
	colorbar();
	hold on
	pcolor(bins{1} , -bins{2}, sqrt(counts_negative'));
	hold on
	plot (waveform(:,1)/fs_to_Hartree, 0.8 * bins{2}(length(bins{2})) * waveform(:,2)/max(waveform(:,2)),"b" );
	hold off
	xlim([bins{1}(1) bins{1}(length(bins{1}))])
	ylim([-bins{2}(length(bins{2})) bins{2}(length(bins{2}))])
	print(fig2d_time_E_directionality, fileName_timeEnergy_CEP_fig_directionality)

#This part plots the electron distribution at a given GDD and CEP value. The temporal profile of the electric field is depicted.
	fileName_timeEnergy_CEP_fig = sprintf('Time_Energy_total_%s_%dCEP_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_%gepsilon.png',element, CEP, Intensity, PulseWidth, GDD, TOD, FOD, epsilon);
	fig2d_time_E = figure();
	pcolor(bins{1} , bins{2}, sqrt(counts'));
	title(felirat)
	colorbar();
	hold on
	plot (waveform(:,1)/fs_to_Hartree, 0.4 * bins{2}(length(bins{2})) * waveform(:,2)/max(waveform(:,2)) + 0.5 * bins{2}(length(bins{2})),"b" );
	hold off
	ylim([bins{2}(1) bins{2}(length(bins{2}))])
	xlim([bins{1}(1) bins{1}(length(bins{1}))])
	print(fig2d_time_E, fileName_timeEnergy_CEP_fig)

#This part writes out the electron distribution at a given GDD and CEP value. The positive or negative direction of the momentum of the electrons is written out.
	fileName_CEP_text = sprintf('Time_energy_%s_%dCEP_%gWcm_%gfs_%gGDD.txt',element, CEP, Intensity, PulseWidth, GDD);
	fid = fopen(fileName_CEP_text,"w");
	for ind_t = 1:length(bins{1}) #unified * Hartree_to_eV;
		for ind_E = length(bins{2}):-1:1 # CEP_begin:CEP_step:CEP_end
			fprintf(fid, "%e %e %e\n", bins{1}(ind_t), -bins{2}(ind_E), counts_negative(ind_t, ind_E));
		end
		for ind_E = 1:length(bins{2}) # CEP_begin:CEP_step:CEP_end
			fprintf(fid, "%e %e %e\n", bins{1}(ind_t), bins{2}(ind_E), counts_positive(ind_t, ind_E));
		end
		fprintf(fid, "\n");
	end
	fclose(fid);
end

Asymmetry = (positive - negative)./(positive + negative);

#This part plots the asymmetry map at a given GDD value.
fig = figure();
pcolor(Hartree_to_eV * unified, CEP_begin:CEP_step:CEP_end, Asymmetry);
xlim([0 4]) #
ylim([0 359])
xlabel("Energy (eV)");
ylabel("CEP");
colorbar();
shading interp;
figName = sprintf('Asymmetry_%s_%gWcm_%gfs_%gCEP_%gGDD_%gTOD_%gFOD_%gepsilon.jpg',element, Intensity, PulseWidth, CEP, GDD, TOD, FOD, epsilon);
print(fig, figName)

#This part writes out the asymmetry map at a given GDD value to a .txt file.
CEP = CEP_begin:CEP_step:CEP_end;
fileName_Asymmetry = sprintf('Asymmetry_%s_%gWcm_%gfs_%gGDD.txt',element, Intensity, PulseWidth, GDD);
fid = fopen(fileName_Asymmetry,"w");
for ind_E = 1:length(unified) #unified * Hartree_to_eV;
	for ind_CEP = 1:length(CEP) # CEP_begin:CEP_step:CEP_end
		fprintf(fid, "%e %e %e\n", unified(ind_E) * Hartree_to_eV, CEP(ind_CEP), Asymmetry(ind_CEP, ind_E));
		if (ind_CEP == length(CEP))
			fprintf(fid, "%e %e %e\n", unified(ind_E) * Hartree_to_eV, CEP(ind_CEP) + CEP_step, Asymmetry(1, ind_E));
		endif
	end
	fprintf(fid, "\n");
end
fclose(fid);
