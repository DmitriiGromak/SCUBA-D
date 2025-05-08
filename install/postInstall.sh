#!/usr/bin/env bash
set -e

# Install PyTorch from the specified index URL
pip install torch --index-url https://download.pytorch.org/whl/cu121

# Get the installed PyTorch version
PYTORCH_VERSION=$(python -c "import torch; print(torch.__version__)")

# Extract major and minor version, set PYG_TORCH_VERSION to major.minor.0
MAJOR_MINOR=$(echo "$PYTORCH_VERSION" | cut -d. -f1,2)
PYG_TORCH_VERSION="${MAJOR_MINOR}.0"

# Determine CUDA suffix based on whether CUDA is available
CUDA_AVAILABLE=$(python -c "import torch; print(torch.cuda.is_available())")
if [ "$CUDA_AVAILABLE" = "True" ]; then
    CUDA_VERSION=$(python -c "import torch; print(torch.version.cuda)")
    CUDA_SUFFIX="cu${CUDA_VERSION//./}"
else
    CUDA_SUFFIX="cpu"
fi

# Construct the wheels URL for PyTorch Geometric dependencies
PYG_WHEELS_URL="https://data.pyg.org/whl/torch-${PYG_TORCH_VERSION}+${CUDA_SUFFIX}.html"

# Install PyTorch Geometric dependencies using the constructed wheels URL
pip install pyg_lib torch_scatter torch_sparse torch_cluster torch_spline_conv -f "${PYG_WHEELS_URL}"

# Install torch_geometric
pip install torch_geometric

# Install dssp using conda
conda install -y -c ostrokach dssp