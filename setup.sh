#!/bin/bash

# setup file
# bash setup.sh [--dotfile]

cd $HOME

if [[ $1 == "--dotfile" ]]; then
    git clone https://github.com/moskomule/.dotfiles.git
    cd .dotfiles
    bash setup.sh
    cd ..
fi

# install miniconda
wget -q https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh 
bash miniconda.sh -b -p .miniconda 
rm miniconda.sh
export PATH="$HOME/.miniconda/bin:.miniconda/bin:/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
echo "export PATH=$PATH" >> .zshrc
conda install -y numpy scipy matplotlib pandas ipython tqdm \
    && conda clean -ay \
    && pip install --no-cache-dir neovim

