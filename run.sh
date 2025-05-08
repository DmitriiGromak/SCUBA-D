# !/bin/bash
testlist=run_list.txt

CUDA_VISIBLE_DEVICES=0 python3 inference_par.py \
    --test_list ${testlist} \
    --write_pdbfile \
    --batch_size 1 \
    --sample_from_raw_pdbfile \
    --diff_noising_scale 0.1 \
