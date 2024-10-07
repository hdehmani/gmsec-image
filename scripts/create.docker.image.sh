#!/bin/bash

# Docker image name and tag

IMAGE_NAME=gmsec-base-image
IMAGE_TAG=1.1

# Directory of the GMSEC API tar archive

GMSEC_API_TAR_GZ_FILE_DIR=/mnt/c/MyDevelopment/downloads/GMSEC_API-5.1

# Name of GMSEC API tar archive

GMSEC_API_TAR_GZ_FILE_NAME=GMSEC_API-5.1-RH8_x86_64.tar.gz

# Directory of the JAVA tar archive

JAVA_TAR_GZ_FILE_DIR=/mnt/c/MyDevelopment/downloads/Java

# Name of the JAVA tar archive

JAVA_TAR_GZ_FILE_NAME=OpenJDK11U-jdk_x64_linux_hotspot_11.0.24_8.tar.gz

# Location of Dockerfile

DOCKERFILE_PATH=../DockerfileDir/redhat.ubi8.Dockerfile

# Let's buil the image

#docker build --build-arg GMSEC_API_TAR_GZ_FILE_PATH=${GMSEC_API_TAR_GZ_FILE_PATH} --build-arg JAVA_TAR_GZ_FILE_PATH=${JAVA_TAR_GZ_FILE_PATH} -t ${IMAGE_NAME}:${IMAGE_TAG} -f ${DOCKERFILE_PATH}

# Notes:

# See: https://docs.docker.com/reference/cli/docker/buildx/build/#build-arg
# --build-context=name=VALUE:
# Define additional build context with specified contents. In Dockerfile the context can be accessed when FROM name or --from=name is used
# The value can be a local source directory such as: /mnt/c/MyDevelopment/downloads/GMSEC_API-5.1
# Example:
# docker buildx build --build-context myProjectDir=path/to/project/source .
# In a Dockerfile, you can access the above myProjectDir as follows: COPY --from=myProjectDir myfile.txt /

# IMPORTANT: Use lower case for the name part of the --build-context
# This is the error you get: ERROR: invalid context name GMSEC_API_TAR_GZ_FILE_DIR: invalid reference format: repository name must be lowercase

# --load: Shorthand for --output=type=docker. Will automatically load the single-platform build result to docker images.
# --output=type=docker: 
# --metadata-file some-metadata-file.json:  To output build metadata such as the image digest, pass the --metadata-file flag. 
#                                           The metadata will be written as a JSON object to the specified file. 
#                                           The directory of the specified file must already exist and be writable.
# --build-context
# --build-arg: 
# -f or --file: Name of the Dockerfile (default: PATH/Dockerfile)
#               Specifies the filepath of the Dockerfile to use. 
#               If unspecified, a file named Dockerfile at the root of the build context is used by default.               


#docker buildx build --build-context mygmsecdir=/mnt/c/MyDevelopment/downloads/GMSEC_API-5.1  --build-arg GMSEC_API_TAR_GZ_FILE_PATH=${GMSEC_API_TAR_GZ_FILE_PATH} --build-arg JAVA_TAR_GZ_FILE_PATH=${JAVA_TAR_GZ_FILE_PATH} -t ${IMAGE_NAME}:${IMAGE_TAG} .

docker buildx build --load --metadata-file hassan.metadata.json \
                    --build-context gmsec_api_tar_gz_file_dir=${GMSEC_API_TAR_GZ_FILE_DIR}  \
                    --build-arg GMSEC_API_TAR_GZ_FILE_NAME=${GMSEC_API_TAR_GZ_FILE_NAME} \
                    --build-context java_tar_gz_file_dir=${JAVA_TAR_GZ_FILE_DIR}  \
                    --build-arg JAVA_TAR_GZ_FILE_NAME=${JAVA_TAR_GZ_FILE_NAME} \
                    -f ${DOCKERFILE_PATH} \
                    -t ${IMAGE_NAME}:${IMAGE_TAG} .


#cd ..

#docker build -t hassan_dehmani:v123 .