input fks
input makecirc-fks
input fkscirc
verbatimtex
%&latex
\documentclass[9pt]{extarticle}
\usepackage[utf8]{inputenc}
\usepackage{fkssugar}
\begin{document}
etex
 
prologues:=3;
u:=1cm;
 
beginfig(1);
fks_center:=true;
inductor.AA((0,0),Up,45,btex $L_1$ etex, btex $"1 H"$ etex);
endfig;

beginfig(2);
fks_center:=true;
capacitor.AA((0,0),Up,45,btex $C_1$ etex, btex $"1 \micro F"$ etex);
endfig;

beginfig(3);
fks_center:=true;
motor.AA((0,0),45,btex $M_1$ etex,"");
endfig;

beginfig(4);
fks_center:=true;
transformer.AA((0,0),mid,0);
endfig;

beginfig(5);
fks_center:=true;
source.AA((0,0),AC,90,btex$B_0$etex,btex$"3 V"$etex);
endfig;

beginfig(6);
fks_center:=true;
diode.AA((0,0),zener,45,pinA,btex$D_1$etex,"");
endfig;

beginfig(10);
fks_center:=true;
impedance.AA((0,0),45,btex $R_1$ etex, btex $"1 \ohm"$ etex);
endfig;

beginfig(11);
fks_center:=true;
switch.Sa((0,0  ),NC,0,"","");
switch.Sb((0,.5u),NO,0,"","");
endfig;

beginfig(12);
fks_center:=true;
battery.Ba((0,0),0,"","");
endfig;



verbatimtex
\end{document}
etex
 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% prikazy pro vyhledavani ctrl-N vimem
%withcolor black white red green blue

%% cary.mp
%drawdots drawhlines drawvlines drawctverce drawtrojuhelniky drawkosoctverce

%% fks-3d.mp
%tDx tDy tDz tD VRP_tD AXON_tD PzP_tD proj norm_tD xpart_tD ypart_tD zpart_tD 
%dotprod_tD getTr shifted_dD shifted_tD SpRotateX_tD SpRotateY_tD SpRotateZ_tD 
%rotate_tD

%% fkscirc.mp
%svorky

%% fks-label.mp
%olabel oflabel flabel

%% newfks-logos.tex
%trubka erasetrubka

%% fks.mp
%cerch cark wp chpen uhel uhelR axis srafuj drawearrow drawdblearrow
%varrowhead drawvarrow drawdblvarrow pruzina odot kulicka

%% makecirc-fks.mp
%line misc miscahead bjtahead txtahead wire wireU centreof centerto scalecirc 
%puttext ctext putlabel inductor capacitor motor generator transformer source 
%resistor diode transistor meains ground junction impedance lamp switch battery 
%current imesh rheostat

%% mth-function.mp
%pi radian sqr log ln exp inv pow tand cotd sin cos tan cot sinh cosh tanh coth
%arcsind arccosd arcsin arccos argcosh argsinh

%% prevzato z diplomka.pdf: (prikazy matapostu)
%ahangle ahlength arclength arctime background bbox bboxmargin beginfig 
%begingroup beveled boolean btex buildcycle butt color currentpicture cutafter 
%cutbefore controls curl cycle dashed dashpattern def defaultfont defaultpen 
%defaultscale defaultscaled direction directionpoint directiontime dotlabel 
%downto draw dir drawarrow drawarrow reverse drawdblarrow drawdot else elseif 
%end enddef endfig endfor endgroup etex evenly exitif exitunless expr fi fill 
%filldraw fontsize for forever forsuffixes fullcircle halfcircle if image 
%infinity intersectionpoint intersectiontimes inverse label labeloffset length 
%linecap linejoin makepath makepen mitered mpxbreak numeric pair path pen 
%pencircle pensquare pickup picture point prologues quatercircle reflectedabout 
%rotated rotatedaround rounded save scaled shifted show slanted spark squared 
%step str string subpath suffix text tension thelabel transform transformed 
%undraw undrawdot unfill unfilldraw until upto vardef verbatimtex whatever 
%withdots xscaled

