%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                             %
% fks-3d.mp     v1.0                                          %
%                                                             %
% makra pro sazbu obrazku Fyzikalniho                         %
% korespondencniho seminare MFF UK                            %
%                                                             %
% marka pro kresleni 3D obrazku                               %
%                                                             %
% Lukas Ledvina 10.2011                                       %
%                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                             %
% Pro ukladani 3D polohy se pouzivaji tri pole analogicky     %
%      k "z", "x" a "y", dale pro projektovanou hodnotu se    %
%      pouziva makro projektujisi z trech 3D poli.            %
%                                                             %
% Inicializace: vyber projekce:                               %
%                 VRP_tD:  volne rovnobezne prmitani PN       %
%                 AXON_tD: axonometrie                        %
%                                                             %
% Prvni cast:   3D souradnice ve trech polich, definovane     %
%               promenne pro zadavani a 2D vystup.            %
% Druha cast:   projekce rovinnych krivek z libovolne roviny  %
%               tecne ke kouli v bodu (x,y,z)                 %
% Treti cast:   rotace a translace v prostoru                 %
%                                                             %
% TODO: kresleni uhelu mezi krivkami                          %
%       jine projekce???                                      %
%                                                             %
% TODO pro masochisty: dodělat stínování                      %
%                      viditelnost.                           %
%                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        Inicializace                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Pole 3D souradnic
  numeric tDx[],tDy[],tDz[];

% Promenna tD pro 3D nastavovani
  vardef tD@# = (tDx@#,tDy@#,tDz@#) enddef;

%%%%%%%%%%%%%%%%
% nastaveni projekce
 % volne rovnobezne promitani (pravy nadhled)
  def VRP_tD =
    vardef dD@# = (tDy@# - sqrt(2)/4*tDx@#,tDz@# - sqrt(2)/4*tDx@#) enddef;
  enddef;

 % axonometrie
  def AXON_tD =
    vardef dD@# = ( (tDy@# - tDx@#)*sqrt(3)/2,tDz@# - tDx@#/2. - tDy@#/2.) enddef;
  enddef;

 % pohled zprava (zobrazuje se rovina YZ, X~-Y)
  def PzP_tD =
    vardef dD@# = (tDy@# - tDx@#/2.,tDz@#) enddef;
  enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Prvni cast                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% vypocet projekce (zvolene vyse)
  vardef proj(expr tDa) =
    begingroup.save tDx, tDy, tDz;tD0=tDa;dD0 endgroup enddef;

% norma bodu
  vardef norm_tD@# =
    sqrt(tDx@#*tDx@# + tDy@#*tDy@# + tDz@#*tDz@#) enddef;
  vardef norm(expr tDa) =
    sqrt(tDa dotprod_tD tDa) enddef;

% souradnice
  vardef xpart_tD@# = tDx@# enddef;
  vardef ypart_tD@# = tDy@# enddef;
  vardef zpart_tD@# = tDz@# enddef;

  vardef xpart_tD(expr tDa) =
    begingroup.save tDx, tDy, tDz;tD0=tDa;tDx0 endgroup enddef;
  vardef ypart_tD(expr tDa) =
    begingroup.save tDx, tDy, tDz;tD0=tDa;tDy0 endgroup enddef;
  vardef zpart_tD(expr tDa) =
    begingroup.save tDx, tDy, tDz;tD0=tDa;tDz0 endgroup enddef;

% skalarni soucin
  primarydef tDa dotprod_tD tDb = 
    (xpart_tD(tDa)*xpart_tD(tDb) + ypart_tD(tDa)*ypart_tD(tDb) + zpart_tD(tDa)*zpart_tD(tDb))
  enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Druha cast                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Transformace z roviny definovane tD_o, tD_x, tD_y do projektivni 
% roviny, osa X smeruje do smeru td_o->tD_x, osa Y je na ni kolma.
  def getTr(expr tD_o, tD_x, tD_y) =
    begingroup save tDx, tDy, tDz, T_;
  % pocatek, vektor x', y'
      tD0 = tD_o;
      tD1 = (tD_x-tD_o);
      tD2 = (tD_y-tD_o);
  % G-S OG
      tD3 = tD1;
      tD4 = tD2-tD1.dotprod_tD.tD2/(tD1.dotprod_tD.tD1)*tD1;
  % ON
      tD5 = tD3/norm.(tD3);
      tD6 = tD4/norm.(tD4);
  % v tD5,6 jsou normovane OG vektory; T_ vysledna transformace
      transform T_;
      (0,0) transformed T_ = dD0;
      (1,0) transformed T_ = dD0+dD5;
      (0,1) transformed T_ = dD0+dD6;
      T_
    endgroup
  enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Treti cast                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Translace ve 2D projekci
  def shifted_dD(expr tD_s) = shifted.proj(tD_s) enddef;

% Translace ve 3D
  primarydef tD_w shifted_tD tD_t = (tD_w+tD_t) enddef;

% Rotace okolo os ve 3D
  primarydef pt SpRotateX_tD phi =
    begingroup.save tDx,tDy,tDz,x,y; tD0=pt;
    z0=(tDy0,tDz0).rotated(phi); tD1=(tDx0,x0,y0); 
    tD1 endgroup enddef;
  primarydef pt SpRotateY_tD phi =
    begingroup.save tDx,tDy,tDz,x,y; tD0=pt;
    z0=(tDz0,tDx0).rotated(phi); tD1=(y0,tDy0,x0); 
    tD1 endgroup enddef;
  primarydef pt SpRotateZ_tD phi =
    begingroup.save tDx,tDy,tDz,x,y; tD0=pt;
    z0=(tDx0,tDy0).rotated(phi); tD1=(x0,y0,tDz0); 
    tD1 endgroup enddef;

% Rotace pt okolo normaloveho vektoru nP->nK o uhel phi
  def rotate_tD(expr pt,nP,nK,phi) =
    begingroup save tDx, tDy, tDz, phiZ, phiX;
  % pocatek, vektor rotace
      tD0=nP;
      tD1=nK-nP;
  % vypocet uhlu: precesni, nutacni
      phiZ:= if (tDy1,tDx1)      <>(0,0): angle(tDy1,tDx1)       else: 0 fi;
      phiX:= if (tDz1,tDx1++tDy1)<>(0,0): angle(tDz1,tDx1++tDy1) else: 0 fi;
  % Transformace
      tD2 = pt
            shifted_tD.-tD0     % posunuti do pocatku
            SpRotateZ_tD  phiZ  % nutace
            SpRotateX_tD  phiX  % precese
            SpRotateZ_tD  phi   % rotace okolo te spr. osy
            SpRotateX_tD -phiX  % precese zpet
            SpRotateZ_tD -phiZ  % nutace zpet
            shifted_tD.tD0;     % posun zpet
      tD2
    endgroup
  enddef;
