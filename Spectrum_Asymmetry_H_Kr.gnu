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
key_offset_x = 0
key_offset_y = 0
log_value = 5e-31
number = 1
Up = 38.843

label_pos_x = 0.08
label_pos_y = 0.88

set bars fullwidth
p_size = 2
line_width1 = 8
line_width2 = 8
line_width = 8
line_type1 = 1
line_type2 = 1
dash_type = 2
set style line 1 lc rgb "cyan" lw line_width2 lt line_type2 dt dash_type

p = "Bold Bold, 37.5"
p0 = "Bold Bold, 42"
p1 = "Bold Bold, 60"

set term eps size 28, 40
set out 'Spectrum_Asymmetry_H_Kr.eps'

set size ratio 1/1.4


set multiplot layout 4, 2 margins 0.1, 0.9, 0.05, 0.98 spacing 0.1,0.0 

set border linewidth 10
set logscale y 10
set tics font p0
set key top right Right samplen 3 width 4 height 0.0
titleformat="%21.0f"
set ytics offset ytics_offset_x, ytics_offset_y
set xtics offset xtics_offset_x, xtics_offset_y
set xlabel "Energy (eV)" font p1 offset xlabel_offset_x, xlabel_offset_y
set ylabel "Normalized Counts" font p1 tc "black" offset ylabel_offset_x, ylabel_offset_y
set format y '10^{%T}'
set key font p0
set arrow from 2*Up,0.1 to 2*Up,0.06 lw line_width1 size graph 0.025,15,45
set label "2U_p" font p0 at graph 0.61, 0.77
set key title "H, GDD (fs^2)" font p0 offset key_offset_x, key_offset_y
set key font p
set label "(a)" at graph label_pos_x, label_pos_y tc rgb "black" font p0 front
plot [0:120][1e-4:1.1] './GDD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "red" lw line_width1 lt line_type1 title sprintf(titleformat, 0), './GDD_H/Unified_normed_H_6.5e+14Wcm_7fs_-2GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "orange" lw line_width1 lt line_type1 title "-2", './GDD_H/Unified_normed_H_6.5e+14Wcm_7fs_2GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "orange" lw line_width2 lt line_type2 dt dash_type title "2", './GDD_H/Unified_normed_H_6.5e+14Wcm_7fs_-4GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "brown" lw line_width1 lt line_type1 title "-4", './GDD_H/Unified_normed_H_6.5e+14Wcm_7fs_4GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "brown" lw line_width2 lt line_type2 dt dash_type  title "4", './GDD_H/Unified_normed_H_6.5e+14Wcm_7fs_-6GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "green" lw line_width1 lt line_type1 title "-6", './GDD_H/Unified_normed_H_6.5e+14Wcm_7fs_6GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "green" lw line_width2 lt line_type2 dt dash_type  title "6", './GDD_H/Unified_normed_H_6.5e+14Wcm_7fs_-8GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "cyan" lw line_width1 lt line_type1 title "-8", './GDD_H/Unified_normed_H_6.5e+14Wcm_7fs_8GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "cyan" lw line_width2 lt line_type2 dt dash_type title "8", './GDD_H/Unified_normed_H_6.5e+14Wcm_7fs_-10GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "blue" lw line_width1 lt line_type1 title "-10", './GDD_H/Unified_normed_H_6.5e+14Wcm_7fs_10GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "blue" lw line_width2 lt line_type2 dt dash_type title "10" 

unset arrow
unset label
unset key
set logscale y 10
set y2tics ( -0.45,0 ,0.45)
set y2range [-0.45:0.45]
set ytics nomirror
set xlabel "Group Delay Dispersion (fs^2)" font p1 offset xlabel_offset_x, xlabel_offset_y
set tics font p0
set ylabel "Total Counts" font p1 tc "red" offset ylabel_offset_x, ylabel_offset_y
set format y '10^{%T}'
set y2label "A(D)" font p1 tc "blue" offset y2label_offset_x, y2label_offset_y
#set ytics ("" 0,"1" 1e4,"2" 2e4, "3" 3e4,"4" 4e4, "5" 5e4,"6" 6e4, "7" 7e4, "8" 8e4,"9" 9e4) offset "0.0" tc "red"
set ytics offset ytics_offset_x, ytics_offset_y tc "red"
set xtics offset xtics_offset_x, xtics_offset_y
set y2tics tc "blue" offset y2tics_offset_x, y2tics_offset_y
set label "(b)" at graph label_pos_x, label_pos_y tc rgb "black" font p0 front
plot [-11:11][100:1000000] './GDD_H/totalsum_H_6.5e+14Wcm_7fs.txt' u ($1):($2):(1 * sqrt($2)) with yerrorbars axis x1y1 pt 7 lc rgb "red" linewidth 10 ps p_size title "", './GDD_H/totalsum_H_6.5e+14Wcm_7fs.txt' u ($1):($3):($4) with yerrorbars pt 7 lc rgb "blue" linewidth 10 ps p_size title "" axis x1y2

unset label
unset y2tics
unset y2label
set key top right Right samplen 3
titleformat="%21.0f"
set logscale y 10
set tics font p0 tc "black"
set ytics offset ytics_offset_x, ytics_offset_y
set xtics offset xtics_offset_x, xtics_offset_y
set xlabel "Energy (eV)" font p1 offset xlabel_offset_x, xlabel_offset_y
set ylabel "Normalized Counts" font p1 tc "black" offset ylabel_offset_x, ylabel_offset_y
set format y '10^{%T}'
set arrow from 2*Up,0.1 to 2*Up,0.06 lw line_width1 size graph 0.025,15,45
set label "2U_p" font p0 at graph 0.61, 0.77
set key font p0
set key title "H, TOD (fs^3)" font p0
set key font p
set label "(c)" at graph label_pos_x, label_pos_y tc rgb "black" font p0 front
plot [0:120][1e-4:1.1] './TOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "red" lw line_width lt line_type1  title sprintf(titleformat, 0), './TOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_-15TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "orange" lw line_width lt line_type1 title "-15", './TOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_15TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "orange" lw line_width lt line_type2 dt dash_type title "15", './TOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_-30TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "brown" lw line_width lt line_type1 title "-30", './TOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_30TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "brown" lw line_width lt line_type2 dt dash_type title "30", './TOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_-45TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "green" lw line_width lt line_type1 title "-45", './TOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_45TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "green" lw line_width lt line_type2 dt dash_type title "45", './TOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_60TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "cyan" lw line_width lt line_type1 title "-60", './TOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_60TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "cyan" lw line_width lt line_type2 dt dash_type title "60", './TOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_-75TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "blue" lw line_width lt line_type1 title "-75", './TOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_75TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "blue" lw line_width lt line_type2 dt dash_type title "75", './TOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_-90TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "blue" lw line_width lt line_type1 title "-90", './TOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_90TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "blue" lw line_width lt line_type2 dt dash_type title "90" 

unset arrow
unset label
unset key
#set y2tics ()
set y2tics (-0.15, 0, 0.15)
set y2range [-0.15:0.15]
set ytics nomirror
set xlabel "Third Order Dispersion (fs^3)" font p1 offset xlabel_offset_x, xlabel_offset_y
set tics font p0
set ylabel "Total Counts" font p1 tc "red" offset ylabel_offset_x, ylabel_offset_y
set format y '10^{%T}'
set y2label "A(D)" font p1 tc "blue" offset y2label_offset_x, y2label_offset_y
set ytics offset ytics_offset_x, ytics_offset_y tc "red"
set xtics offset xtics_offset_x, xtics_offset_y
set y2tics tc "blue" offset y2tics_offset_x, y2tics_offset_y
set logscale y 10
set label "(d)" at graph label_pos_x, label_pos_y tc rgb "black" font p0 front
plot [-100:100][1000:1000000] './TOD_H/totalsum_H_6.5e+14Wcm_7fs.txt' u ($1):($2):(1 * sqrt($2)) with yerrorbars axis x1y1 pt 7 lc rgb "red" linewidth 10 ps p_size title "", './TOD_H/totalsum_H_6.5e+14Wcm_7fs.txt' u ($1):($3):($4) with yerrorbars pt 7 lc rgb "blue" linewidth 10 ps p_size title "" axis x1y2

unset label
unset y2tics
unset y2label
set key top right Right samplen 3
titleformat="%21.0f"
set logscale y 10
set tics font p0 tc "black"
set ytics offset ytics_offset_x, ytics_offset_y
set xtics offset xtics_offset_x, xtics_offset_y
set xlabel "Energy (eV)" font p1 offset xlabel_offset_x, xlabel_offset_y
set ylabel "Normailzed Counts" font p1 tc "black" offset ylabel_offset_x, ylabel_offset_y
set format y '10^{%T}'
set arrow from 2*Up,0.1 to 2*Up,0.06 lw line_width1 size graph 0.025,15,45
set label "2U_p" font p0 at graph 0.61, 0.77
set key font p0
set key title "H, FOD (fs^4)" font p0
set key font p
set label "(e)" at graph label_pos_x, label_pos_y tc rgb "black" font p0 front
plot [0:120][1e-4:1.1] './FOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "red" lw line_width lt line_type1 title sprintf(titleformat, 0), './FOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_0TOD_-100FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "orange" lw line_width lt line_type1 title "-100", './FOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_0TOD_100FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "orange" lw line_width lt line_type2 dt dash_type title "100", './FOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_0TOD_-200FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "brown" lw line_width lt line_type1 title "-200", './FOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_0TOD_200FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "brown" lw line_width lt line_type2 dt dash_type title "200", './FOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_0TOD_-300FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "green" lw line_width lt line_type1 title "-300", './FOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_0TOD_300FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "green" lw line_width lt line_type2 dt dash_type title "300", './FOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_0TOD_-400FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "cyan" lw line_width lt line_type1 title "-400", './FOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_0TOD_400FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "cyan" lw line_width lt line_type2 dt dash_type title "400", './FOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_0TOD_-500FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "blue" lw line_width lt line_type1 title "-500", './FOD_H/Unified_normed_H_6.5e+14Wcm_7fs_0GDD_0TOD_500FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "blue" lw line_width lt line_type2 dt dash_type title "500" 

unset arrow
unset label
unset key
set y2tics (-0.4, 0, 0.4)
set y2range [-0.4:0.4]
set ytics nomirror
set xlabel "Fourth Order Dispersion (fs^4)" font p1 offset xlabel_offset_x, xlabel_offset_y
set tics font p0
set ylabel "Total Counts" font p1 tc "red" offset ylabel_offset_x, ylabel_offset_y
set format y '10^{%T}'
set y2label "A(D)" font p1 tc "blue" offset y2label_offset_x, y2label_offset_y
set ytics offset ytics_offset_x, ytics_offset_y tc "red"
set xtics offset xtics_offset_x, xtics_offset_y
set y2tics tc "blue" offset y2tics_offset_x, y2tics_offset_y
set logscale y 10
set label "(f)" at graph label_pos_x, label_pos_y tc rgb "black" font p0 front
plot [-550:550][100:1000000] './FOD_H/totalsum_H_6.5e+14Wcm_7fs.txt' u ($1):($2):(1 * sqrt($2)) with yerrorbars axis x1y1 pt 7 lc rgb "red" linewidth 10 ps p_size title "", './FOD_H/totalsum_H_6.5e+14Wcm_7fs.txt' u ($1):($3):($4) with yerrorbars pt 7 lc rgb "blue" linewidth 10 ps p_size title "" axis x1y2

unset label
unset y2tics
unset y2label
set key top right Right samplen 3
titleformat="%24.0f"
set logscale y 10
set tics font p0 tc "black"
set ytics offset ytics_offset_x, ytics_offset_y
set xtics offset xtics_offset_x, xtics_offset_y
set xlabel "Energy (eV)" font p1 offset xlabel_offset_x, xlabel_offset_y
set ylabel "Normalized Counts" font p1 tc "black" offset ylabel_offset_x, ylabel_offset_y
set format y '10^{%T}'
set arrow from 2*Up,0.025 to 2*Up,0.015 lw line_width1 size graph 0.025,15,45
set label "2U_p" font p0 at graph 0.56, 0.62
set key font p0
set key title "Kr, GDD (fs^2)" font p0 offset key_offset_x, key_offset_y
set key font p
set label "(g)" at graph label_pos_x, label_pos_y tc rgb "black" font p0 front
plot [0:130][1e-4:1.1] './GDD_Kr/Unified_normed_Kr_6.5e+14Wcm_7fs_0GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "red" lw line_width lt line_type1 title sprintf(titleformat, 0), './GDD_Kr/Unified_normed_Kr_6.5e+14Wcm_7fs_-10GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "orange" lw line_width lt line_type1 title "-10", './GDD_Kr/Unified_normed_Kr_6.5e+14Wcm_7fs_10GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "orange" lw line_width lt line_type2 dt dash_type title "10", './GDD_Kr/Unified_normed_Kr_6.5e+14Wcm_7fs_-20GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "brown" lw line_width lt line_type1 title "-20", './GDD_Kr/Unified_normed_Kr_6.5e+14Wcm_7fs_20GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "brown" lw line_width lt line_type2 dt dash_type title "20", './GDD_Kr/Unified_normed_Kr_6.5e+14Wcm_7fs_-30GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "green" lw line_width lt line_type1 title "-30", './GDD_Kr/Unified_normed_Kr_6.5e+14Wcm_7fs_30GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "green" lw line_width lt line_type2 dt dash_type title "30", './GDD_Kr/Unified_normed_Kr_6.5e+14Wcm_7fs_-40GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "cyan" lw line_width lt line_type1 title "-40", './GDD_Kr/Unified_normed_Kr_6.5e+14Wcm_7fs_40GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "cyan" lw line_width lt line_type2 dt dash_type title "40", './GDD_Kr/Unified_normed_Kr_6.5e+14Wcm_7fs_-50GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "blue" lw line_width lt line_type1 title "-50", './GDD_Kr/Unified_normed_Kr_6.5e+14Wcm_7fs_50GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "blue" lw line_width lt line_type2 dt dash_type title "50", './GDD_Kr/Unified_normed_Kr_6.5e+14Wcm_7fs_-60GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "violet" lw line_width lt line_type1 title "-60", './GDD_Kr/Unified_normed_Kr_6.5e+14Wcm_7fs_60GDD_0TOD_0FOD_1e-06epsilon.txt' u ($1):(abs($2-log_value)+log_value):($3) every number w yerrorlines lc rgb "violet" lw line_width lt line_type2 dt dash_type title "60" 

unset arrow
unset label
unset key
set logscale y 10
set y2tics (-0.09, 0 , 0.09)
set y2range [-0.09:0.09]
set ytics nomirror
set xlabel "Group Delay Dispersion (fs^2)" font p1 offset xlabel_offset_x, xlabel_offset_y
set tics font p0
set ylabel "Total Counts" font p1 tc "red" offset ylabel_offset_x, ylabel_offset_y
set format y '10^{%T}'
set y2label "A(D)" font p1 tc "blue" offset y2label_offset_x, y2label_offset_y
#set ytics ("" 0,"1" 1e4,"2" 2e4, "3" 3e4,"4" 4e4, "5" 5e4,"6" 6e4, "7" 7e4, "8" 8e4,"9" 9e4) offset "0.0" tc "red"
set ytics offset ytics_offset_x, ytics_offset_y tc "red"
set xtics offset xtics_offset_x, xtics_offset_y
set y2tics tc "blue" offset y2tics_offset_x, y2tics_offset_y
set label "(h)" at graph label_pos_x, label_pos_y tc rgb "black" font p0 front
plot [-70:70][1000:1000000] './GDD_Kr/totalsum_Kr_6.5e+14Wcm_7fs.txt' u ($1):($2):(1 * sqrt($2)) with yerrorbars axis x1y1 pt 7 lc rgb "red" linewidth 10 ps p_size title "", './GDD_Kr/totalsum_Kr_6.5e+14Wcm_7fs.txt' u ($1):($3):($4) with yerrorbars pt 7 lc rgb "blue" linewidth 10 ps p_size title "" axis x1y2

unset multiplot

set out
