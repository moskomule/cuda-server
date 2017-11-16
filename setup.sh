#!/bin/bash

# setup file

cd $HOME

git clone https://github.com/moskomule/.dotfiles.git
cd .dotfiles
bash setup.sh
cd ..

wget -q https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh 
bash miniconda.sh -b -p .miniconda 
rm miniconda.sh

PATH=".miniconda/bin:$PATH"
echo "PATH=.miniconda/bin:$PATH" >> .zshrc
conda install -y numpy scipy matplotlib pandas ipython tqdm \
    && conda clean -ay \
    && pip install --no-cache-dir neovim

