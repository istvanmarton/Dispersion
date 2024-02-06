reset
ismax(x) = (x>max)?max=x:0

fit_Amplitude = 90.0
line_width_zero = 9
dt_type_zero = 2

change = 3.509445520589769e+2
change_t = 41.341
set samples 20000
set encoding utf8

wlabel_pos_x = 0.02
wlabel_pos_y = 0.94

colorbox_size_x = 1
colorbox_size_y = 0.05
colorbox_origin_x = 0
colorbox_origin_y = 1.04
cblabel_offset_x = 0
cblabel_offset_y = 6

y2label_pos_x = 1.15
y2label_pos_y = -0.02

xlabel_offset_x = 0
xlabel_offset_y = -5
ylabel_offset_x = -11
ylabel_offset_y = 0
xtics_offset_x = 0
xtics_offset_y = -1
ytics_offset_x = 0
ytics_offset_y = 0
log_value = 5e-31

line_width = 7
p0 = "Bold Bold, 42"
p1 = "Bold Bold, 60"

set term eps size 28, 37
set out 'Time_Energy_H_Kr.eps'

set size ratio 1/1
set border linewidth 10

set y2tics ("1" fit_Amplitude * 1/6.5, "2" fit_Amplitude * 2/6.5, "3" fit_Amplitude * 3/6.5, "4" fit_Amplitude * 4/6.5, "5" fit_Amplitude * 5/6.5, "6" fit_Amplitude * 6/6.5,"7" fit_Amplitude * 7/6.5)

set key spacing 1.4
set multiplot layout 4, 3 margins 0.025, 0.975, 0.1, 0.95 spacing -0.02, 0.03

set object 1 rectangle from graph 0,0 to graph 1,1 fillcolor rgb "black"
GDD = -6
tau0 = 7.0
array A[2] = [0,0]
array B[2] = [0,fit_Amplitude/sqrt(1 + (4 * log(2) * GDD/tau0**2)**2)]
array C[2] = [0,0]
set ytics (20, 40, 60, 80, 100)
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
set xlabel ""
set xrange[-2:7]
set yrange[0:100]
set ylabel "Energy (eV)" font p1 offset ylabel_offset_x, ylabel_offset_y
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
set label "(a)  H, -6 fs^2 GDD" at graph wlabel_pos_x, wlabel_pos_y tc rgb "white" font p0 front #screen label_pos_bj1,label_pos_fl1 tc rgb "white" font p0 front
fileName = './GDD_H/Time_Energy_H_6.5e+14Wcm_7fs_-6GDD_0TOD_0FOD_1e-06epsilon.txt'
set colorbox horizontal user origin graph colorbox_origin_x,colorbox_origin_y size graph colorbox_size_x,colorbox_size_y
set cbtics font p0 offset cblabel_offset_x,cblabel_offset_y
splot fileName u ($1):($2):($3) title "", [i=1:2] '+' using (A[i]):(B[i]):(C[i]) with lines lw line_width_zero lc rgb "white" dt dt_type_zero, "./GDD_H/awaveForm_6.5e+14Wcm_7fs_0CEP_-6GDD_0TOD_0FOD.txt" u ($1/change_t):(fit_Amplitude/6.5 * change * $3 * $3):($0) with line lw line_width lc rgb "white"# title "6 fs^2 GDD"

GDD = 0
tau0 = 7.0
array A[2] = [0,0]
array B[2] = [0,fit_Amplitude/sqrt(1 + (4 * log(2) * GDD/tau0**2)**2)]
array C[2] = [0,0]
unset label
unset key
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set ytics nomirror
set xrange[-2:7]
set yrange[0:100]
set ylabel ""
set xlabel ""
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
set label "(b)  H, 0 fs^2 GDD" at graph wlabel_pos_x, wlabel_pos_y tc rgb "white" font p0 front #screen label_pos_bj1,label_pos_fl1 tc rgb "white" font p0 front
fileName = './GDD_H/Time_Energy_H_6.5e+14Wcm_7fs_0GDD_0TOD_0FOD_1e-06epsilon.txt'
set colorbox horizontal user origin graph colorbox_origin_x,colorbox_origin_y size graph colorbox_size_x,colorbox_size_y
set cbtics font p0 offset cblabel_offset_x,cblabel_offset_y
splot fileName u ($1):($2):($3) title "", [i=1:2] '+' using (A[i]):(B[i]):(C[i]) with lines lw line_width_zero lc rgb "white" dt dt_type_zero, "./GDD_H/awaveForm_6.5e+14Wcm_7fs_0CEP_0GDD_0TOD_0FOD.txt" u ($1/change_t):(fit_Amplitude/6.5 * change * $3 * $3):($0) with line lw line_width lc rgb "white"# title "6 fs^2 GDD"

GDD = 6
tau0 = 7.0
array A[2] = [0,0]
array B[2] = [0,fit_Amplitude/sqrt(1 + (4 * log(2) * GDD/tau0**2)**2)]
array C[2] = [0,0]
unset label
unset key
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
#set cbrange[0:1]
#set y2tics 0.1,0.2
set ytics nomirror
#set xlabel "t (fs)" font p1 offset xlabel_offset_x, xlabel_offset_y
set xrange[-2:7]
set yrange[0:100]
#set ylabel "Energy (eV)" font p1 offset ylabel_offset_x, ylabel_offset_y
set ylabel ""
set xlabel ""
set label "Intensity (10^{14} W cm^{-2})" font p1 tc "black" rotate by 90 left offset 0,0 at graph y2label_pos_x,y2label_pos_y
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
set label "(c)  H, 6 fs^2 GDD" at graph wlabel_pos_x, wlabel_pos_y tc rgb "white" font p0 front #screen label_pos_bj1,label_pos_fl1 tc rgb "white" font p0 front
fileName = './GDD_H/Time_Energy_H_6.5e+14Wcm_7fs_6GDD_0TOD_0FOD_1e-06epsilon.txt'
set colorbox horizontal user origin graph colorbox_origin_x,colorbox_origin_y size graph colorbox_size_x,colorbox_size_y
set cbtics font p0 offset cblabel_offset_x,cblabel_offset_y
splot fileName u ($1):($2):($3) title "", [i=1:2] '+' using (A[i]):(B[i]):(C[i]) with lines lw line_width_zero lc rgb "white" dt dt_type_zero, "./GDD_H/awaveForm_6.5e+14Wcm_7fs_0CEP_6GDD_0TOD_0FOD.txt" u ($1/change_t):(fit_Amplitude/6.5 * change * $3 * $3):($0) with line lw line_width lc rgb "white"# title "6 fs^2 GDD"

array A[2] = [-59.165/change_t,-59.165/change_t]
array B[2] = [0,fit_Amplitude/6.5 * change * 0.1313**2]
array C[2] = [0,0]
unset label
unset key
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set ytics nomirror
set xlabel ""
set xrange[-2:7]
set yrange[0:100]
set ylabel "Energy (eV)" font p1 offset ylabel_offset_x, ylabel_offset_y
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
set label "(d)  H, -60 fs^3 TOD" at graph wlabel_pos_x, wlabel_pos_y tc rgb "white" font p0 front #screen label_pos_bj1,label_pos_fl1 tc rgb "white" font p0 front
fileName = './TOD_H/Time_Energy_H_6.5e+14Wcm_7fs_0GDD_-60TOD_0FOD_1e-06epsilon.txt'
unset colorbox
splot fileName u ($1):($2):($3) title "", [i=1:2] '+' using (A[i]):(B[i]):(C[i]) with lines lw line_width_zero lc rgb "white" dt dt_type_zero, "./TOD_H/awaveForm_6.5e+14Wcm_7fs_0CEP_0GDD_-60TOD_0FOD.txt" u ($1/change_t):(fit_Amplitude/6.5 * change * $3 * $3):($0) with line lw line_width lc rgb "white"# title "6 fs^2 GDD"

GDD = 0
tau0 = 7.0
array A[2] = [0,0]
array B[2] = [0,fit_Amplitude/sqrt(1 + (4 * log(2) * GDD/tau0**2)**2)]
array C[2] = [0,0]
unset label
unset key
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set ytics nomirror
set xlabel ""
set xrange[-2:7]
set yrange[0:100]
set ylabel ""
set xlabel ""
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
set label "(e)  H, 0 fs^3 TOD" at graph wlabel_pos_x, wlabel_pos_y tc rgb "white" font p0 front #screen label_pos_bj1,label_pos_fl1 tc rgb "white" font p0 front
fileName = './TOD_H/Time_Energy_H_6.5e+14Wcm_7fs_0GDD_0TOD_0FOD_1e-06epsilon.txt'
unset colorbox
splot fileName u ($1):($2):($3) title "", [i=1:2] '+' using (A[i]):(B[i]):(C[i]) with lines lw line_width_zero lc rgb "white" dt dt_type_zero, "./TOD_H/awaveForm_6.5e+14Wcm_7fs_0CEP_0GDD_0TOD_0FOD.txt" u ($1/change_t):(fit_Amplitude/6.5 * change * $3 * $3):($0) with line lw line_width lc rgb "white"# title "6 fs^2 GDD"

array A[2] = [59.165/change_t,59.165/change_t]
array B[2] = [0,fit_Amplitude/6.5 * change * 0.1313**2]
array C[2] = [0,0]
unset label
unset key
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set ytics nomirror
set xrange[-2:7]
set yrange[0:100]
set ylabel ""
set xlabel ""
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
set label "Intensity (10^{14} W cm^{-2})" font p1 tc "black" rotate by 90 left offset 0,0 at graph y2label_pos_x,y2label_pos_y
set label "(f)  H, 60 fs^3 TOD" at graph wlabel_pos_x, wlabel_pos_y tc rgb "white" font p0 front #screen label_pos_bj1,label_pos_fl1 tc rgb "white" font p0 front
fileName = './TOD_H/Time_Energy_H_6.5e+14Wcm_7fs_0GDD_60TOD_0FOD_1e-06epsilon.txt'
unset colorbox
splot fileName u ($1):($2):($3) title "", [i=1:2] '+' using (A[i]):(B[i]):(C[i]) with lines lw line_width_zero lc rgb "white" dt dt_type_zero, "./TOD_H/awaveForm_6.5e+14Wcm_7fs_0CEP_0GDD_60TOD_0FOD.txt" u ($1/change_t):(fit_Amplitude/6.5 * change * $3 * $3):($0) with line lw line_width lc rgb "white"# title "6 fs^2 GDD"

array A[2] = [0,0]
array B[2] = [0,fit_Amplitude/6.5 * change * 0.1312**2]
array C[2] = [0,0]
unset label
unset key
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set ytics nomirror
set xlabel ""
set xrange[-2:7]
set yrange[0:100]
set ylabel "Energy (eV)" font p1 offset ylabel_offset_x, ylabel_offset_y
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
set label "(g)  H, -300 fs^4 FOD" at graph wlabel_pos_x, wlabel_pos_y tc rgb "white" font p0 front #screen label_pos_bj1,label_pos_fl1 tc rgb "white" font p0 front
fileName = './FOD_H/Time_Energy_H_6.5e+14Wcm_7fs_0GDD_0TOD_-300FOD_1e-06epsilon.txt'
unset colorbox
splot fileName u ($1):($2):($3) title "", [i=1:2] '+' using (A[i]):(B[i]):(C[i]) with lines lw line_width_zero lc rgb "white" dt dt_type_zero, "./FOD_H/awaveForm_6.5e+14Wcm_7fs_0CEP_0GDD_0TOD_-300FOD.txt" u ($1/change_t):(fit_Amplitude/6.5 * change * $3 * $3):($0) with line lw line_width lc rgb "white"# title "6 fs^2 GDD"

GDD = 0
tau0 = 7.0
array A[2] = [0,0]
array B[2] = [0,fit_Amplitude/sqrt(1 + (4 * log(2) * GDD/tau0**2)**2)]
array C[2] = [0,0]
unset label
unset key
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set ytics nomirror
set xlabel ""
set xrange[-2:7]
set yrange[0:100]
set ylabel ""
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
set label "(h)  H, 0 fs^4 FOD" at graph wlabel_pos_x, wlabel_pos_y tc rgb "white" font p0 front #screen label_pos_bj1,label_pos_fl1 tc rgb "white" font p0 front
fileName = './FOD_H/Time_Energy_H_6.5e+14Wcm_7fs_0GDD_0TOD_0FOD_1e-06epsilon.txt'
unset colorbox
splot fileName u ($1):($2):($3) title "", [i=1:2] '+' using (A[i]):(B[i]):(C[i]) with lines lw line_width_zero lc rgb "white" dt dt_type_zero, "./FOD_H/awaveForm_6.5e+14Wcm_7fs_0CEP_0GDD_0TOD_0FOD.txt" u ($1/change_t):(fit_Amplitude/6.5 * change * $3 * $3):($0) with line lw line_width lc rgb "white"# title "6 fs^2 GDD"

array A[2] = [0,0]
array B[2] = [0,fit_Amplitude/6.5 * change * 0.1312**2]
array C[2] = [0,0]
unset label
unset key
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set ytics nomirror
set xlabel ""
set xrange[-2:7]
set yrange[0:100]
set ylabel ""
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
set label "Intensity (10^{14} W cm^{-2})" font p1 tc "black" rotate by 90 left offset 0,0 at graph y2label_pos_x,y2label_pos_y
set label "(i)  H, 300 fs^4 FOD" at graph wlabel_pos_x, wlabel_pos_y tc rgb "white" font p0 front #screen label_pos_bj1,label_pos_fl1 tc rgb "white" font p0 front
fileName = './FOD_H/Time_Energy_H_6.5e+14Wcm_7fs_0GDD_0TOD_300FOD_1e-06epsilon.txt'
unset colorbox
splot fileName u ($1):($2):($3) title "", [i=1:2] '+' using (A[i]):(B[i]):(C[i]) with lines lw line_width_zero lc rgb "white" dt dt_type_zero, "./FOD_H/awaveForm_6.5e+14Wcm_7fs_0CEP_0GDD_0TOD_300FOD.txt" u ($1/change_t):(fit_Amplitude/6.5 * change * $3 * $3):($0) with line lw line_width lc rgb "white"# title "6 fs^2 GDD"

GDD = -40
tau0 = 7.0
array A[2] = [0,0]
array B[2] = [0,fit_Amplitude/sqrt(1 + (4 * log(2) * GDD/tau0**2)**2)]
array C[2] = [0,0]
unset label
unset key
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set ytics nomirror
set xlabel "t (fs)" font p1 offset xlabel_offset_x, xlabel_offset_y
set xrange[-4:12]
set yrange[0:100]
set ylabel "Energy (eV)" font p1 offset ylabel_offset_x, ylabel_offset_y
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
set label "(j)  Kr, -40 fs^2 GDD" at graph wlabel_pos_x, wlabel_pos_y tc rgb "white" font p0 front #screen label_pos_bj1,label_pos_fl1 tc rgb "white" font p0 front
fileName = './GDD_Kr/Time_Energy_Kr_6.5e+14Wcm_7fs_-40GDD_0TOD_0FOD_1e-06epsilon.txt'
unset colorbox
splot fileName u ($1):($2):($3) title "", [i=1:2] '+' using (A[i]):(B[i]):(C[i]) with lines lw line_width_zero lc rgb "white" dt dt_type_zero, "./GDD_Kr/awaveForm_6.5e+14Wcm_7fs_0CEP_-40GDD_0TOD_0FOD.txt" u ($1/change_t):(fit_Amplitude/6.5 * change * $3 * $3):($0) with line lw line_width lc rgb "white"# title "6 fs^2 GDD"

GDD = 0
tau0 = 7.0
array A[2] = [0,0]
array B[2] = [0,fit_Amplitude/sqrt(1 + (4 * log(2) * GDD/tau0**2)**2)]
array C[2] = [0,0]
unset label
unset key
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set ytics nomirror
set xlabel "t (fs)" font p1 offset xlabel_offset_x, xlabel_offset_y
set xrange[-4:12]
set yrange[0:100]
set ylabel ""
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
set label "(k)  Kr, 0 fs^2 GDD" at graph wlabel_pos_x, wlabel_pos_y tc rgb "white" font p0 front #screen label_pos_bj1,label_pos_fl1 tc rgb "white" font p0 front
fileName = './GDD_Kr/Time_Energy_Kr_6.5e+14Wcm_7fs_0GDD_0TOD_0FOD_1e-06epsilon.txt'
unset colorbox
splot fileName u ($1):($2):($3) title "", [i=1:2] '+' using (A[i]):(B[i]):(C[i]) with lines lw line_width_zero lc rgb "white" dt dt_type_zero, "./GDD_Kr/awaveForm_6.5e+14Wcm_7fs_0CEP_0GDD_0TOD_0FOD.txt" u ($1/change_t):(fit_Amplitude/6.5 * change * $3 * $3):($0) with line lw line_width lc rgb "white"# title "6 fs^2 GDD"

GDD = 40
tau0 = 7.0
array A[2] = [0,0]
array B[2] = [0,fit_Amplitude/sqrt(1 + (4 * log(2) * GDD/tau0**2)**2)]
array C[2] = [0,0]
unset label
unset key
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set ytics nomirror
set xlabel "t (fs)" font p1 offset xlabel_offset_x, xlabel_offset_y
set xrange[-4:12]
set yrange[0:100]
set ylabel ""
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
set label "Intensity (10^{14} W cm^{-2})" font p1 tc "black" rotate by 90 left offset 0,0 at graph y2label_pos_x,y2label_pos_y
set label "(l)  Kr, 40 fs^2 GDD" at graph wlabel_pos_x, wlabel_pos_y tc rgb "white" font p0 front #screen label_pos_bj1,label_pos_fl1 tc rgb "white" font p0 front
fileName = './GDD_Kr/Time_Energy_Kr_6.5e+14Wcm_7fs_40GDD_0TOD_0FOD_1e-06epsilon.txt'
unset colorbox
splot fileName u ($1):($2):($3) title "", [i=1:2] '+' using (A[i]):(B[i]):(C[i]) with lines lw line_width_zero lc rgb "white" dt dt_type_zero, "./GDD_Kr/awaveForm_6.5e+14Wcm_7fs_0CEP_40GDD_0TOD_0FOD.txt" u ($1/change_t):(fit_Amplitude/6.5 * change * $3 * $3):($0) with line lw line_width lc rgb "white"# title "6 fs^2 GDD"

unset multiplot

set out
