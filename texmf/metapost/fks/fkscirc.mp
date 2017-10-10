% fkscirc.mp
% Marek Nečada 2011
% rozšíření balíku makecirc
% TODO vylepšit kompatibilitu s ostatními fykosími balíky
input makecirc-fks

newinternal svorad, svotrcdrat, svoroztec;
svorad:=.11ssize;
svotrcdrat:=.4ssize;
svoroztec:=.55ssize;
%type momentálně nic nedělá
vardef svorky@#(expr zz, type, ang, name, val)=
	save z;pair z;z:=zz.if.fks_center:-(svotrcdrat+.5voroztec+svorad,0)rotated.ang.fi;
	save svo;
	pair SV@#.p,SV@#.n; % pines %
	SV@#.p:=(z+(2*svotrcdrat+svoroztec+2svorad,0)) rotatedaround(z,ang);
	SV@#.n:=z;
	picture svo;
	svo:=nullpicture;

	addto svo doublepath z--(z+(svotrcdrat,0)) withpen line;
	addto svo doublepath (z+(svotrcdrat+svoroztec+2*svorad,0))--(z+(2*svotrcdrat+svoroztec+2*svorad,0)) withpen line;
	addto svo doublepath fullcircle scaled svorad shifted (z+(svotrcdrat+.5svorad,0)) withpen misc;
	addto svo doublepath fullcircle scaled svorad shifted (z+(svotrcdrat+svoroztec+1.5svorad,0)) withpen misc;

	draw svo rotatedaround (z,ang);

	putlabel(SV@#.p,SV@#.n,.1ssize,.1ssize,ang,name,val);
enddef;

	
