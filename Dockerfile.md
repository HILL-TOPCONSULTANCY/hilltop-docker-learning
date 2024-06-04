# Dockerfile Instructions
- The instructions in a Dockerfile are executed in order from top to bottom. Each instruction creates a new layer on top of the previous one.
- The layers are committed when instructions like CMD, COPY, ADD, etc. are encountered.
- The FROM instruction initializes the base image and should be the first instruction in any Dockerfile.
- The order of instructions matters and determines the step-by-step build process of the image.

## Popular Dockerfile Instructions

- **FROM:** Sets the base image.
- **MAINTAINER:** Author/Maintainer information.
- **ENV:** Sets environment variable.
- **ADD:** Copies files to the image.
- **COPY:** Copies files or directories to the image
- **RUN:** Execute commands in a new layer
- **ENTRYPOINT:** Sets the primary command to be executed at container startup
- **CMD:** Default command to execute at container startup
- **USER:** Sets the user to use when running the image
- **WORKDIR:** Sets the working directory for future commands
- **ARG:** Allows ARG instructions to define build-time variables
- **ONBUILD:** Adds a trigger instruction to be executed when the image is built
- **STOPSIGNAL:** Sets the default signal to stop a container
- **HEALTHCHECK:** Set health check instructions
- **EXPOSE:** Exposes a port for users of the image
- **VOLUME:** Creates a mount point within the image