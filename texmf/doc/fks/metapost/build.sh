#!/bin/bash


for file in mp_cary mp_fks mp_circ 
do
    mpost $file.mp
    for((i=1; i<=100;i++)) do 
	mv $file.$i  "$file"_"$i".eps
    done
done

xelatex mp_demo.tex
