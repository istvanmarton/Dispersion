reset
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
key_offset_x = -1
key_offset_y = -1
log_value = 5e-31
number = 1

label_pos_x = 0.06
label_pos_y = 0.90

set bars fullwidth
set border lw 5
p_size = 2
line_width1 = 8
line_width2 = 8
line_type1 = 1
line_type2 = 1
dash_type = 2
set style line 1 lc rgb "cyan" lw line_width2 lt line_type2 dt dash_type

p = "Bold Bold, 37.5"
p0 = "Bold Bold, 42"
p1 = "Bold Bold, 60"
set term eps size 28, 10
set out 'Spectrum_HigherIntensity.eps'

set size ratio 1/1.4

set multiplot layout 1, 2 margins 0.1, 0.9, 0.2, 0.98 spacing 0.1,0.0

set logscale y 10
set tics font p0
set key top right Right samplen 3 width 4 height 0.5
titleformat="%21.0f"
set ytics offset ytics_offset_x, ytics_offset_y
set xtics offset xtics_offset_x, xtics_offset_y
set xlabel "Energy (eV)" font p1 offset xlabel_offset_x, xlabel_offset_y
set ylabel "Normalized Counts" font p1 tc "black" offset ylabel_offset_x, ylabel_offset_y
set format y '10^{%T}'
set key font p0
set key title "H, GDD (fs^2)" font p0 offset key_offset_x, key_offset_y
set key font p
set label "(a)" at graph label_pos_x, label_pos_y tc rgb "black" font p0 front
plot [0:160][1e-4:1.1] 'Unified_normed_H_1e+15Wcm_7fs_0GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "red" lw line_width1 lt line_type1 title sprintf(titleformat, 0), 'Unified_normed_H_1e+15Wcm_7fs_-2GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "orange" lw line_width1 lt line_type1 title "-2", 'Unified_normed_H_1e+15Wcm_7fs_2GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "orange" lw line_width2 lt line_type2 dt dash_type title "2", 'Unified_normed_H_1e+15Wcm_7fs_-4GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "yellow" lw line_width1 lt line_type1 title "-4", 'Unified_normed_H_1e+15Wcm_7fs_4GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "yellow" lw line_width2 lt line_type2 dt dash_type  title "4", 'Unified_normed_H_1e+15Wcm_7fs_-6GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "green" lw line_width1 lt line_type1 title "-6", 'Unified_normed_H_1e+15Wcm_7fs_6GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "green" lw line_width2 lt line_type2 dt dash_type  title "6", 'Unified_normed_H_1e+15Wcm_7fs_-8GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "cyan" lw line_width1 lt line_type1 title "-8", 'Unified_normed_H_1e+15Wcm_7fs_8GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "cyan" lw line_width2 lt line_type2 dt dash_type title "8", 'Unified_normed_H_1e+15Wcm_7fs_-10GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "blue" lw line_width1 lt line_type1 title "-10", 'Unified_normed_H_1e+15Wcm_7fs_10GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "blue" lw line_width2 lt line_type2 dt dash_type title "10" 

unset label
unset key
set logscale y 10
set y2tics (-0.02, -0.01,0 ,0.01, 0.02)
set y2range [-0.025:0.025]
set ytics nomirror
set xlabel "Group Delay Dispersion (fs^2)" font p1 offset xlabel_offset_x, xlabel_offset_y
set tics font p0
set ylabel "Total Counts" font p1 tc "red" offset ylabel_offset_x, ylabel_offset_y
set format y '{%.0t}x10^{%T}'
set ytics ("6x10^{6}" 6e6,"7x10^{6}" 7e6,"8x10^{6}" 8e6,"9x10^{6}" 9e6,"1x10^{7}" 1e7,"1.1x10^{7}" 1.1e7)
set y2label "A(D)" font p1 tc "blue" offset y2label_offset_x, y2label_offset_y
set ytics offset ytics_offset_x, ytics_offset_y tc "red"
set xtics offset xtics_offset_x, xtics_offset_y
set y2tics tc "blue" offset y2tics_offset_x, y2tics_offset_y
set label "(b)" at graph label_pos_x, label_pos_y tc rgb "black" font p0 front
plot [-11:11][6e6:1.1e7] 'totalsum_H_1e+15Wcm_7fs.txt' u ($1):($2):(1 * sqrt($2)) with yerrorbars axis x1y1 pt 7 lc rgb "red" linewidth 10 ps p_size title "", 'totalsum_H_1e+15Wcm_7fs.txt' u ($1):($3):($4) with yerrorbars pt 7 lc rgb "blue" linewidth 10 ps p_size title "" axis x1y2

unset multiplot

set out
