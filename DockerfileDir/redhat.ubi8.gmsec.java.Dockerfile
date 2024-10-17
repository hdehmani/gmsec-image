ARG BASE_REGISTRY=localhost:5000
ARG IMAGE_NAME=gmsec-base-image
ARG IMAGE_TAG=1.0

FROM ${BASE_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}

# Install JDK

# Create a /java directory in the destination OS

ARG JAVA_DIR=/java

WORKDIR ${JAVA_DIR}

# The value of this ARG is supplied through the command: build --build-arg

ARG JAVA_TAR_GZ_FILE_NAME

# Copy the tar archive file to the WORKDIR
# The value of java_tar_gz_file_dir is defined in the command line: --build-context java_tar_gz_file_dir=${JAVA_TAR_GZ_FILE_DIR}
# COPY [--from=<image|stage|context>] <src> ... <dest>
# In our case we are using the COPY --from=context src dest, where context = directory of zip file, src = zip filename and dest = "." which is the /java dir (see above)

COPY --from=java_tar_gz_file_dir ${JAVA_TAR_GZ_FILE_NAME} .

# Extract the tar archive

RUN tar -xvzf ${JAVA_TAR_GZ_FILE_NAME}

# This is the extracted java directory name

ARG JAVA_EXTRACTED_DIRECTORY_NAME

# Define the Java home

ENV JAVA_HOME=${JAVA_DIR}/${JAVA_EXTRACTED_DIRECTORY_NAME}

# Add the JAVA executables to the PATH

ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Remove the tar archive file from the WORKDIR

RUN rm ${JAVA_TAR_GZ_FILE_NAME}

CMD []

# Information
#
# See: https://docs.docker.com/reference/dockerfile/#arg
# In a Dockerfile, use ARG <name>[=<default value>]
# The ARG instruction defines a variable that users can pass at build-time to the builder with
# the docker build command using the --build-arg <varname>=<value> flag.
# If an ARG instruction has a default value and if there is no value passed at build-time, the builder uses the default.
# FROM instructions support variables that are declared by any ARG instructions that occur before the first FROM.
