#!/bin/bash

CUDA_VISIBLE_DEVICES=0 fairseq-generate DeepL405000-bin \
                        --path ./checkpoints/KFTT/seed1/checkpoint23.pt:./checkpoints/KFTT/seed3/checkpoint24.pt:./checkpoints/KFTT/seed4/checkpoint24.pt \
			--batch-size 16 \
			--beam 6  > generate/KFTT/result.txt
grep "^H-" ./generate/KFTT/result.txt | sort -V | cut -f3 > ./generate/KFTT/pred.ja

cat generate/KFTT/pred.ja | spm_decode --model=./enja_spm_models/spm.ja.nopretok.model --input_format=piece > generate/KFTT/pred.detok.ja

cat generate/KFTT/pred.detok.ja | sacrebleu -w2 -l en-ja -t wmt20 | grep "score"

