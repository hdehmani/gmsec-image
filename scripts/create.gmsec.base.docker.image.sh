#!/bin/bash

# Docker image name and tag
REGISTRY_HOST_NAME=localhost
REGISTRY_HOST_PORT=5000
BASE_REGISTRY=${REGISTRY_HOST_NAME}:${REGISTRY_HOST_PORT}
IMAGE_NAME=gmsec-base-image
IMAGE_TAG=1.0

# Website: https://www.lifewire.com/tar-file-2622386#:~:text=A%20TAR%20file%20is%20a%20Consolidated%20Unix%20Archive%20format%20file.#:~:text=A%20TAR%20file%20is%20a%20Consolidated%20Unix%20Archive%20format%20file.

# TAR file = Tape Archive = Tarball = has TAR file extension
# TAR file format is used to store multiple files in one single file
# TAR file format is common in Linux and Unix systems, but only for storing data, not compressing it
# TAR files are often compressed after being created, but those become TGZ files, using the TGZ, TAR.GZ, or GZ extension.

# Directory of the GMSEC API compressed tar file

GMSEC_API_TAR_GZ_FILE_DIR=/mnt/c/MyDevelopment/downloads/GMSEC_API-5.1

# Name of GMSEC API tar archive

GMSEC_API_TAR_GZ_FILE_NAME=GMSEC_API-5.1-RH8_x86_64.tar.gz

# Location of Dockerfile

DOCKERFILE_PATH=../DockerfileDir/redhat.ubi8.gmsec.base.Dockerfile

# Name of metadata file

METADATA_FILE_NAME=${DOCKERFILE_PATH}.metadata.json

# Let's buil the image

#docker build --build-arg GMSEC_API_TAR_GZ_FILE_PATH=${GMSEC_API_TAR_GZ_FILE_PATH} --build-arg JAVA_TAR_GZ_FILE_PATH=${JAVA_TAR_GZ_FILE_PATH} -t ${IMAGE_NAME}:${IMAGE_TAG} -f ${DOCKERFILE_PATH}

# Notes:

###########################################################################################
# The docker buildx build command starts a build using BuildKit.
# See: https://docs.docker.com/reference/cli/docker/buildx/build/
###########################################################################################
# See: https://docs.docker.com/reference/cli/docker/buildx/build/#build-arg
# You can use ENV instructions in a Dockerfile to define variable values. These values persist in the built image.
# Often persistence isn't what you want. Users want to specify variables differently depending on which host they build an image on.
# The ARG instruction lets Dockerfile authors define values that users can set at build-time using the --build-arg flag
# --build-arg: Set build-time variables
# Example: --build-arg GMSEC_API_TAR_GZ_FILE_NAME=GMSEC_API-5.1-RH8_x86_64.tar.gz
###########################################################################################
# See: https://docs.docker.com/reference/cli/docker/buildx/build/#build-context
# --build-context: Additional build contexts (e.g., name=path)
# --build-context=name=VALUE:
# Define additional build context with specified contents. In Dockerfile the context can be accessed when FROM name or --from=name is used
# The value can be a local source directory such as: /mnt/c/MyDevelopment/downloads/GMSEC_API-5.1
# Example:
# docker buildx build --build-context myProjectDir=path/to/project/source .
# In a Dockerfile, you can access the above myProjectDir as follows: COPY --from=myProjectDir myfile.txt /
# IMPORTANT: Use lower case for the name part of the --build-context
# This is the error you get: ERROR: invalid context name GMSEC_API_TAR_GZ_FILE_DIR: invalid reference format: repository name must be lowercase
###########################################################################################
# See: https://docs.docker.com/reference/cli/docker/buildx/build/#output
# -o, --output=[PATH,-,type=TYPE[,KEY=VALUE]
# Sets the export action for the build result. The default output, when using the docker build driver, is a container image exported to the local image store. 
# The --output flag makes this step configurable allows export of results directly to the client's filesystem, an OCI image tarball, a registry, and more.
# Buildx with docker driver only supports the local, tarball, and image exporters. The docker-container driver supports all exporters.
# If you only specify a filepath as the argument to --output, Buildx uses the local exporter. 
# If the value is -, Buildx uses the tar exporter and writes the output to stdout.

# --load: Shorthand for --output type=docker. Will automatically load the single-platform build result to the local docker image store.
# --output type=docker: The docker export type writes the single-platform result image as a Docker image specification tarball on the client. 
#                       Tarballs created by this exporter are also OCI compatible.
###########################################################################################
# --metadata-file some-metadata-file.json:  To output build metadata such as the image digest, pass the --metadata-file flag. 
#                                           The metadata will be written as a JSON object to the specified file. 
#                                           The directory of the specified file must already exist and be writable.
###########################################################################################
# -f or --file: Name of the Dockerfile (default: PATH/Dockerfile)
#               Specifies the filepath of the Dockerfile to use. 
#               If unspecified, a file named Dockerfile at the root of the build context is used by default.               
###########################################################################################

#docker buildx build --output type=docker \
docker buildx build --output type=registry \
                    --metadata-file ${METADATA_FILE_NAME} \
                    --build-context gmsec_api_tar_gz_file_dir=${GMSEC_API_TAR_GZ_FILE_DIR}  \
                    --build-arg GMSEC_API_TAR_GZ_FILE_NAME=${GMSEC_API_TAR_GZ_FILE_NAME} \
                    -f ${DOCKERFILE_PATH} \
                    -t ${BASE_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} .