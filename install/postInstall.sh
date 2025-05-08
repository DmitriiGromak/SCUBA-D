#!/usr/bin/env bash
set -e

pip install torch --index-url https://download.pytorch.org/whl/cu121
pip install torch_geometric
PYG_TORCH_VERSION="2.4.1" 
CUDA_SUFFIX="cu121"
PYG_WHEELS_URL="https://data.pyg.org/whl/torch-${PYG_TORCH_VERSION}+${CUDA_SUFFIX}.html"
pip install pyg_lib torch_sparse torch_scatter torch_cluster torch_spline_conv -f "${PYG_WHEELS_URL}"
conda install -y -c ostrokach dssp