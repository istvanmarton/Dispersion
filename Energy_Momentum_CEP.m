value = 0:90:90;
GDD=0;
TOD = 0;
FOD =0;
Intensity = 6.5e14;
PulseWidth = 7;
element = "H";
bin_Energy = 2; # Energy bin in electronvolts
bin_Momentum = 0.02; # Momentum bin in (Hartree) atomic units
maxRange = 0;
maxE=0;
str=[""];
Hartree_to_eV = 27.211386245988;
bin_Energy = bin_Energy/Hartree_to_eV;
totalsum = [];
max_totalsum = 0;
max_Momentum = 0;
min_Momentum_range = 0;
max_Momentum_range = 0;
B={};

for ind=1:length(value)
	
    CEP = value(ind);

    A=[];
	fileName=[""];
	fileName = sprintf('Statistics_%s_%gWcm_%gfs_%gCEP_%gGDD_%gTOD_%gFOD_1e-06epsilon.txt',element, Intensity, PulseWidth, CEP, GDD, TOD, FOD);
	A = dlmread(deblank(fileName), '\t', 9, 0);

    totalsum(ind) = size(A)(1);
    B{ind} = A;
    
    if (totalsum(ind) > 0)

       min_range = min(A(:,9));
       max_range = max(A(:,9));
       maxE = max(A(:,10));
      if(min_range < min_Momentum_range) 
        min_Momentum_range = min_range;
      endif
      if(max_range > max_Momentum_range) 
        max_Momentum_range = max_range;
      endif
      if(maxE > maxRange) 
        maxRange = maxE;
      endif
   endif
endfor


unifiedRange_Energy = 0:bin_Energy:maxRange;
unifiedRange_Momentum = min_Momentum_range: bin_Momentum: max_Momentum_range;
resE=[]; resM=[];
for ind=1:length(value)
    A=[]; y1=[]; y2=[];
    A = B{ind};
    	if (size(A)(1) > 0)
    		y1 = hist(A(:,10),unifiedRange_Energy);
    		resE=[resE, y1'];
    		y2 = hist(A(:,9), unifiedRange_Momentum);
    		resM = [resM, y2'];
	endif
endfor
resE = resE/max(max(resE));
resM = resM/max(max(resM));


for ind=1:length(value)
	if (totalsum(ind) > 0)
		CEP = value(ind);	
    		fileName_Energy=[""];
    		fileName_Energy = sprintf('Energy_Unified_%s_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_%gCEP_1e-06epsilon.txt',element, Intensity, PulseWidth, GDD, TOD, FOD, CEP);
    		fileName_Momentum=[""];
    		fileName_Momentum = sprintf('Momentum_Unified_%s_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_%gCEP_1e-06epsilon.txt',element, Intensity, PulseWidth, GDD, TOD, FOD, CEP);
    		kiir = [];
    		kiir = [kiir; unifiedRange_Energy', resE(:,ind)];
    		save ("-ascii", fileName_Energy, "kiir");
    		kiir = [];
    		kiir = [kiir, unifiedRange_Momentum', resM(:,ind)];
    		save ("-ascii", fileName_Momentum, "kiir");
    		
    	endif
endfor
