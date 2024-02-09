reset

TOD = 0
FOD = 0
element = 'Na'
Intensity = 4e12
PulseWidth = 4.5

fit_Amplitude = 4.5
maxy = 6.5
t_lower = -2.4
t_upper = 9.4

change = 5.14220674763e+2
change_t = 41.341
set samples 20000
set encoding utf8

wlabel_pos_x = 0.02
wlabel_pos_y = 0.94
szin = "white"
szin_line = "white"

colorbox_size_x = 1
colorbox_size_y = 0.05
colorbox_origin_x = 0
colorbox_origin_y = 1.04
cblabel_offset_x = 0
cblabel_offset_y = 6

y2label_pos_x = 1.18
y2label_pos_y = -0.02

xlabel_offset_x = 0
xlabel_offset_y = -5
ylabel_offset_x = -11
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
line_width = 7
p0 = "Bold Bold, 42"
p1 = "Bold Bold, 60"
set term eps size 28, 37

set out 'Asymmetry_TimeEnergy.eps'

set key spacing 1.4
set multiplot layout 4, 3 margins 0.025, 0.975, 0.09, 0.95 spacing -0.02, 0.03#set multiplot layout 2, 3 margins 0.05, 0.93, 0.05, 0.99 spacing 0.045, -0.02

set object 1 rectangle from graph 0,0 to graph 1,1 fillcolor rgb "black"
set ytics ("4" -4, "3" -3, "2" -2, "1" -1, "0" 0, "1" 1, "2" 2, "3" 3,"4" 4)
set y2tics ("-2" -fit_Amplitude * 2/maxy, "-4" -fit_Amplitude * 4/maxy, "-6" -fit_Amplitude * 6/maxy, "0" 0, "2" fit_Amplitude * 2/maxy, "4" fit_Amplitude * 4/maxy, "6" fit_Amplitude * 6/maxy)
set xrange [t_lower:t_upper]
set yrange [-fit_Amplitude:fit_Amplitude]

CEP = 0
GDD = 0
fileName_CEP_text = sprintf('./%dfs2/Time_energy_%s_%dCEP_%gWcm_%gfs_%gGDD.txt',abs(GDD), element, CEP, Intensity, PulseWidth, GDD);
waveForm_fileName = sprintf('./%dfs2/awaveForm_%gWcm_%gfs_%dCEP_%gGDD_%gTOD_%gFOD.txt',abs(GDD), Intensity, PulseWidth, CEP, GDD, TOD, FOD);
set size ratio 1/1
set border linewidth 10
set link y2
set link x2
unset label
unset key
set ytics nomirror
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set cbrange[0:1]
set ytics nomirror
set xlabel "" font p1 offset xlabel_offset_x, xlabel_offset_y
set ylabel "Energy (eV)" font p1 offset ylabel_offset_x, ylabel_offset_y
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
felirat = sprintf("(a) Na, %g CEP, %g fs^2 GDD", CEP, GDD);
set label felirat at graph wlabel_pos_x, wlabel_pos_y tc rgb szin font p0 front
fileName = 'Time_Energy_H_1e+15Wcm_7fs_-10GDD_0TOD_0FOD_1e-06epsilon.txt'
set colorbox horizontal user origin graph colorbox_origin_x,colorbox_origin_y size graph colorbox_size_x,colorbox_size_y
set cbtics font p0 offset cblabel_offset_x,cblabel_offset_y
ti = sprintf('%d CEP, %d GDD',CEP, GDD)
splot fileName_CEP_text u ($1):($2):(sqrt($3)) title "", waveForm_fileName u ($1/change_t):((fit_Amplitude+0)/maxy * change * $2):($0) with line lw line_width lc rgb szin_line # title "6 fs^2 GDD"

CEP = 0
GDD = -5
fileName_CEP_text = sprintf('./%dfs2/Time_energy_%s_%dCEP_%gWcm_%gfs_%gGDD.txt',abs(GDD), element, CEP, Intensity, PulseWidth, GDD);
waveForm_fileName = sprintf('./%dfs2/awaveForm_%gWcm_%gfs_%dCEP_%gGDD_%gTOD_%gFOD.txt',abs(GDD), Intensity, PulseWidth, CEP, GDD, TOD, FOD);
set size ratio 1/1
set border linewidth 10
set link y2
set link x2
unset label
unset key
set ytics nomirror
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set cbrange[0:1]
set ytics nomirror
set xlabel "" font p1 offset xlabel_offset_x, xlabel_offset_y
set ylabel "" font p1 offset ylabel_offset_x, ylabel_offset_y
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
felirat = sprintf("(b) Na, %g CEP, %g fs^2 GDD", CEP, GDD);
set label felirat at graph wlabel_pos_x, wlabel_pos_y tc rgb szin font p0 front
fileName = 'Time_Energy_H_1e+15Wcm_7fs_-10GDD_0TOD_0FOD_1e-06epsilon.txt'
set colorbox horizontal user origin graph colorbox_origin_x,colorbox_origin_y size graph colorbox_size_x,colorbox_size_y
set cbtics font p0 offset cblabel_offset_x,cblabel_offset_y
ti = sprintf('%d CEP, %d GDD',CEP, GDD)
splot fileName_CEP_text u ($1):($2):(sqrt($3)) title "", waveForm_fileName u ($1/change_t):((fit_Amplitude+0)/maxy * change * $2):($0) with line lw line_width lc rgb szin_line

CEP = 0
GDD = -10
fileName_CEP_text = sprintf('./%dfs2/Time_energy_%s_%dCEP_%gWcm_%gfs_%gGDD.txt',abs(GDD), element, CEP, Intensity, PulseWidth, GDD);
waveForm_fileName = sprintf('./%dfs2/awaveForm_%gWcm_%gfs_%dCEP_%gGDD_%gTOD_%gFOD.txt',abs(GDD), Intensity, PulseWidth, CEP, GDD, TOD, FOD);
set size ratio 1/1
set border linewidth 10
set link y2
set link x2
unset label
unset key
set ytics nomirror
set pm3d map
set pm3d interpolate 0,0
set label "Electric field (10^{9} V m^{-1})" font p1 tc "black" rotate by 90 left offset 0,0 at graph y2label_pos_x,y2label_pos_y
set cblabel ""
set cbrange[0:1]
set ytics nomirror
set xlabel "" font p1 offset xlabel_offset_x, xlabel_offset_y
set ylabel "" font p1 offset ylabel_offset_x, ylabel_offset_y
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
felirat = sprintf("(c) Na, %g CEP, %g fs^2 GDD", CEP, GDD);
set label felirat at graph wlabel_pos_x, wlabel_pos_y tc rgb szin font p0 front
fileName = 'Time_Energy_H_1e+15Wcm_7fs_-10GDD_0TOD_0FOD_1e-06epsilon.txt'
set colorbox horizontal user origin graph colorbox_origin_x,colorbox_origin_y size graph colorbox_size_x,colorbox_size_y
set cbtics font p0 offset cblabel_offset_x,cblabel_offset_y
ti = sprintf('%d CEP, %d GDD',CEP, GDD)
splot fileName_CEP_text u ($1):($2):(sqrt($3)) title "", waveForm_fileName u ($1/change_t):((fit_Amplitude+0)/maxy * change * $2):($0) with line lw line_width lc rgb szin_line

CEP = 90
GDD = 0
fileName_CEP_text = sprintf('./%dfs2/Time_energy_%s_%dCEP_%gWcm_%gfs_%gGDD.txt',abs(GDD), element, CEP, Intensity, PulseWidth, GDD);
waveForm_fileName = sprintf('./%dfs2/awaveForm_%gWcm_%gfs_%dCEP_%gGDD_%gTOD_%gFOD.txt',abs(GDD), Intensity, PulseWidth, CEP, GDD, TOD, FOD);
set size ratio 1/1
set border linewidth 10
set link y2
set link x2
unset label
unset key
set ytics nomirror
unset colorbox
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set cbrange[0:1]
set ytics nomirror
set xlabel "" font p1 offset xlabel_offset_x, xlabel_offset_y
set ylabel "Energy (eV)" font p1 offset ylabel_offset_x, ylabel_offset_y
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
felirat = sprintf("(d) Na, %g CEP, %g fs^2 GDD", CEP, GDD);
set label "(d) Na, {/Symbol p}/2 CEP, 0 fs^2 GDD" at graph wlabel_pos_x, wlabel_pos_y tc rgb szin font p0 front
fileName = 'Time_Energy_H_1e+15Wcm_7fs_-10GDD_0TOD_0FOD_1e-06epsilon.txt'
set cbtics font p0 offset cblabel_offset_x,cblabel_offset_y
ti = sprintf('%d CEP, %d GDD',CEP, GDD)
splot fileName_CEP_text u ($1):($2):(sqrt($3)) title "", waveForm_fileName u ($1/change_t):((fit_Amplitude+0)/maxy * change * $2):($0) with line lw line_width lc rgb szin_line

CEP = 0
GDD = 5
fileName_CEP_text = sprintf('./%dfs2/Time_energy_%s_%dCEP_%gWcm_%gfs_%gGDD.txt',abs(GDD), element, CEP, Intensity, PulseWidth, GDD);
waveForm_fileName = sprintf('./%dfs2/awaveForm_%gWcm_%gfs_%dCEP_%gGDD_%gTOD_%gFOD.txt',abs(GDD), Intensity, PulseWidth, CEP, GDD, TOD, FOD);
set size ratio 1/1
set border linewidth 10
set link y2
set link x2
unset label
unset key
set ytics nomirror
unset colorbox
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set cbrange[0:1]
set ytics nomirror
set xlabel "" font p1 offset xlabel_offset_x, xlabel_offset_y
set ylabel "" font p1 offset ylabel_offset_x, ylabel_offset_y
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
felirat = sprintf("(e) Na, %g CEP, %g fs^2 GDD", CEP, GDD);
set label felirat at graph wlabel_pos_x, wlabel_pos_y tc rgb szin font p0 front
fileName = 'Time_Energy_H_1e+15Wcm_7fs_-10GDD_0TOD_0FOD_1e-06epsilon.txt'
set cbtics font p0 offset cblabel_offset_x,cblabel_offset_y
ti = sprintf('%d CEP, %d GDD',CEP, GDD)
splot fileName_CEP_text u ($1):($2):(sqrt($3)) title "", waveForm_fileName u ($1/change_t):((fit_Amplitude+0)/maxy * change * $2):($0) with line lw line_width lc rgb szin_line

CEP = 0
GDD = 10
fileName_CEP_text = sprintf('./%dfs2/Time_energy_%s_%dCEP_%gWcm_%gfs_%gGDD.txt',abs(GDD), element, CEP, Intensity, PulseWidth, GDD);
waveForm_fileName = sprintf('./%dfs2/awaveForm_%gWcm_%gfs_%dCEP_%gGDD_%gTOD_%gFOD.txt',abs(GDD), Intensity, PulseWidth, CEP, GDD, TOD, FOD);
set size ratio 1/1
set border linewidth 10
set link y2
set link x2
unset label
unset key
set ytics nomirror
unset colorbox
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set cbrange[0:1]
set ytics nomirror
set xlabel "" font p1 offset xlabel_offset_x, xlabel_offset_y
set label "Electric field (10^{9} V m^{-1})" font p1 tc "black" rotate by 90 left offset 0,0 at graph y2label_pos_x,y2label_pos_y
set ylabel "" font p1 offset ylabel_offset_x, ylabel_offset_y
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
felirat = sprintf("(f) Na, %g CEP, %g fs^2 GDD", CEP, GDD);
set label felirat at graph wlabel_pos_x, wlabel_pos_y tc rgb szin font p0 front
fileName = 'Time_Energy_H_1e+15Wcm_7fs_-10GDD_0TOD_0FOD_1e-06epsilon.txt'
set cbtics font p0 offset cblabel_offset_x,cblabel_offset_y
ti = sprintf('%d CEP, %d GDD',CEP, GDD)
splot fileName_CEP_text u ($1):($2):(sqrt($3)) title "", waveForm_fileName u ($1/change_t):((fit_Amplitude+0)/maxy * change * $2):($0) with line lw line_width lc rgb szin_line


set yrange [0:fit_Amplitude]
TOD = 0
FOD = 0
maxy = 4.5
set ytics ("4" -4, "3" -3, "2" -2, "1" -1, "0" 0, "1" 1, "2" 2, "3" 3,"4" 4)
set y2tics ("0" 0,"1" fit_Amplitude * 1/maxy, "2" fit_Amplitude * 2/maxy, "3" fit_Amplitude * 3/maxy, "4" fit_Amplitude * 4/maxy, "5" fit_Amplitude * 5/maxy, "6" fit_Amplitude * 6/maxy)
change = 3.509445520589769e+4
GDD = -5
fileName_text = sprintf('./%dfs2/Time_Energy_%s_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_1e-06epsilon.txt',abs(GDD), element, Intensity, PulseWidth, GDD, TOD, FOD);
waveForm_fileName = sprintf('./%dfs2/awaveForm_%gWcm_%gfs_%dCEP_%gGDD_%gTOD_%gFOD.txt',abs(GDD), Intensity, PulseWidth, 0, GDD, TOD, FOD);
set size ratio 1/1
set border linewidth 10
set link y2
set link x2
unset label
unset key
set ytics nomirror
unset colorbox
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set cbrange[0:1]
set ytics nomirror
set xlabel "" font p1 offset xlabel_offset_x, xlabel_offset_y
set label ""#set label "Intensity (10^{12} V cm^{-2})" font p1 tc "black" rotate by 90 left offset 0,0 at graph y2label_pos_x,y2label_pos_y
set ylabel "Energy (eV)" font p1 offset ylabel_offset_x, ylabel_offset_y
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
felirat = sprintf("(g) Na, %g fs^2 GDD", GDD);
set label felirat at graph wlabel_pos_x, wlabel_pos_y tc rgb szin font p0 front
fileName = 'Time_Energy_H_1e+15Wcm_7fs_-10GDD_0TOD_0FOD_1e-06epsilon.txt'
set cbtics font p0 offset cblabel_offset_x,cblabel_offset_y
ti = sprintf('%d CEP, %d GDD',CEP, GDD)
splot fileName_text u ($1):($2):(sqrt($3)) title "", waveForm_fileName u ($1/change_t):((fit_Amplitude+0)/maxy * change * $3 * $3):($0) with line lw line_width lc rgb szin_line

GDD = 0
fileName_text = sprintf('./%dfs2/Time_Energy_%s_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_1e-06epsilon.txt',abs(GDD), element, Intensity, PulseWidth, GDD, TOD, FOD);
waveForm_fileName = sprintf('./%dfs2/awaveForm_%gWcm_%gfs_%dCEP_%gGDD_%gTOD_%gFOD.txt',abs(GDD), Intensity, PulseWidth, 0, GDD, TOD, FOD);
set size ratio 1/1
set border linewidth 10
set link y2
set link x2
unset label
unset key
set ytics nomirror
unset colorbox
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set cbrange[0:1]
set ytics nomirror
set xlabel "" font p1 offset xlabel_offset_x, xlabel_offset_y
set label ""#set label "Intensity (10^{12} V cm^{-2})" font p1 tc "black" rotate by 90 left offset 0,0 at graph y2label_pos_x,y2label_pos_y
set ylabel "" font p1 offset ylabel_offset_x, ylabel_offset_y
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
felirat = sprintf("(h) Na, %g fs^2 GDD", GDD);
set label felirat at graph wlabel_pos_x, wlabel_pos_y tc rgb szin font p0 front
fileName = 'Time_Energy_H_1e+15Wcm_7fs_-10GDD_0TOD_0FOD_1e-06epsilon.txt'
set cbtics font p0 offset cblabel_offset_x,cblabel_offset_y
ti = sprintf('%d CEP, %d GDD',CEP, GDD)
splot fileName_text u ($1):($2):(sqrt($3)) title "", waveForm_fileName u ($1/change_t):((fit_Amplitude+0)/maxy * change * $3 * $3):($0) with line lw line_width lc rgb szin_line

GDD = 5
fileName_text = sprintf('./%dfs2/Time_Energy_%s_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_1e-06epsilon.txt',abs(GDD), element, Intensity, PulseWidth, GDD, TOD, FOD);
waveForm_fileName = sprintf('./%dfs2/awaveForm_%gWcm_%gfs_%dCEP_%gGDD_%gTOD_%gFOD.txt',abs(GDD), Intensity, PulseWidth, 0, GDD, TOD, FOD);
set size ratio 1/1
set border linewidth 10
set link y2
set link x2
unset label
unset key
set ytics nomirror
unset colorbox
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set cbrange[0:1]
set ytics nomirror
set xlabel "" font p1 offset xlabel_offset_x, xlabel_offset_y
set label ""
set ylabel "" font p1 offset ylabel_offset_x, ylabel_offset_y
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
felirat = sprintf("(i) Na, %g fs^2 GDD", GDD);
set label felirat at graph wlabel_pos_x, wlabel_pos_y tc rgb szin font p0 front
fileName = 'Time_Energy_H_1e+15Wcm_7fs_-10GDD_0TOD_0FOD_1e-06epsilon.txt'
set cbtics font p0 offset cblabel_offset_x,cblabel_offset_y
set label "Intensity (10^{12} W cm^{-2})" font p1 tc "black" rotate by 90 left offset 0,0 at graph y2label_pos_x,y2label_pos_y
ti = sprintf('%d CEP, %d GDD',CEP, GDD)
splot fileName_text u ($1):($2):(sqrt($3)) title "", waveForm_fileName u ($1/change_t):((fit_Amplitude+0)/maxy * change * $3 * $3):($0) with line lw line_width lc rgb szin_line

GDD = -10
fileName_text = sprintf('./%dfs2/Time_Energy_%s_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_1e-06epsilon.txt',abs(GDD), element, Intensity, PulseWidth, GDD, TOD, FOD);
waveForm_fileName = sprintf('./%dfs2/awaveForm_%gWcm_%gfs_%dCEP_%gGDD_%gTOD_%gFOD.txt',abs(GDD), Intensity, PulseWidth, 0, GDD, TOD, FOD);
set size ratio 1/1
set border linewidth 10
set link y2
set link x2
unset label
unset key
set ytics nomirror
unset colorbox
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set cbrange[0:1]
set ytics nomirror
set xlabel "t (fs)" font p1 offset xlabel_offset_x, xlabel_offset_y
set label ""
set ylabel "Energy (eV)" font p1 offset ylabel_offset_x, ylabel_offset_y
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
felirat = sprintf("(j) Na, %g fs^2 GDD", GDD);
set label felirat at graph wlabel_pos_x, wlabel_pos_y tc rgb szin font p0 front
fileName = 'Time_Energy_H_1e+15Wcm_7fs_-10GDD_0TOD_0FOD_1e-06epsilon.txt'
set cbtics font p0 offset cblabel_offset_x,cblabel_offset_y
ti = sprintf('%d CEP, %d GDD',CEP, GDD)
splot fileName_text u ($1):($2):(sqrt($3)) title "", waveForm_fileName u ($1/change_t):((fit_Amplitude+0)/maxy * change * $3 * $3):($0) with line lw line_width lc rgb szin_line

GDD = 10
fileName_text = sprintf('./%dfs2/Time_Energy_%s_%gWcm_%gfs_%gGDD_%gTOD_%gFOD_1e-06epsilon.txt',abs(GDD), element, Intensity, PulseWidth, GDD, TOD, FOD);
waveForm_fileName = sprintf('./%dfs2/awaveForm_%gWcm_%gfs_%dCEP_%gGDD_%gTOD_%gFOD.txt',abs(GDD), Intensity, PulseWidth, 0, GDD, TOD, FOD);
set size ratio 1/1
set border linewidth 10
set link y2
set link x2
unset label
unset key
set ytics nomirror
unset colorbox
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set cbrange[0:1]
set ytics nomirror
set xlabel "t (fs)" font p1 offset xlabel_offset_x, xlabel_offset_y
set label ""
set ylabel "" font p1 offset ylabel_offset_x, ylabel_offset_y
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
felirat = sprintf("(k) Na, %g fs^2 GDD", GDD);
set label "Intensity (10^{12} W cm^{-2})" font p1 tc "black" rotate by 90 left offset 0,0 at graph y2label_pos_x,y2label_pos_y
set label felirat at graph wlabel_pos_x, wlabel_pos_y tc rgb szin font p0 front
fileName = 'Time_Energy_H_1e+15Wcm_7fs_-10GDD_0TOD_0FOD_1e-06epsilon.txt'
set cbtics font p0 offset cblabel_offset_x,cblabel_offset_y
ti = sprintf('%d CEP, %d GDD',CEP, GDD)
splot fileName_text u ($1):($2):(sqrt($3)) title "", waveForm_fileName u ($1/change_t):((fit_Amplitude+0)/maxy * change * $3 * $3):($0) with line lw line_width lc rgb szin_line

unset multiplot

set out
