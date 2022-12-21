DESTDIR=
DST=$(DESTDIR)/usr/share/texmf

build:
	true

clean:
	true

install:
	rm -rf $(DST)/*
	mkdir -p $(DST)
	cp -r texmf/* -t $(DST)/

test:
	make -C tests
