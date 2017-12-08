# cuda-server

This is an easily installable `cuda-server`. You can access it via ssh.

## Prerequirements

* docker
* nvidia-docker

## Usage

```
git clone https://github.com/moskomule/cuda-server
cd cuda-server
./run.sh PORT_DIGITS IMAGE_NAME CONTAINER_NAME [CUDA_VER]
# for example
# ./run.sh 00 cuda8 moskomule 8
```

## After running `run.sh`

You can access to the server `ssh -p 300[PORT_DIGITS] root@localhost`

For example...

### change root password

```
passwd
```

### create user

```
useradd USERNAME --create-home
passwd USERNAME
```

### run setup.sh

This installs the latest Python and, if specified, installs the dotfiles. 

```
bash /opt/setup.sh [--dotfiles]
```

### change default shell

```
chsh -s SHELL_PATH USERNAME
``` 

`SHELL_PATH` is `/bin/bash`, `/bin/zsh`, ...
