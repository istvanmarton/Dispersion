reset
change = 3.509445520589769e+2
change_t = 41.341
PulseWidth = 7
sigma = PulseWidth/sqrt(8 * log (2))
f(x) = 6.5 * (exp(- x * x / (2 * sigma * sigma)))
set samples 20000
set encoding utf8

label_pos_x = 0.08
label_pos_y = 0.88

xlabel_offset_x = 0
xlabel_offset_y = -5
ylabel_offset_x = -15
ylabel_offset_y = 0
xtics_offset_x = 0
xtics_offset_y = -1
ytics_offset_x = 0
ytics_offset_y = 0

line_width = 25
p0 = "Bold Bold, 42"
p1 = "Bold Bold, 60"
set term eps size 28, 30
set out 'Wigner.eps'

set size ratio 1/1.4
set border linewidth 10

unset label
set key spacing 1.4
set multiplot layout 3, 2 margins 0.1, 0.95, 0.1, 0.95 spacing 0.08
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y
set xtics offset xtics_offset_x, xtics_offset_y
set xlabel "t (fs)" font p1 offset xlabel_offset_x, xlabel_offset_y
set ylabel "Intensity (W cm^{-2})" font p1 tc "black" offset ylabel_offset_x, ylabel_offset_y
set key font p0
set ytics ("" 0, "1" 1, "2" 2, "3" 3, "4" 4, "5" 5, "6" 6, "7" 7, "8" 8)
set label "(a)" at graph label_pos_x, label_pos_y tc rgb "black" font p0 front
plot [-20:20][0:7.5] f(x) with line lt 1 lw line_width lc rgb "red" title "Transform limited","waveForm_6.5e+14Wcm_7fs_0CEP_10GDD_0TOD_0FOD.txt" u ($1/change_t):(change * $3 * $3) with line lw line_width lc rgb "blue" title "10 fs^2 GDD"

unset label
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set cbrange[0:1]
unset key
set ytics nomirror
set xlabel "t (fs)" font p1 offset xlabel_offset_x, xlabel_offset_y
set xrange[-22.5:22.5]
set yrange[1.8:3]
set ytics (1.8, 2.1, 2.4, 2.7, 3)
set ylabel "{/Symbol:Bold w} (fs^{-1})" offset ylabel_offset_x, ylabel_offset_y
set tics font p0
#set ytics ("" 0,"1" 1e4,"2" 2e4, "3" 3e4,"4" 4e4, "5" 5e4,"6" 6e4, "7" 7e4, "8" 8e4,"9" 9e4) offset "0.0" tc "red"
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
set label "(b)" at graph label_pos_x, label_pos_y tc rgb "white" font p0 front
splot 'Wigner_6.5e+14Wcm_7fs_10GDD_0TOD_0FOD.txt' u ($1):($2):($3) w pm3d title ""

unset label
set tics font p0 tc "black"
set ytics offset ytics_offset_x, ytics_offset_y
set xtics offset xtics_offset_x, xtics_offset_y
set xlabel "t (fs)" font p1 offset xlabel_offset_x, xlabel_offset_y
set ylabel "Intensity (W cm^{-2})" font p1 tc "black" offset ylabel_offset_x, ylabel_offset_y
set key font p0
#set key title "TOD (fs^3)" font p0
set ytics ("" 0, "1" 1, "2" 2, "3" 3, "4" 4, "5" 5, "6" 6, "7" 7, "8" 8)
set label "(c)" at graph label_pos_x, label_pos_y tc rgb "black" font p0 front
plot [-20:20][0:7.5] f(x) with line lt 1 lw line_width lc rgb "red" title "Transform limited","waveForm_6.5e+14Wcm_7fs_0CEP_0GDD_90TOD_0FOD.txt" u ($1/change_t):(change * $3 * $3) with line lw line_width lc rgb "blue" title "90 fs^3 TOD"

unset label
unset key
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set cbrange[0:1]
#set y2tics 0.1,0.2
set ytics nomirror
set xlabel "t (fs)" font p1 offset xlabel_offset_x, xlabel_offset_y
set xrange[-25:40]
set yrange[1.8:3]
set ylabel "{/Symbol:Bold w} (fs^{-1})" offset ylabel_offset_x, ylabel_offset_y
set ytics (1.8, 2.1, 2.4, 2.7, 3)
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
set label "(d)" at graph label_pos_x, label_pos_y tc rgb "white" font p0 front
splot 'Wigner_6.5e+14Wcm_7fs_0GDD_90TOD_0FOD.txt' u ($1):($2):($3) w pm3d title ""

unset label
set tics font p0 tc "black"
set ytics offset ytics_offset_x, ytics_offset_y
set xtics offset xtics_offset_x, xtics_offset_y
set xlabel "t (fs)" font p1 offset xlabel_offset_x, xlabel_offset_y
set ylabel "Intensity (W cm^{-2})" font p1 tc "black" offset ylabel_offset_x, ylabel_offset_y
set key font p0
#set key title "FOD (fs^4)" font p0
set ytics ("" 0, "1" 1, "2" 2, "3" 3, "4" 4, "5" 5, "6" 6, "7" 7, "8" 8)
set label "(e)" at graph label_pos_x, label_pos_y tc rgb "black" font p0 front
plot [-20:20][0:7.5] f(x) with line lt 1 lw line_width lc rgb "red" title "Transform limited","waveForm_6.5e+14Wcm_7fs_0CEP_0GDD_0TOD_500FOD.txt" u ($1/change_t):(change * $3 * $3) with line lw line_width lc rgb "blue" title "500 fs^4 FOD"

unset label
unset key
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set cbrange[0:1]
set ytics nomirror
set xlabel "t (fs)" font p1 offset xlabel_offset_x, xlabel_offset_y
set xrange[-45:45]
set yrange[1.8:3]
set ytics (1.8, 2.1, 2.4, 2.7, 3)
set ylabel "{/Symbol:Bold w} (fs^{-1})" offset ylabel_offset_x, ylabel_offset_y
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
set label "(f)" at graph label_pos_x, label_pos_y tc rgb "white" font p0 front
splot 'Wigner_6.5e+14Wcm_7fs_0GDD_0TOD_500FOD.txt' u ($1):($2):($3) w pm3d title ""

unset multiplot

set out
