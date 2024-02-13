value = -10:2:10;
GDD = 0;
TOD = 0;
FOD = 0;
Intensity = 6.5e14;
PulseWidth = 7;
CEP_begin = 0;
CEP_step = 3;
CEP_end = 357;
element = "H";
epsilon = "1e-06";
totalsum = [];
pkg load statistics
Hartree_to_eV = 27.21;
fs_to_Hartree = 41.341;
max_totalsum = 0;
maxRange_Energy = 0;
max_Energy = 0;
B = {};

for ind=1:length(value)
	
    GDD = value(ind);

    A=[];
    for CEP = CEP_begin:CEP_step:CEP_end
	fileName=[""];
	fileName = sprintf('Statistics_%s_%gWcm_%gfs_%gCEP_%gGDD_%gTOD_%gFOD_%sepsilon.txt',element, Intensity, PulseWidth, CEP, GDD, TOD, FOD, epsilon);
	A_CEP = [];
	A_CEP = dlmread(deblank(fileName), '\t', 9, 0);
	A = [A; A_CEP];
    end	

    totalsum(ind) = size(A)(1);
    B{ind} = A;
    
    if (totalsum(ind) > 0)
       max_Energy = max(A(:,10));
      if(max_Energy > maxRange_Energy) 
        maxRange_Energy = max_Energy;
      endif
   endif
endfor

unifiedRange = (1/(Hartree_to_eV)):(2/(Hartree_to_eV)):maxRange_Energy;
res_Energy = [];
for ind=1:length(value)
    A=[]; y1=[];
    A = B{ind};
    	if (totalsum(ind) > 0)
    		y1 = hist(A(:,10),unifiedRange);
    		res_Energy=[res_Energy, y1'];
 	endif
endfor

for ind=1:length(value)
	if (totalsum(ind) > 0)
		GDD = value(ind);
		fileName=[""];
    		fileName = sprintf('Unified_normed_%s_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_%sepsilon.txt',element, Intensity, PulseWidth, GDD, TOD, FOD, epsilon);
    		kiir = [];
    		kiir = [kiir; Hartree_to_eV * unifiedRange', res_Energy(:,ind)/max(max(res_Energy)), sqrt(res_Energy(:,ind))/max(max(res_Energy))];
    		save ("-ascii", fileName, "kiir");
    	endif
endfor

for ind=1:length(value)
	A = B{ind};
  if (totalsum(ind) > 0)
  	GDD = value(ind);
  	fileName_timeEnergy_text = [""];
  	fileName_timeEnergy_text = sprintf('Time_Energy_%s_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_%sepsilon.txt',element, Intensity, PulseWidth, GDD, TOD, FOD, epsilon);
  	fid = fopen(fileName_timeEnergy_text,"w");
	res = [];
	res = [A(:,13)/fs_to_Hartree, A(:,10)*Hartree_to_eV];
	bins{2} = 0:2:1.05*max(res(:,2));
	[nn, bins{1}] = hist(res(:,1), length(bins{2}));
	[counts] = hist3 (res, bins );
	norm = sum(sum(counts));
	
	for ind_t = 1:length(bins{1})
		for ind_E = 1:length(bins{2})
			fprintf(fid, "%e %e %e\n", bins{1}(ind_t), bins{2}(ind_E), counts(ind_t, ind_E)/max(max(counts)))
		end
		fprintf(fid, "\n");
	end
	fclose(fid);
  endif
endfor

totalsum = [value', totalsum', (totalsum-flip(totalsum))'./(totalsum+flip(totalsum))', (4 * sqrt(totalsum.^3 + flip(totalsum).^3 )./ (totalsum+flip(totalsum)).^2)'];
fileName_totalsum = sprintf('totalsum_%s_%gWcm_%gfs.txt',element, Intensity, PulseWidth);
save ("-ascii", fileName_totalsum, "totalsum");
