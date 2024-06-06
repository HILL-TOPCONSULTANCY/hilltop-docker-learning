# Dockerfile Instructions
- The instructions in a Dockerfile are executed in order from top to bottom. Each instruction creates a new layer on top of the previous one.
- The layers are committed when instructions like `CMD`, `COPY`, `ADD`, etc. are encountered.
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

## Understanding each Dockerfile Instruction

1.	**FROM instruction**
The `FROM` instruction sets the Base Image for subsequent instructions. As such, a valid Dockerfile must have `FROM` as its first instruction. The image can be any valid image. It is especially easy to start by pulling an image from the Public Repositories.
- `FROM` must be the first non-comment instruction in the Dockerfile.
- `FROM` can appear multiple times within a single Dockerfile in order to create multiple images

- Usage:
```
FROM <image>
```
---

 Or 

```
FROM <image>:<tag>
```
---

Or 

```
FROM <image>@<digest>
```
---

The tag or digest values are optional. If you omit either of them, the builder assumes a latest by default. The builder returns an error if it cannot match the tag value.

2.	**MAINTAINER Instruction**
The `MAINTAINER` instruction allows you to set the Author field of the generated images.

```
MAINTAINER <name>
```
---

3.	**ENV Instruction**
The `ENV` instruction sets the environment variable <key> to the value. This value will be in the environment of all “descendant” Dockerfile commands and can be replaced inline in many as well. The ENV instruction has two forms.

```
ENV <key> <value> 
```
---  

```
ENV <key>=<value> ...
```
---

- The first form, `ENV` <key> <value>, will set a single variable to a value. The entire string after the first space will be treated as the <value> - including characters such as spaces and quotes.
- The second form, `ENV` <key>=<value> ..., allows for multiple variables to be set at one time. Notice that the second form uses the equals sign (=) in the syntax, while the first form does not.
The environment variables set using `ENV` will persist when a container is run from the resulting image. 

You can view the values using docker inspect, and change them using docker run --env <key>=<value>.

4.	**ADD Instruction**
The `ADD` instruction copies files or directories from one location to another.
When using Docker, there are a couple of use cases for `ADD`:

- Copying files from your host machine to the image:

```
ADD hello.txt /some-dir/
```
---

This will copy `hello.txt` from your current directory on the host into `some-dir `in the image.

- Copying directories recursively from your host machine to the image:

```
ADD . /app/
```
---

This will copy the entire current directory into `/app` in the image.

5.	**COPY Instruction**
The `COPY` instruction copies new files or directories from `<src>` and adds them to the filesystem of the container at the path `<dest>`.

The copy command has two forms,

```
COPY <src>... <dest> 
```
---

```
COPY ["<src>",... "<dest>"] // (this form is required for paths containing whitespace)
```
---

Multiple `<src> `resource may be specified but they must be relative to the source directory that is being built (the context of the build).

Each `<src>` may contain wildcards. For example

```
COPY hom* /mydir/        # adds all files starting with "hom" 
```
---

```
COPY hom?.txt /mydir/    # ? is replaced with any single character, e.g., "home.txt"
```
---

The `<dest>` is an absolute path, or a path relative to WORKDIR, into which the source will be copied inside the destination container.

```
COPY test relativeDir/   # adds "test" to `WORKDIR`/relativeDir/ 
```
--- 

```
COPY test /absoluteDir/  # adds "test" to /absoluteDir/
```
---








