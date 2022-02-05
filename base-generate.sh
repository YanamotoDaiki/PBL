#!/bin/bash

for i in {11..15}; do
    CUDA_VISIBLE_DEVICES=3 fairseq-generate DeepL405000-bin \
		 --path ./checkpoints/DeepL405000/seed$i/checkpoint18.pt \
		 --batch-size 128 \
		 --beam 6  > generate/DeepL405000/seed$i/result.txt

    grep "^H-" ./generate/DeepL405000/seed$i/result.txt | sort -V | cut -f3 > ./generate/DeepL405000/seed$i/pred.ja

    cat generate/DeepL405000/seed$i/pred.ja | spm_decode --model=./enja_spm_models/spm.ja.nopretok.model --input_format=piece > generate/DeepL405000/seed$i/pred$i.detok.ja
done

for i in {11..15}; do
    cat generate/DeepL405000/seed$i/pred$i.detok.ja | sacrebleu -w2 -l en-ja -t wmt20 | grep "score"
done
