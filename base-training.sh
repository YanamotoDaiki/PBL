#!/bin/bash

PRETRAINED_MODEL=./KFTT-model/seed5/checkpoint_best.pt
for i in {1..5}; do
    CUDA_VISIBLE_DEVICES=0,1 fairseq-train DeepL405000-bin --restore-file $PRETRAINED_MODEL \
	          --arch transformer --optimizer adam \
	          --clip-norm 1.0 \
	          --lr-scheduler inverse_sqrt --warmup-init-lr 1e-07 \
	          --warmup-updates 4000 --lr 0.001 --dropout 0.3 \
	          --criterion label_smoothed_cross_entropy \
	          --label-smoothing 0.1 \
	          --max-tokens 6000 \
	          --reset-optimizer --update-freq 2 \
	          --max-epoch 25 --reset-dataloader \
		  --seed $i \
		  --save-dir checkpoints/KFTT/seed$i \
                  --keep-last-epochs 5
done
