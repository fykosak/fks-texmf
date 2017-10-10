%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                             %
% fks-label.mp     v1.0                                       %
%                                                             %
% makra pro sazbu obrazku Fyzikalniho                         %
% korespondencniho seminare MFF UK                            %
%                                                             %
% marka pro kresleni popisku                                  %
%                                                             %
% Lukas Ledvina 10.2011                                       %
%                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% .4mm je pouzivana hodnota, proto je nastavena na konstantu.

% olabel label s odot, ala dotlabel
  vardef olabel@#(expr lab,point)=
    odot(.4mm,point);
    label.@#(lab,point);
  enddef;

% oflabel label s odot a bile pozadi
  vardef oflabel@#(expr lab,point)=
    save pi;
    picture pi;
    pi:=thelabel.@#(lab,point);unfill bbox pi; draw pi;
    odot(.4mm,point);
  enddef;

% flabel label a bile pozadi
  vardef flabel@#(expr lab,point)=
    save pi;
    picture pi;
    pi:=thelabel.@#(lab,point);unfill bbox pi; draw pi;
  enddef;

