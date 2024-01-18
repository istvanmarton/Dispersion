pkg load ltfat
GDD = 0;
TOD = 0;
FOD = 0;
value = -10:10:10;
CEP_value = 0:60:357;
i=sqrt(-1);
change_time = 41.34137333518211; 
Intensity = 1e15; #Intensity in W/cm2;
PulseWidth = 7; # intensity FWHM (full width at half maximum) in femtoseconds.
Wavelength = 800; # Wavelength in nm
omega = 137.04 * 2 * pi / (18.897 * Wavelength);
Amplitude = sqrt(2 * Intensity/299792458/8.8541878176e-12)/5.14220674763e9;
sigma = change_time * PulseWidth/sqrt(8 * log (2));
twosigmasquare = 2 * sigma^2;
time_factor = 8;

for i_Dispersion=1:length(value)
GDD = value(i_Dispersion);

t = []; f = []; carrier = []; E_field_tin = []; E_field_omegain = []; fi_omega = []; E_field_omegaout = []; E_field_tout = [];
PulseWidth_analytical_Dispersion = PulseWidth * sqrt(1+(4*log(2))^2*GDD^2/(PulseWidth^4));
PulseWidth_analytical_TOD = sqrt(PulseWidth^2/2/log(2) + 8 * (log(2))^2 * (TOD/PulseWidth)^2);
PulseWidth_analytical_FOD = 1 * PulseWidth * (1+(4*log(2))^2*(abs(FOD))^1/(PulseWidth^4))^1;
sigma_analytical_Dispersion = 41.341 * PulseWidth_analytical_Dispersion/sqrt(8 * log (2));
sigma_analytical_TOD = 41.341 * PulseWidth_analytical_TOD/sqrt(8 * log (2));
sigma_analytical_FOD = 41.341 * PulseWidth_analytical_FOD/sqrt(8 * log (2));

begin_Dispersion = -time_factor  * sigma_analytical_Dispersion;
fin_Dispersion = time_factor  * sigma_analytical_Dispersion;
if (TOD < 0)
	begin_TOD = -0.75* time_factor * sigma_analytical_TOD;
	fin_TOD = 1.5* time_factor  * sigma_analytical_Dispersion;
elseif (TOD > 0)
	begin_TOD = -1.5* time_factor * sigma_analytical_Dispersion;
	fin_TOD = 0.75* time_factor * sigma_analytical_TOD;
else
	begin_TOD = 0;
	fin_TOD =0;
end
begin_FOD = -time_factor  * sigma_analytical_FOD;
fin_FOD = time_factor  * sigma_analytical_FOD;
begin = min([begin_Dispersion, begin_TOD, begin_FOD]);
fin = max([fin_Dispersion, fin_TOD, fin_FOD]);

discretization = 1e5;
step = 1/omega/416.75;
t =  begin : step : fin;
f_max = 1/step;
f = 0:2*pi*f_max/(size(t)(2)-1):2*pi*f_max;

carrier = sqrt(exp(-(t.*t)/twosigmasquare));

for i_CEP = 1:length(CEP_value)
CEP = CEP_value(i_CEP);
E_field_tin = Amplitude * carrier .* exp(i*(omega ) .* t + i*CEP*pi/180);#The temporal profile of the incoming electric field.
E_field_omegain = fft(E_field_tin);# Fast Fourier Transformation.
frequencies = f - omega;
fi_omega = change_time^2 * GDD /2 * frequencies.^2 + change_time^3 * TOD /6 * frequencies.^3 + change_time^4 * FOD/24 * frequencies.^4;# This is the fi(omega) spectral function. omega is the central angular frequency.
E_field_omegaout = E_field_omegain .* exp(-i * fi_omega);#Form of electric field of the output pulse in frequency domain.
E_field_tout = ifft(E_field_omegaout); #Temporal profile of the output pulse. 

fileName_graph = sprintf('Graph_%gWcm_%dfs_%dCEP%dGDD_%dTOD_%dFOD.jpg',Intensity, PulseWidth, CEP, GDD, TOD, FOD);
if (CEP == 0)
fig = figure();
plot(t/change_time, real(E_field_tout)*5.14220674763e2)
hold on
plot(t(1:1:end)/change_time, E_field_tin(1:1:end)*5.14220674763e2)
h = legend ({"pulse having dispersion", "incoming (transform limited) pulse"}, 'orientation', 'horizontal', 'location', 'northoutside');
hold off
xlabel("time (femtosecond)")
ylabel("Electric field (GV/m)")
print(fig, fileName_graph)
end

output_signal = [];
output_signal(:,1) = t;
output_signal(:,2) = real(E_field_tout);
output_signal(:,3) = abs(E_field_tout);
fileName = sprintf('waveForm_%gWcm_%dfs_%dCEP_%dGDD_%dTOD_%dFOD.txt',Intensity, PulseWidth, CEP, GDD, TOD, FOD);
save("-ascii",fileName, "output_signal")
end


t = []; f = []; carrier = []; E_field_tin = []; E_field_omegain = []; fi_omega = []; E_field_omegaout = []; E_field_tout = [];
discretization = 2.5e3;
f_max =  1.5 * omega/pi;
step = 1/f_max;
time_fac = 5;
t = time_fac * begin : step : time_fac * fin;
f = 0:2*pi*f_max/(size(t)(2)-1):2*pi*f_max;
carrier = sqrt(exp(-(t.*t)/twosigmasquare));
E_field_tin = Amplitude * carrier .* exp(i*(omega ) .* t + i*0);
E_field_omegain = fft(E_field_tin);
frequencies = f - omega;
fi_omega = change_time^2 * GDD /2 * frequencies.^2 + change_time^3 * TOD /6 * frequencies.^3 + change_time^4 * FOD/24 * frequencies.^4;
E_field_omegaout = E_field_omegain .* exp(-i * fi_omega);
E_field_tout = ifft(E_field_omegaout);


fileName_wigner = sprintf('Wigner_%gWcm_%dfs_%dGDD_%dTOD_%dFOD.jpg',Intensity, PulseWidth, GDD, TOD, FOD);
fileName_wigner_text = sprintf('Wigner_%gWcm_%dfs_%dGDD_%dTOD_%dFOD.txt',Intensity, PulseWidth, GDD, TOD, FOD);
fig = figure();
W = wignervilledist(E_field_tout);
W_mod = abs(W)/max(max((abs(W))));
f_modify = change_time * f/2;
t_modify = t/change_time*2;
pcolor(t_modify, f_modify, W_mod);
colorbar();
shading interp;
f_central = change_time * omega;
f_width = 1/sigma;
f_lower = f_central - 75*f_width;
f_upper = f_central + 75*f_width;
t_lower = begin/change_time;
t_upper = fin/change_time;
ylim([f_lower f_upper])
xlim([t_lower t_upper])
xlabel("time (fs)")
ylabel("angular frequency (1/fs)")
f_lower_index = floor(f_lower/(f_modify(2)-f_modify(1)));
f_upper_index = ceil(1 + f_upper/(f_modify(2)-f_modify(1)));
t_lower_index = lookup(t_modify, t_lower);
t_upper_index = lookup(t_modify, t_upper);
W_write = [];
fid = fopen(fileName_wigner_text,"w");

for ind_t = t_lower_index:t_upper_index
for ind_f = f_lower_index:f_upper_index
fprintf(fid, "%e %e %e\n", t_modify(ind_t), f_modify(ind_f), W_mod(ind_f, ind_t));
end
fprintf(fid, "\n");
end
fclose(fid);
print(fig, fileName_wigner)
end
