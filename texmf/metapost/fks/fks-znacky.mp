%% znacky.mf
%% posledni uprava 19. 12. 1997

znacky_scale:=1;
transform now;

def uloz(expr bod,uhel) text tr= %% makro pro nastaveni transformaci
  now:=identity tr scaled znacky_scale rotated uhel shifted bod;
  begingroup
enddef;

def vloz(expr bod) text tr= %% makro pro nastaveni transformaci
  now:=identity tr scaled scalingfactor shifted bod;
  begingroup
enddef;

def civka(expr p) text params=
  uloz params;
    save i;
    erase draw (0,0)--(p*5mm,0) transformed now;
    for i=1 upto p: 
      draw halfcircle scaled 5mm shifted (i*5mm-2.5mm,0) transformed now;
    endfor;
  endgroup;
enddef;

def dioda text params=
  uloz params;
  draw (origin--dir150--dir-150--origin--(0,ypart(dir150))
    --(0,ypart(dir-150))) scaled 4mm transformed now;
  endgroup;
enddef;

def zdioda text params=
  dioda params;
  uloz params;
  draw (0,2.05mm)--(-1.3mm,2.05mm) transformed now;
  endgroup;
enddef;

def kond text params=
  uloz params;
  erase fill unitsquare xscaled 1.2mm yscaled 7mm shifted (-0.6mm,-3.5mm)
    transformed now;
  draw ((-0.6mm,-4mm)--(-0.6mm,4mm)) transformed now;
  draw ((0.6mm,-4mm)--(0.6mm,4mm)) transformed now;
  endgroup;
enddef;

def lkond text params=
  kond params;
  uloz params;
  draw (-4mm,-4mm)--(4mm,4mm) transformed now;
  draw (-4mm,-4mm)+1.5mm*dir25--(-4mm,-4mm)--(-4mm,-4mm)+1.5mm*dir65
    transformed now;
  endgroup;
enddef;

def rez text params=
  uloz params;
  erase fill unitsquare xscaled 10mm yscaled 3mm shifted (-5mm,-1.5mm)
    transformed now;
  draw unitsquare xscaled 10mm yscaled 3mm shifted (-5mm,-1.5mm)
    transformed now;
  endgroup;
enddef;

def pot text params=
  rez params;
  uloz params;
  draw (-5mm,-5mm)--(5mm,5mm) transformed now;
  draw (-5mm,-5mm)+1.8mm*dir25--(-5mm,-5mm)--(-5mm,-5mm)+1.8mm*dir65
    transformed now;
  endgroup;
enddef;

def trimr text params=
  rez params;
  uloz params;
  draw (-4mm,-4mm)--(5mm,5mm);  draw (-4.7mm,-3.3mm)--(-3.3mm,-4.7mm)
    transformed now;
  endgroup;
enddef;

def zdroj text params=
  uloz params;
  erase fill (-0.6mm,-2.5mm)--(-0.6mm,2.5mm)--(0.6mm,5mm)
      --(0.6mm,-5mm)--cycle transformed now;
  draw (-0.6mm,-2.5mm)--(-0.6mm,2.5mm) transformed now;
  draw (0.6mm,-5mm)--(0.6mm,5mm) transformed now;
  endgroup;
enddef;

def tranzist=
    save x,y,R;
    z1=(-6mm,0);  z2=(0,3.5mm);  z3=(0,-3.5mm);
    z12=1/2[z1,z2];
    z0-z12=whatever*((z1-z2) rotated 90); y0=0;
    R=length(z1-z0);
    erase fill fullcircle scaled 2R shifted z0 transformed now;
    draw fullcircle scaled 2R shifted z0 transformed now;
    z4=(-3.5mm,0);  z5=(-3.5mm,-2.6mm);  z6=(-3.5mm,2.6mm);
    z7=(-3.5mm,-1.2mm);  z8=(-3.5mm,1.2mm);
    draw z1--z4 transformed now;
    draw z5--z6 transformed now;
    draw z7--z3 transformed now;
    draw z8--z2 transformed now;
enddef;

def npn text params=
  uloz params;
  save x,y;
  tranzist;
  z3=(0,-3.5mm); z7=(-3.5mm,-1.2mm);
  draw z3+1.8mm*dir(angle(z7-z3)+20)--z3--z3+1.8mm*dir(angle(z7-z3)-20)
    transformed now;
  endgroup;
enddef;

def pnp text params=
  uloz params;
  save x,y;
  tranzist;
  z3=(0,-3.5mm); z7=(-3.5mm,-1.2mm);
  draw z7+1.8mm*dir(angle(z3-z7)+20)--z7--z7+1.8mm*dir(angle(z3-z7)-20)
    transformed now;
  endgroup;
enddef;

def plus text params=
  vloz params;
  draw (right--left) scaled .7mm transformed now;
  draw (up--down) scaled .7mm transformed now;
  endgroup;
enddef;

def minus text params=
  vloz params;
  draw (right--left) scaled .7mm transformed now;
  endgroup;
enddef;

def oz text params=
  uloz params;
    save x,y;
    z1=(12mm,0); z2=(0,7mm); z3=(0,-7mm); z4=(1.7mm,4mm);
    z5=(1.7mm,-4mm);
    erase fill z1--z2--z3--cycle;  draw z1--z2--z3--cycle transformed now;
    draw (right--left) scaled .7mm shifted z4 transformed now;
    draw (right--left) scaled .7mm shifted z5 transformed now;
    draw (up--down) scaled .7mm shifted z5 transformed now;
  endgroup;
enddef;

def zarovka text params=
  vloz params;
  erase fill fullcircle scaled 6mm transformed now;
  draw fullcircle scaled 6mm transformed now;
  draw (dir45--dir-135) scaled 3mm transformed now;
  draw (dir-45--dir135) scaled 3mm transformed now;
  endgroup;
enddef;

def meridlo text params=
  vloz params;
  erase fill fullcircle scaled 7mm transformed now;
  draw fullcircle scaled 7mm transformed now transformed now;
  endgroup;
enddef;

def zdirka text params=
  uloz params;
  erase fill (halfcircle--cycle) rotated 90 shifted (.5,0) scaled 2.5mm
    transformed now;
  draw halfcircle rotated 90 shifted (.5,0) scaled 2.5mm transformed now;
  endgroup;
enddef;

def rep text params=
  uloz params;
  erase fill (2mm,-2.5mm)--(5mm,-5mm)--(5mm,5mm)--(2mm,2.5mm)--
      (-2mm,2.5mm)--(-2mm,-2.5mm)--cycle transformed now;
  draw unitsquare xscaled 4mm yscaled 5mm shifted (-2mm,-2.5mm)
    transformed now;
  draw (2mm,-2.5mm)--(5mm,-5mm)--(5mm,5mm)--(2mm,2.5mm)--cycle transformed now;
  endgroup;
enddef;

def vlna=
  draw (left{dir45}..origin..{dir45}right)
enddef;

def vlnka text params=
  vloz params;  vlna scaled 1.3mm transformed now; endgroup;
enddef;

def tongen text params=
  vloz params;
  erase fill unitsquare scaled 10mm shifted (-5mm,-5mm) transformed now;
  draw unitsquare scaled 10mm shifted (-5mm,-5mm) transformed now;
  vlna scaled 3mm shifted (0,1mm) transformed now;
  vlna scaled 3mm shifted (0,-1mm) transformed now;
  draw (-2mm,-3mm)--(2mm,3mm) transformed now;
  draw (2mm,3mm)+mm*dir(angle(-2,-3)+20)--(2mm,3mm)
    --(2mm,3mm)+mm*dir(angle(-2,-3)-20) transformed now;
  endgroup;
enddef;

def oscil text params=
  vloz params;
  erase fill unitsquare xscaled 10mm yscaled 15mm shifted (-5mm,-5mm)
    transformed now;
  draw unitsquare xscaled 10mm yscaled 15mm shifted (-5mm,-5mm)
    transformed now;
  draw fullcircle scaled 4mm shifted (0,6.25mm) transformed now;
  draw fullcircle scaled mm shifted (-3mm,0) transformed now;
  draw fullcircle scaled mm shifted (3mm,0) transformed now;
  draw (3mm,-4mm)--(3mm,-2mm); draw (2mm,-4mm)--(4mm,-4mm) transformed now;
  erase fill fullcircle scaled mm shifted (3mm,-2mm) transformed now;
  draw fullcircle scaled mm shifted (3mm,-2mm) transformed now;
  endgroup;
enddef;

def spoj text params=
  vloz params;  filldraw fullcircle scaled .8mm transformed now; endgroup;
enddef;

def oval text params=
  uloz params;
    save p;
    path p;
    p=halfcircle scaled 10mm rotated 270 shifted (4mm,0)--
      halfcircle scaled 10mm rotated 90 shifted (-4mm,0)--cycle;
    erase fill p transformed now;
    draw p transformed now;
  endgroup;
enddef;
