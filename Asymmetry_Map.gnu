reset

change = 3.509445520589769e+2
change_t = 41.341
set samples 20000
set encoding utf8

wlabel_pos_x = 0.02
wlabel_pos_y = 1.032

colorbox_size_x = 1
colorbox_size_y = 0.05
colorbox_origin_x = 0
colorbox_origin_y = 1.04
cblabel_offset_x = 0
cblabel_offset_y = 0

xlabel_offset_x = 0
xlabel_offset_y = -5
ylabel_offset_x = -9
ylabel_offset_y = 0
xtics_offset_x = 0
xtics_offset_y = -1
ytics_offset_x = 0
ytics_offset_y = 0

line_width = 7
p0 = "Bold Bold, 42"
p1 = "Bold Bold, 60"
set term eps size 28, 19
set out 'Asymmetry_Map.eps'

set size ratio 1/1
set border linewidth 10

set key spacing 1.4
set multiplot layout 2, 3 margins 0.05, 0.93, 0.05, 0.99 spacing 0.03,0.02

set ytics ("0" 0,"1" 180, "2" 360)
set link y2
set link x2
unset label
unset key
set ytics nomirror
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set cbrange[-1:1]
set cbtics (-1, 0, 1) font p0 offset cblabel_offset_x,cblabel_offset_y
set palette defined (-1 "blue", 0 "white", 1 "red")
set ytics nomirror
set xrange[0:3.2]
set yrange[0:360]
set ylabel "CEP ({/Symbol:Bold p})" font p1 offset ylabel_offset_x, ylabel_offset_y
set tics font p0
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
set label "Na, -5 fs^2 GDD" at graph wlabel_pos_x, wlabel_pos_y tc rgb "black" font p0 front #screen label_pos_bj1,label_pos_fl1 tc rgb "black" font p0 front
fileName = 'Asymmetry_Na_4e+12Wcm_4.5fs_-5GDD.txt'
unset colorbox
splot fileName u ($1):($2):($3) title ""

set link y2
set link x2
unset label
unset key
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set cbrange[-1:1]
set cbtics (-1, 0, 1) font p0 offset cblabel_offset_x,cblabel_offset_y
set palette defined (-1 "blue", 0 "white", 1 "red")
set xrange[0:3.45]
set yrange[0:360]
set ytics offset ytics_offset_x, ytics_offset_y tc "black"
set xtics offset xtics_offset_x, xtics_offset_y
set label "Na, 0 fs^2 GDD" at graph wlabel_pos_x, wlabel_pos_y tc rgb "black" font p0 front #screen label_pos_bj1,label_pos_fl1 tc rgb "black" font p0 front
fileName = 'Asymmetry_Na_4e+12Wcm_4.5fs_0GDD.txt'
unset colorbox
unset ytics
unset ylabel
splot fileName u ($1):($2):($3) title ""

unset label
unset key
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set ytics nomirror
set xlabel "Energy (eV)" font p1 offset xlabel_offset_x, xlabel_offset_y
set xrange[0:3.05]
set yrange[0:360]
set ylabel ""
set xlabel ""
set tics font p0
unset ytics
set xtics offset xtics_offset_x, xtics_offset_y
set label "Na, 5 fs^2 GDD" at graph wlabel_pos_x, wlabel_pos_y tc rgb "black" font p0 front #screen label_pos_bj1,label_pos_fl1 tc rgb "black" font p0 front
fileName = 'Asymmetry_Na_4e+12Wcm_4.5fs_5GDD.txt'
set cbrange[-1:1]
set cblabel "A(E,{/Symbol:Bold f}_{CEP})" font p1 offset 9,0
set cbtics (-1, 0, 1) font p0 offset cblabel_offset_x,cblabel_offset_y
set colorbox #horizontal user origin graph colorbox_origin_x,colorbox_origin_y size graph colorbox_size_x,colorbox_size_y
set cbtics font p0 offset cblabel_offset_x,cblabel_offset_y
splot fileName u ($1):($2):($3) title ""


unset label
unset key
set ytics ("0" 0,"1" 180, "2" 360)
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set ytics nomirror
set xlabel "Energy (eV)" font p1 offset xlabel_offset_x, xlabel_offset_y
set xrange[0:2.35]
set yrange[0:360]
set ylabel "CEP ({/Symbol:Bold p})" font p1 offset ylabel_offset_x, ylabel_offset_y
set tics font p0
set xtics offset xtics_offset_x, xtics_offset_y
set label "Na, -10 fs^2 GDD" at graph wlabel_pos_x, wlabel_pos_y tc rgb "black" font p0 front #screen label_pos_bj1,label_pos_fl1 tc rgb "black" font p0 front
fileName = 'Asymmetry_Na_4e+12Wcm_4.5fs_-10GDD.txt'
unset colorbox #horizontal user origin graph colorbox_origin_x,colorbox_origin_y size graph colorbox_size_x,colorbox_size_y
set cbtics font p0 offset cblabel_offset_x,cblabel_offset_y
splot fileName u ($1):($2):($3) title ""

unset ytics
unset label
unset key
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
#set cbrange[0:1]
#set y2tics 0.1,0.2
set ytics nomirror
set xlabel "Energy (eV)" font p1 offset xlabel_offset_x, xlabel_offset_y
set xrange[0:2.35]
set yrange[0:360]
set ylabel ""
set tics font p0
unset ytics
set xtics offset xtics_offset_x, xtics_offset_y
set label "Na, -10 fs^2 GDD" at graph wlabel_pos_x, wlabel_pos_y tc rgb "black" font p0 front #screen label_pos_bj1,label_pos_fl1 tc rgb "black" font p0 front
fileName = 'Asymmetry_Na_4e+12Wcm_4.5fs_-10GDD.txt'
unset colorbox #horizontal user origin graph colorbox_origin_x,colorbox_origin_y size graph colorbox_size_x,colorbox_size_y
set cbtics font p0 offset cblabel_offset_x,cblabel_offset_y
splot fileName u ($1):($2):($3) title ""


unset label
unset key
set pm3d map
set pm3d interpolate 0,0
set cblabel ""
set ytics nomirror
set xlabel "Energy (eV)" font p1 offset xlabel_offset_x, xlabel_offset_y
set xrange[0:2.3]
set yrange[0:360]
set ylabel "CEP (deg)" font p1 offset ylabel_offset_x, ylabel_offset_y
set ylabel ""
set tics font p0
unset ytics
set xtics offset xtics_offset_x, xtics_offset_y
set label "Na, 10 fs^2 GDD" at graph wlabel_pos_x, wlabel_pos_y tc rgb "black" font p0 front #screen label_pos_bj1,label_pos_fl1 tc rgb "black" font p0 front
fileName = 'Asymmetry_Na_4e+12Wcm_4.5fs_10GDD.txt'
set colorbox #horizontal user origin graph colorbox_origin_x,colorbox_origin_y size graph colorbox_size_x,colorbox_size_y
set cbtics font p0 offset cblabel_offset_x,cblabel_offset_y
set cblabel "A(E,{/Symbol:Bold f}_{CEP})" font p1 offset 9,0
splot fileName u ($1):($2):($3) title ""

unset multiplot

set out
