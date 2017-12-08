#!/bin/bash

# This script is build and run cuda included docker server
if [[ $1 == "-h" ]]; then
    echo "#$0 PORT_DIGITS IMAGE_NAME CONTAINER_NAME [CUDA_VER]
        e.g. #$0 00 cuda8 $USER 8
        PORT_DIGITS: 0~99
        CUDA_VER: 8 or 9"
    exit 0
fi

# set args
if [[ $1 == "" ]] || [[ $2 == "" ]] || [[ $3 == "" ]]; then
    echo "see help($0 -h)"
    exit 1
else
    PORT_DIGITS=$1
    IMAGE_NAME=$2
    CONTAINER_NAME=$3
fi

# set optional arg
case $4 in 
   ""|"8")
       CUDA_VER="8.0-cudnn7-devel-ubuntu16.04"
       ;;
   "9")
       CUDA_VER="9.0-cudnn7-devel-ubuntu16.04"
       ;;
   *)
       echo "no such cuda version $4" 
       exit 1
       ;;
esac


# build
echo "building..."
nvidia-docker build  --build-arg version=$CUDA_VER -t $IMAGE_NAME .

echo "running..."
nvidia-docker run -d -P \
    --privileged \
    -p 300$PORT_DIGITS:22 \
    -p 388$PORT_DIGITS:8888 \
    -p 366$PORT_DIGITS:6006 \
    -v $(pwd)/volume/$CONTAINER_NAME:/data \
    --name $CONTAINER_NAME \
    $IMAGE_NAME

echo "finished

What's next?

ssh -p 300$PORT_DIGITS root@localhost
...# default password is Dokcer!
after login
$ nvidia-smi # check if nvidia-smi works
$ passwd # change root password
$ useradd USERNAME --create-home # create user
$ passwd USERNAME
$ bash /opt/setup.sh
"
