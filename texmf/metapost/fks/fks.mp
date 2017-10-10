%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                             %
% newfks.mp     v1.0                                          %
%                                                             %
% makra pro sazbu obrazku Fyzikalniho                         %
% korespondencniho seminare MFF UK                            %
%                                                             %
% vzniklo obohacenim starsiho fks.mp                          %
%                                                             %
% Jan Houstek,   12. 2001                                     %
% Lukas Ledvina, 10. 2012                                     %
%                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input fks-label
input mth-function

% TeXLive 2013 ugly fix
let endfigold=endfig;
def endfig=%
  currentpicture := currentpicture shifted (-llcorner currentpicture);
  endfigold;
enddef;

% základní jednotka
  u=1mm;

% čerchovaná čára (použití: draw ... dashed cerch [scaled ...] )
  picture cerch, cark;
  cerch=dashpattern(on 2bp off 1.5bp on 0.5bp off 1.5bp on 2bp);
  cark=dashpattern(on 3bp off 3bp on 3bp);

% zvětší x-krát aktuální pero (po použití je opět nastavena původní velikost)
% použití: draw ... wp x
  def wp = withpen currentpen scaled enddef;

% zvětší x-krát aktuální pero (nastaví novou velikost)
  def chpen = currentpen:=currentpen scaled enddef;

% nakreslí oblouk o poloměru d se středem v bm, výchozím směrem bm --> bi
% a konečným směrem bm --> be
  def uhel(expr bi,bm,be,d)=
  begingroup
    save x,y;
    z1=unitvector(bi-bm); z2=z1 rotated 90;
    z3=unitvector(be-bm); z4=z3 rotated 90;
    draw (bm+d*z1){z2}..{z4}(bm+d*z3)
  endgroup
  enddef;

% stejné jako úhel, pouze be je dopočítané a je přidaná tečka pro pravý úhel
  def uhelR(expr bi,bm,d)=
    uhel(bi,bm,(bm+(bi-bm) rotated 90),d);
    drawdot 0.6d*unitvector(bi-bm) rotated 45 shifted bm wp 3
  enddef;


% páka
  def paka(expr lav,pra,stp,zav,x,y)=
		draw(-lav,0)--(pra,0) wp2 shifted(x,y);
		provazVR(0.2stp,(x,y)--(x,y+zav));
		for i:=-(lav/stp) upto (pra/stp):
			fill(-0.1stp,0)..(0,0.1stp)..(0.1stp,0)..(0,-0.1stp)..cycle shifted(x+i*stp,y);% shifted bod;
		endfor;
	enddef;

%závažia na páku
% (škala,poloha x, y, text na vyplnenie)
  def zavaz(expr sca,x,y,text)=
		draw(-0.3sca,-0.5sca)--(0.3sca,-0.5sca)--(0.3sca,-1.1sca)--(-0.3sca,-1.1sca)--cycle wp1.5 shifted(x,y);
		provazVR(0.2sca,(x,y)--(x,y-0.5sca));
		label.top(text,(0.0sca,-1.05sca)).shifted(x,y);
	enddef;

% nakreslí osový kříž se středem v poc a rozměry x-left/right, y-up/down,
% vše kladné
  def axis(expr poc,xl,xr,yd,yu)=
  begingroup
    save xp,yp;
    xp:=xpart(poc);yp:=ypart(poc);
    drawarrow(xp-xl,yp)--(xp+xr,yp);
    drawarrow(xp,yp-yd)--(xp,yp+yu)
  endgroup
  enddef;  

% srafovani
  picture sraf;
  def srafuj(expr p,smer,hust)=
  begingroup
    save x,y,i,n,uhl;
    z1=llcorner p; z2=urcorner p;
    z0=.5[z1,z2]; uhl:=abs(z0-z1);
    n:=round(uhl/hust);
    z4=uhl*unitvector(smer);
    z3=z4 rotated 90;
    sraf:=nullpicture;
    for i:=-n upto n: 
      addto sraf doublepath z0+i/n*z3+z4--z0+i/n*z3-z4 wp .5;
    endfor;
    clip sraf to p; draw sraf;
  endgroup
  enddef;

% šipka s prázdnou hlavou
  def drawearrow expr p = _apth:=p; _finearr enddef;
  def drawdblearrow expr p = _apth:=p; _findearr enddef;
  def _finearr text t =
    draw _apth t;
    unfill arrowhead _apth; draw arrowhead _apth t
  enddef;
  def _findearr text t =
    draw _apth t;
    unfill arrowhead _apth; draw arrowhead _apth t;
    unfill arrowhead reverse _apth; draw arrowhead  reverse _apth t
  enddef;

% obyčejné (netroujúhelníkové) šipky
  vardef varrowhead expr p =
    save q,e; path q; pair e;
    e = point length p of p;
    q = gobble(p shifted -e cutafter makepath(pencircle scaled 2ahlength))
      cuttings;
    (q rotated .5ahangle & reverse q rotated -.5ahangle)  shifted e
  enddef;
  def drawvarrow expr p = _apth:=p; _finvarr enddef;
  def drawdblvarrow expr p = _apth:=p; _findvarr enddef;
  def _finvarr text t =
    draw _apth t;
    draw varrowhead _apth t
  enddef;
  def _findvarr text t =
    draw _apth t;
    draw varrowhead _apth t;
    draw varrowhead reverse _apth t
  enddef;

% pruzina 
def pruzina(expr pocatek,konec,sirka,pocet)=
  draw((0,0) for i=1 upto (10+20*pocet):..(10+i-10*cosd(18i),sind(18i))
  endfor) xscaled(length(pocatek-konec)/(30+20*pocet)) yscaled (sirka/2)
  rotated angle(konec-pocatek) shifted pocatek;
enddef;

% prazdne kolecko
def odot(expr prumer, bod)=
  unfill fullcircle scaled 2prumer shifted bod;
  draw fullcircle scaled 2prumer shifted bod wp 2  
enddef;

% lesknoucí se kulička
def kulicka(expr prumer,bod)=
  fill fullcircle scaled prumer shifted bod withcolor .8white;
  draw fullcircle scaled prumer shifted bod;
  fill fullcircle scaled (.6*prumer) shifted(bod+.15*prumer*dir135)
         withcolor .9white;
  fill fullcircle scaled (.4*prumer) shifted(bod+.17*prumer*dir135)
         withcolor .95white;
  erase fill fullcircle scaled (.2*prumer) shifted(bod+.19*prumer*dir135);
enddef;

% kotovani

vardef kota(expr poc, kon,lab)=
  save phi;
  phi:=angle(kon-poc)+22.5;
  phi:=(phi+720) mod 360;
  show phi;
  if phi<45:      kotaD.top(poc,kon,lab);
  elseif phi<90:  kotaD.ulft(poc,kon,lab);
  elseif phi<135: kotaD.lft(poc,kon,lab);
  elseif phi<180: kotaD.llft(poc,kon,lab);
  elseif phi<225: kotaD.bot(poc,kon,lab);
  elseif phi<270: kotaD.lrt(poc,kon,lab);
  elseif phi<315: kotaD.rt(poc,kon,lab);
  elseif phi<360: kotaD.urt(poc,kon,lab);
  elseif phi<405: kotaD.top(poc,kon,lab);
  fi
enddef;

vardef kotaD@#(expr poc, kon,lab)=
  kotaDP@#(poc,kon,lab,0.5);
enddef;

vardef kotaDP@#(expr poc, kon,lab, poz)=
  kotaDPK@#(poc,kon,0.5u,lab,poz,0mm);
enddef;

vardef kotaDPK@#(expr poc, kon, delta, lab, poz,kor)=
  save dirc,labL; pair dirc; picture labL;
  dirc=unitvector(kon-poc);
  draw poc--(poc+dirc.rotated90*delta) dashed cerch;
  draw kon--(kon+dirc.rotated90*delta) dashed cerch;
  drawdblvarrow (poc+dirc.rotated90*delta)--(kon+dirc.rotated90*delta);
  labL=thelabel.@#(lab,(0,0));
  labL:=labL.shifted(poz[poc,kon]+dirc.rotated90*(delta+kor));
  draw labL;
enddef;

% Lanko (bez vroubku)
def provaz(expr width, cesta)=
begingroup
  save _linecap;_linecap:=linecap;
  linecap:=butt;
  draw cesta wp.width  withcolor white;
  draw cesta wp.8width;
  draw cesta wp.4width withcolor white;
  linecap:=_linecap;
endgroup
enddef;

vardef dist(expr a,b)=(xpart a-xpart b)++(ypart a-ypart b) enddef;

% Provaz (ma vroubky)
% Minimalni polomer 1mm pro sirku 1.
% Nedelejte ten provaz moc krátký, blbne.
% 0.14 (delka carky) by mela byt co nejdyssi pro male polomery, ale 
%   nesmi byt moc vysoka je-li phi (uhel natoceni) maly, pak couha ven roh.
def provazVR(expr width, cestaX)=
begingroup
  save cesta,vrub,lastvr,direc,vrbot,vrtop,phi,carky,truelgt,A,B,C;
  provaz(width,cestaX);
% prodlouzeni cesty o jeden pricky prouzek
  path cesta;cesta:=
    point.0.of.cestaX-.5width*unitvector(direction.0.of.cestaX)--
    cestaX--
    point.length.cestaX.of.cestaX+width*unitvector(direction.length.cestaX.of.cestaX);

  pair vrub;  vrub  :=point.0.of.cesta;
  pair lastvr;lastvr:=point.0.of.cesta;
  pair direc;
  numeric vrbot,vrtop,phi;
  phi:=30; % uhel sklonu
  vrbot:=0;
  pen carky;carky:=makepen((0,-1)--(0,0)--cycle);

% mereni delky
  numeric n_lines;n_lines:=0;
  forever:
    vrtop:=length.cesta;
    for i=0 upto 32:
      vrub:=point .5[vrtop,vrbot]of.cesta;
      if dist(vrub,lastvr)>width/2:
        vrtop:=.5[vrtop,vrbot];
      else:
        vrbot:=.5[vrtop,vrbot];
      fi
    endfor
    lastvr:=point.vrbot.of.cesta;
    exitif (dist(vrub,point.length.cesta.of.cesta))<width;
    n_lines:=n_lines+1;
  endfor
% prava delka
numeric truelgt; truelgt:=n_lines*width/2-dist(vrub,point.length.cesta-1.of.cesta);
% nova roztec
  numeric _width;_width=2*truelgt/n_lines;
% nove natazeni cesty
  cesta:=
    point.0.of.cestaX-.5_width*unitvector(direction.0.of.cestaX)--
    cestaX--
    point.length.cestaX.of.cestaX+_width*unitvector(direction.length.cestaX.of.cestaX);

  boolean pockon;pockon:=true;
  vrub  :=point.0.of.cesta;
  lastvr:=point.0.of.cesta;
  vrbot :=0;
  for j=0 upto n_lines:
    vrtop:=length.cesta;
    for i=0 upto 32:
      vrub:=point .5[vrtop,vrbot]of.cesta;
      if dist(vrub,lastvr)>_width/2:
        vrtop:=.5[vrtop,vrbot];
      else:
        vrbot:=.5[vrtop,vrbot];
      fi
    endfor
    lastvr:=point.vrbot.of.cesta;
    exitif j=n_lines;

    direc:=unitvector(direction.vrbot.of.cesta).rotated.phi;
    direc:=direc*.14width/sind.phi;
    draw vrub.if.not.pockon:shifted(-direc)fi--vrub.shifted.direc
      withpen carky.rotated(angle.direc-phi+90).scaled.2width;
% zakonceni pocatku
    if.pockon:draw vrub--vrub.shifted.direc
      withpen carky.rotated(angle.direc-phi).scaled((.2*tand.phi)*width).fi;

    if pockon:pockon:=false.fi;
  endfor
% zakonceni konce
  direc:=unitvector(direction.vrbot.of.cesta).rotated.phi;
  direc:=direc*.14width/sind.phi;
  pair A;A:=vrub;
  pair B;B:=vrub.shifted(-direc);
  pair C;C:=A+(B-A).rotated(90-phi)*sind.phi;
  fill A--B--C--cycle wp .01;
endgroup
enddef;

