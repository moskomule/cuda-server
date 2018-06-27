#!/bin/bash

# This script is build and run cuda included docker server
# constant variables
IMAGE_NAME_BASE="moskomule/dockerfiles:server-cuda"

# functions
help() {
    echo "#$0 PORT_DIGITS CONTAINER_NAME CUDA_VER [DOCKER_OPTIONS]
        e.g. #$0 00 $USER 90 
        PORT_DIGITS: 0~99
        CONTAINER_NAME: any name you like
        CUDA_VER: 90 or 92
        DOCKER_OPTIONS: -v /foo/bar:/foo/bar (currently only supports -v option)
        "
}

if [[ $1 == "-h" ]]; then
    help
    exit 0
fi

# set args
if [[ $1 == "" ]] || [[ $2 == "" ]] || [[ $3 == "" ]]; then
    help
    exit 1
else
    PORT_DIGITS=$1
    CONTAINER_NAME=$2
    case $3 in 
       "90")
           IMAGE_NAME="${IMAGE_NAME_BASE}90"
           ;;
       "92")
           IMAGE_NAME="${IMAGE_NAME_BASE}92"
           ;;
       *)
           echo "no such cuda version $3" 
           exit 1
           ;;
    esac
fi

# remove processed args
shift 3

# set optional args
DOCKER_OPTIONS=""
for OPT in "$@"; do

    case $OPT in
        "-v"|"--volume")
            DOCKER_OPTIONS="$DOCKER_OPTIONS $1 $2"
            shift 2
            ;;
    esac
done

# build
echo "building..."
nvidia-docker build --build-arg image_name=${IMAGE_NAME} --build-arg user_name=$CONTAINER_NAME -t "${CONTAINER_NAME}_image" .

echo "running..."
docker run --runtime=nvidia -d -P \
    --ipc=host \
    --privileged \
    -p 300$PORT_DIGITS:22 \
    -p 388$PORT_DIGITS:8888 \
    -p 366$PORT_DIGITS:6006 \
    --name $CONTAINER_NAME \
    --restart=always \
    $DOCKER_OPTIONS \
    "${CONTAINER_NAME}_image"

echo "finished

What's next?

ssh -p 300$PORT_DIGITS ${CONTAINER_NAME}@localhost
...# default password is Dokcer!
after login
$ nvidia-smi # check if nvidia-smi works
"
