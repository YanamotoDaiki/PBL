#!/bin/bash

CUDA_VISIBLE_DEVICES=3 fairseq-generate DeepL405000-bin \
		    --path ./checkpoints/DeepL405000/seed1/checkpoint23.pt:./checkpoints/DeepL405000/seed2/checkpoint22.pt:./checkpoints/DeepL405000/seed3/checkpoint21.pt:./checkpoints/DeepL405000/seed4/checkpoint21.pt:./checkpoints/DeepL405000/seed5/checkpoint22.pt:./checkpoints/DeepL405000/seed11/checkpoint19.pt \
		    --batch-size 16 \
		    --beam 6  > generate/DeepL405000/result.txt

grep "^H-" ./generate/DeepL405000/result.txt | sort -V | cut -f3 > ./generate/DeepL405000/pred.ja

cat generate/DeepL405000/pred.ja | spm_decode --model=./enja_spm_models/spm.ja.nopretok.model --input_format=piece > generate/DeepL405000/pred.detok.ja

cat generate/DeepL405000/pred.detok.ja | sacrebleu -w2 -l en-ja -t wmt20
