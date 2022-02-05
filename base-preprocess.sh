#!/bin/bash

SRC=en
TRG=ja

TRAIN_DIR=./KFTT-corpus/spm
VALID_DIR=./corpus
TEST_DIR=./corpus
SRC_DICT=${HOME}/PBL/JParaCrawl-pretrain-model-enja/base/dict.en.txt
TRG_DICT=${HOME}/PBL/JParaCrawl-pretrain-model-enja/base/dict.ja.txt

# ============
# preprocess
# ===========
fairseq-preprocess \
    --destdir KFTT-bin \
    --source-lang $SRC \
    --target-lang $TRG \
    --trainpref $TRAIN_DIR/train \
    --validpref $VALID_DIR/valid \
    --testpref $TEST_DIR/test \
    --srcdict $SRC_DICT \
    --tgtdict $TRG_DICT \
    --workers `nproc` \
    
