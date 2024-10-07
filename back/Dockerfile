ARG BASE_REGISTRY=localhost:5000
ARG IMAGE_NAME=redhat/ubi8
ARG IMAGE_TAG=8.10

FROM ${BASE_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}

# Install GMSEC API

# Create a /gmsec directory in the destination OS

WORKDIR /gmsec

ENV GMSEC_HOME=/gmsec/GMSEC_API
ENV LD_LIBRARY_PATH=${GMSEC_HOME}/bin:${LD_LIBRARY_PATH}

RUN echo "Start Hello Hassan0"
RUN echo ${GMSEC_HOME}
RUN echo "End Hello Hassan0"

# The value of this ARG is supplied through the command: build --build-arg

ARG GMSEC_API_TAR_GZ_FILE_NAME

RUN echo "Start Hello Hassan1"
RUN echo ${GMSEC_API_TAR_GZ_FILE_NAME}
RUN echo "End Hello Hassan1"

# Copy the tar archive file to the WORKDIR
COPY README.md .


#WORKDIR /mnt/c/MyDevelopment/downloads/deleteDir

#RUN echo pwd
#COPY --from=GMSEC_API_TAR_GZ_FILE_DIR ${GMSEC_API_TAR_GZ_FILE_NAME} .
COPY --from=gmsec_api_tar_gz_file_dir ${GMSEC_API_TAR_GZ_FILE_NAME} .
#COPY ${GMSEC_API_TAR_GZ_FILE_PATH} .

#RUN export GMSEC_API_TAR_GZ_FILE_NAME=$(basename ${GMSEC_API_TAR_GZ_FILE_PATH})

#RUN echo "Start Hello Hassan"
#RUN echo ${GMSEC_API_TAR_GZ_FILE_NAME}
#RUN echo "End Hello Hassan"

#RUN tar -xvzf ${GMSEC_API_TAR_GZ_FILE_NAME}

ENV PATH="${GMSEC_HOME}/bin:${PATH}"

# Install JDK

#WORKDIR /java

#ENV JAVA_HOME=/java/jdk-11.0.24+8

#ENV PATH="${JAVA_HOME}/bin:${PATH}"

#ARG JDK_FILE=OpenJDK11U-jdk_x64_linux_hotspot_11.0.24_8.tar.gz

#COPY java/${JDK_FILE} .

#RUN tar -xvzf ${JDK_FILE}

#ENV CLASSPATH=$GMSEC_HOME/bin/gmsecapi.jar

CMD ["ls"]

# Information
#
# See: https://docs.docker.com/reference/dockerfile/#arg
# In a Dockerfile, use ARG <name>[=<default value>]
# The ARG instruction defines a variable that users can pass at build-time to the builder with
# the docker build command using the --build-arg <varname>=<value> flag.
# If an ARG instruction has a default value and if there is no value passed at build-time, the builder uses the default.
# FROM instructions support variables that are declared by any ARG instructions that occur before the first FROM.
