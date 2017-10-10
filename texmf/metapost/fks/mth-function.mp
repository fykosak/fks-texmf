%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                             %
% mth-function.mp   v1.0                                      %
%                                                             %
% makra pro matematike funkce                                 %
%                                                             %
% Andre Heck 2003                                             %
%                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numeric pi; pi := 3.1415926;
numeric radian; radian := 180/pi; % 2pi*radian = 360 ;

vardef sqr     primary x = (x*x)                                 enddef;
vardef log     primary x = (if x=0: 0 else: mlog(x)/mlog(10) fi) enddef;
vardef ln      primary x = (if x=0: 0 else: mlog(x)/256 fi)      enddef;
vardef exp     primary x = ((mexp 256)**x)                       enddef;
vardef inv     primary x = (if x=0: 0 else: x**-1 fi)            enddef;
vardef pow     (expr x,p) = (x**p)                               enddef;
% trigonometric functions
vardef tand    primary x = (sind(x)/cosd(x))                     enddef;
vardef cotd    primary x = (cosd(x)/sind(x))                     enddef;
vardef sin     primary x = (sind(x*radian))                      enddef;
vardef cos     primary x = (cosd(x*radian))                      enddef;
vardef tan     primary x = (sin(x)/cos(x))                       enddef;
vardef cot     primary x = (cos(x)/sin(x))                       enddef;
% hyperbolic functions
vardef sinh    primary x = save xx ; xx = exp xx ; (xx-1/xx)/2   enddef ;
vardef cosh    primary x = save xx ; xx = exp xx ; (xx+1/xx)/2   enddef ;
vardef tanh    primary x = (sinh(x)/cosh(x))                     enddef;
vardef coth    primary x = (cosh(x)/sinh(x))                     enddef;
% inverse trigonometric and hyperbolic functions
vardef arcsind primary x = angle((1+-+x,x))                      enddef;
vardef arccosd primary x = angle((x,1+-+x))                      enddef;
vardef arcsin  primary x = ((arcsind(x))/radian)                 enddef;
vardef arccos  primary x = ((arccosd(x))/radian)                 enddef;
vardef argcosh primary x = ln(x+(x+-+1))                         enddef;
vardef argsinh primary x = ln(x+(x++1))                          enddef;
vardef arctand primary x = arcsind(x/sqrt(x++1))                 enddef;
vardef arctan  primary x = ((arctand(x))/radian)                 enddef;
vardef arccotd primary x = arccosd(x/sqrt(x++1))                 enddef;
vardef arccot  primary x = ((arccotd(x))/radian)                 enddef;
