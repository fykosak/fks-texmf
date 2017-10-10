def drawdots(expr size) expr p= 
begingroup
    save i;
    for i=0 upto length(p):
        drawdot point i of p wp(size);
    endfor
endgroup
enddef;

def drawhlines(expr size) expr p= 
begingroup
    save i;
    for i=0 upto length(p):
        draw ((-1,0)--(1,0) scaled (.5*size)) shifted point i of p wp1;
    endfor
endgroup
enddef;

def drawvlines(expr size) expr p= 
begingroup
    save i;
    for i=0 upto length(p):
        draw ((0,-1)--(0,1) scaled (.5*size)) shifted point i of p wp1;
    endfor
endgroup
enddef;

def drawctverce(expr size)expr p= 
begingroup
    save i;
    for i=0 upto length(p):
        unfill ctverec(size) shifted point i of p;
        draw ctverec(size) shifted point i of p wp1;
    endfor
endgroup
enddef;

def drawtrojuhelniky(expr size)expr p= 
begingroup
    save i;
    for i=0 upto length(p):
        unfill trojuhelnik(size) shifted point i of p;
        draw trojuhelnik(size) shifted point i of p wp1;
    endfor
endgroup
enddef;

def drawkosoctverce(expr size)expr p= 
begingroup
    save i;
    for i=0 upto length(p):
        unfill ctverec(size) rotated 45 shifted point i of p;
        draw ctverec(size) rotated 45 shifted point i of p wp1;
    endfor
endgroup
enddef;


def ctverec(expr size) =
    ((-1,-1)--(-1,1)--(1,1)--(1,-1)--cycle) scaled (.5*size)
enddef;

def trojuhelnik(expr size) =
    ((-1,-.577)--(1,-.577)--(0,1.155)--cycle) scaled (.5*size*1.52)
enddef;
