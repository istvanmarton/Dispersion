reset
Hartree_to_eV = 27.21
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

change_t = 41.341
change = 5.14220674763e+1
change_E=27.211

p0 = "Bold Bold, 42"
p1 = "Bold Bold, 60"
set term eps size 28, 10
set out 'Electron_Energy.eps'
f(x) = 0
set size ratio 1/1.4


set multiplot layout 1, 2 margins 0.07, 0.98, 0.15, 0.95 spacing 0.13,0.0

set bars fullwidth
unset label
unset key
set label "(a)" at graph 0.08,0.9 tc rgb "black" font p0 front
set y2tics (-10, -8, -6, -4, -2, 0, 2 ,4, 6, 8, 10)
set y2range [-9:9]
set ytics nomirror
set xlabel "Time (fs)" font p1 offset xlabel_offset_x, xlabel_offset_y
set tics font p0
set ylabel "Energy (eV)" font p1 tc "red" offset ylabel_offset_x, ylabel_offset_y
set y2label "Electric field (10^{10} V/m)" font p1 tc "blue" offset y2label_offset_x, y2label_offset_y
set ytics offset ytics_offset_x, ytics_offset_y tc "red"
set xtics offset xtics_offset_x, xtics_offset_y
set y2tics tc "blue" offset y2tics_offset_x, y2tics_offset_y
p [-15:15] f(x) lc rgb "black" linewidth 7 dt 2, 'Electron_Energy.txt' u ($1/change_t):(change_E*$2) every 1 w l axis x1y1 lc rgb "red" linewidth 7 title "", 'awaveForm_6.5e+14Wcm_7fs_0CEP_0GDD_0TOD_0FOD_FOD.txt' u ($1/change_t):(change*$2) w l lc rgb "blue" linewidth 9 title "" axis x1y2  #, 'trajectory2.txt' u ($1/change_t):(change_E*$7) every 1 w l axis x1y1 lc rgb "black" linewidth 7 title ""

unset label
unset key
unset y2tics
unset y2label
set label "(b)" at graph 0.08,0.9 tc rgb "black" font p0 front
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set key font p0
set xlabel "Distance (atomic unit)" font p1 offset xlabel_offset_x, xlabel_offset_y
set ylabel "Potential Energy (eV)" font p1 tc "black" offset ylabel_offset_x, ylabel_offset_y
set xtics(1, 2, 3, 4, 5)
set size ratio 1/1.4
plot [0:5][-50:0] "H.txt" u ($1):(Hartree_to_eV*$2) w l lc rgb "blue" linewidth 8 title "hydrogen" at graph 0.8,0.16, "Kr.txt" u ($1):(Hartree_to_eV*$2) w l lc rgb "red" linewidth 8 title "krypton" at graph 0.8,0.1

unset multiplot

set out
reset
set terminal x11
