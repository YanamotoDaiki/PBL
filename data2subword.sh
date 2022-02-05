#!/bin/bash

# split the corpus into subwords
mkdir -p ./KFTT-corpus/spm

for L in en ja; do
    for F in ./KFTT-corpus/orig/*.$L; do
	B=`basename $F`
	spm_encode --model=./enja_spm_models/spm.$L.nopretok.model --output_format=piece < $F > ./KFTT-corpus/spm/$B
    done
done
