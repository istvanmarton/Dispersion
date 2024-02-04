reset
CEP1 = 0
CEP2 = 90
GDD=0;
TOD = 0;
FOD =0;
Intensity = 6.5e14;
PulseWidth = 7;
element = "H";
set encoding iso_8859_1
Hartree_to_eV = 27.211386245988
Hartree_to_10GV = 5.14220674763e1
fs_to_Hartree = 41.34127637
xlabel_offset_x = 0
xlabel_offset_y = -5
ylabel_offset_x = -15
ylabel_offset_y = 0
y2label_offset_x = 13
y2label_offset_y = 0
xtics_offset_x = 0
xtics_offset_y = -1
ytics_offset_x = 0
ytics_offset_y = 0
y2tics_offset_x = 0
y2tics_offset_y = 0
key_offset_x = -3
key_offset_y = 0
log_value = 5e-31

energy_offset_x = 0
energy_offset_y = 1.0
Count_energy_offset = 2
CountCount_offset = -3
Count_y1_offset = 1
ytics_offset = 0
y1_tics_offset = 0
y2_tics_offset = 0

p_size = 2
line_width = 20
p0 = "Bold Bold, 42"
p1 = "Bold Bold, 60"
#p0 = "Bold, 42"
#p1 = "Times Bold, 54"
s_p0 = "Bold, 28"
s_p1 = "Times Bold, 36"
#set terminal eps
set term eps size 28, 10
set out 'CEP.eps'

set size ratio 1/1.4
#set border linewidth 10

set multiplot layout 1, 2 margins 0.1, 0.95, 0.15, 0.95 spacing 0.1,0.0

set tics font p0
set xtics offset xtics_offset_x, xtics_offset_y
set ytics offset ytics_offset_x, ytics_offset_y

fileName_Energy1 = sprintf("Energy_Unified_%s_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_%gCEP_1e-06epsilon.txt",element, Intensity, PulseWidth, GDD, TOD, FOD, CEP1)
fileName_Energy2 = sprintf("Energy_Unified_%s_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_%gCEP_1e-06epsilon.txt",element, Intensity, PulseWidth, GDD, TOD, FOD, CEP2)

set xlabel "Energy (eV)" font p1 offset xlabel_offset_x, xlabel_offset_y
set ylabel "Normalized Count" font p1 offset ylabel_offset_x, ylabel_offset_y
set pointsize 1
set format y '10^{%T}'
set key title "{/Symbol:Bold f}_{CEP}" font p0
set key font p0
set logscale y
#set origin -0.5,0
#set size 0.9,0.9
set label "(a)" at screen 0.12,0.8 tc rgb "black" font p0 front
plot [0:100][1e-3:1.1] fileName_Energy1 u (Hartree_to_eV * $1):($2) w l lw line_width lc rgb "red" lt 1 title "0", fileName_Energy2 u (Hartree_to_eV * $1):($2) with line lw line_width lc rgb "blue" lt 2 title "{/Symbol:Bold p/2}" #"90{\260}"

fileName_Momentum1 = sprintf("Momentum_Unified_%s_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_%gCEP_1e-06epsilon.txt",element, Intensity, PulseWidth, GDD, TOD, FOD, CEP1)
fileName_Momentum2 = sprintf("Momentum_Unified_%s_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_%gCEP_1e-06epsilon.txt",element, Intensity, PulseWidth, GDD, TOD, FOD, CEP2)

set xlabel "Momentum (atomic unit)" font p1 offset xlabel_offset_x, xlabel_offset_y
set ylabel "Normalized Count" font p1 offset ylabel_offset_x, ylabel_offset_y
set tics font p0
set xtics(-20, -10, 0, 10, 20)
unset logscale y
unset format y 
set xtics (-3,-2,-1,0,1,2,3)
set label "(b)" at screen 0.6,0.8 tc rgb "black" font p0 front
plot [-2.5:2.5][0:1.05] fileName_Momentum1 u 1:($2) w l lw line_width lc rgb "red" lt 1 title "0", fileName_Momentum2 u ($1):($2) with line lw line_width lc rgb "blue" lt 2 title "{/Symbol:Bold p/2}" # "90{\260}"

unset key
unset margins
set origin -0.08,0.17
set size 0.55,0.45
set tics font s_p0
set xtics offset 0,0.0
set xlabel "Time (fs)" font s_p1 offset xlabel_offset_x, xlabel_offset_y+5
set ylabel "Electric field (10^{10} V/m)" font s_p1 offset ylabel_offset_x+12.5, ylabel_offset_y
set xtics(-20, -10, 0, 10, 20)
set label "(c)" at screen 0.16,0.56 tc rgb "black" font p0 front
plot [-600/fs_to_Hartree:600/fs_to_Hartree][-8:8] "awaveForm_6.5e+14Wcm_7fs_0CEP_0GDD_0TOD_0FOD.txt" u ($1/fs_to_Hartree):(Hartree_to_10GV*$2) w l lw line_width lc rgb "red" lt 1 title "0", "awaveForm_6.5e+14Wcm_7fs_90CEP_0GDD_0TOD_0FOD.txt" u ($1/fs_to_Hartree):(Hartree_to_10GV*$2) with line lw line_width/2 lc rgb "blue" lt 1 title "{Bold:/Symbol p/2}"

unset multiplot
set out

reset
set terminal x11
