DESTDIR=
DST=$(DESTDIR)/usr/share/texmf

build:
	true

clean:
	true

install:
	mkdir -p $(DST)
	cp -r texmf/* -t $(DST)/

test:
	make -C tests
