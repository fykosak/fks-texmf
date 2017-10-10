.PHONY: all clean

all: jakpsat.pdf

jakpsat.pdf: jakpsat.tex
	xelatex -shell-escape -8bit $<
	xelatex -shell-escape -8bit $<

clean:
	rm *.log *.tmp *.out *.aux
