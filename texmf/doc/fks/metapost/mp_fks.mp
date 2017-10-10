input fks
input cary
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
draw (0,0)--(u,0) dashed cerch;
endfig;
 
beginfig(2);
draw (0,0)--(u,0) dashed cark;
endfig;
  
beginfig(3);
draw (0,0)--(u,0) wp5;
endfig;

beginfig(4);
draw (0,0)--(u,0);
draw (0,0)--(u,0).rotated30;
uhel((u,0),(0,0),(u,0).rotated30,8mm);
olabel.bot(btex $\bod A$ etex,(u,0));
olabel.bot(btex $\bod B$ etex,(0,0));
olabel.top(btex $\bod C$ etex,(u,0).rotated30);
endfig;

beginfig(5);
draw (0,0)--(u,0);
draw (0,0)--(0,u);
uhelR((u,0),(0,0),5mm);
olabel.bot(btex $\bod A$ etex,(u,0));
olabel.bot(btex $\bod B$ etex,(0,0));
endfig;
  
beginfig(6);
axis((0,0),.2u,u,.1u,.5u);
endfig;

beginfig(7);
srafuj((0,0)--(u,0)--(0,.5u)--cycle,dir45,1mm);
endfig;

beginfig(8);
drawearrow (0,0)--(u,0);
endfig;

beginfig(9);
drawdblearrow (0,0)--(u,0); 
endfig;

beginfig(10);
drawvarrow ((0,0)--(u,0));
endfig;

beginfig(11);
drawdblvarrow ((0,0)--(u,0));
endfig;

beginfig(12);
pruzina((0,0),(u,0),.1u,4);
endfig;

beginfig(13);
odot(.4mm,(0,0));
endfig;


beginfig(14);
kulicka(5mm,(0,0));
endfig;

beginfig(15);
z0=(0,0);z1=(u,u);
kotaDPK.ulft(z0,z1,0.5u,btex $l$ etex,0.5,0mm);
endfig;

beginfig(16);
z0=(0,0);z1=(u,0);
provaz(8,z0--z1);
endfig;

beginfig(17);
z0=(0,0);z1=(u,0);
provazVR(8,z0--z1);
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

