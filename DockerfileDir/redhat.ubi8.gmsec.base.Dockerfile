ARG BASE_REGISTRY=localhost:5000
ARG IMAGE_NAME=redhat/ubi8
ARG IMAGE_TAG=8.10

FROM ${BASE_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}

# Install GMSEC API

# Create a /gmsec directory in the destination OS

WORKDIR /gmsec

# Define the GMSEC API home
ENV GMSEC_HOME=/gmsec/GMSEC_API
ENV LD_LIBRARY_PATH=${GMSEC_HOME}/bin:${LD_LIBRARY_PATH}

# The value of this ARG is supplied through the command: build --build-arg

ARG GMSEC_API_TAR_GZ_FILE_NAME

# Copy the tar archive file to the WORKDIR
# The value of gmsec_api_tar_gz_file_dir is defined in the command line: --build-context gmsec_api_tar_gz_file_dir=${GMSEC_API_TAR_GZ_FILE_DIR}
# COPY [--from=<image|stage|context>] <src> ... <dest>
# In our case we are using the COPY --from=context src dest, where context = directory of zip file, src = zip filename and dest = "." which is the /gmsec dir (see above)

COPY --from=gmsec_api_tar_gz_file_dir ${GMSEC_API_TAR_GZ_FILE_NAME} .

# Extract the tar archive

RUN tar -xvzf ${GMSEC_API_TAR_GZ_FILE_NAME}

# Add the GMSEC API executables to the PATH

ENV PATH="${GMSEC_HOME}/bin:${PATH}"

# Remove the tar archive file from the WORKDIR

RUN rm ${GMSEC_API_TAR_GZ_FILE_NAME}

# Remove not needed directories (to save space): docs and examples

RUN rm -r ${GMSEC_HOME}/docs

RUN rm -r ${GMSEC_HOME}/examples

CMD []

# Information
#
# See: https://docs.docker.com/reference/dockerfile/#arg
# In a Dockerfile, use ARG <name>[=<default value>]
# The ARG instruction defines a variable that users can pass at build-time to the builder with
# the docker build command using the --build-arg <varname>=<value> flag.
# If an ARG instruction has a default value and if there is no value passed at build-time, the builder uses the default.
# FROM instructions support variables that are declared by any ARG instructions that occur before the first FROM.
