# cuda-server

This is an easily installable `cuda-server` for reproductivity. 

You can access it via ssh as a server.

## Prerequirements

* docker
* nvidia-docker

## Build Images

```
git clone https://github.com/moskomule/cuda-server
cd cuda-server
./run.sh PORT_DIGITS IMAGE_NAME CONTAINER_NAME [CUDA_VER]
# for example
# ./run.sh 00 cuda8 moskomule 8
```

## Access to the crated server

You can access to the server `ssh -p 300[PORT_DIGITS] CONTAINER_NAME@localhost`.

Then run `nvidia-smi` to check whether the nvidia-things works correct.

## Next

* `./setup.sh [--dotfile]` installs (my dotfile and) the latest Python with miniconda.
* `sshfs user@hostname:absolute_path_to_dir somewhere` to mount a remote directory.
