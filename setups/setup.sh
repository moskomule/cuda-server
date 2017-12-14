#!/bin/bash

# setup file
# bash setup.sh [--dotfiles]

cd $HOME

if [[ $1 == "--dotfiles" ]]; then
    git clone https://github.com/moskomule/.dotfiles.git
    cd .dotfiles
    bash setup.sh
    cd ..
elif [[ $1 == "" ]]; then
    break
else
    echo "don't know ${1}"
    exit 1
fi

# install miniconda
wget -q https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh 
bash miniconda.sh -b -p .miniconda 
rm miniconda.sh
PATH="$HOME/.miniconda/bin:/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
echo "export PATH=$PATH" >> .zshrc
conda install -y numpy scipy matplotlib pandas ipython tqdm \
    && conda clean -ay \
    && pip install --no-cache-dir -r requirements.txt

rm -f requirements.txt
rm setup.sh
