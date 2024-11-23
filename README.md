# Introduction to Docker

## What is Docker?

Docker is a commercial containerization platform and runtime that helps developers build, deploy, and run containers. It uses a client-server architecture with simple commands and automation through a single API.

- Docker also provides a toolkit that is commonly used to package applications into immutable container images by writing a `Dockerfile` and then running the appropriate commands to build the image using the Docker server. 
- Developers can create containers without Docker but the Docker platform makes it easier to do so. 
- These container images can then be deployed and run on any platform that supports containers, such as `Kubernetes`, `Docker Swarm`, `Mesos`, or `HashiCorp Nomad`.
- While Docker provides an efficient way to package and distribute containerized applications, running and managing containers at scale is a challenge with Docker alone. 
- Coordinating and scheduling containers across multiple servers/clusters, upgrading or deploying applications with zero downtime, and monitoring the health of containers are just some of the considerations that need to be made.



## Docker Architecture

Let’s understand how Docker as a software was designed. The engine consists of three major components:

-  **Docker Daemon**: The daemon (`dockerd`) is a process that keeps running in the background and waits for commands from the client. The daemon is capable of managing various Docker objects.
- **Docker Client**: The client (`docker`) is a command-line interface program mostly responsible for transporting commands issued by users.
- **REST API**: The REST API acts as a bridge between the daemon and the client. Any command issued using the client passes through the API to finally reach the daemon.

Docker uses a client-server architecture. The Docker client talks to the Docker daemon, which does the heavy lifting of building, running, and distributing your Docker containers.
Let’s look happens when you run the docker run hello-world command
![Docker Architecture](docker-architecture.png)

This image is a slightly modified version of the one found in the official docs. The events that occur when you execute the command are as follows:
- - You execute docker run hello-world command where hello-world is the name of an image.
- -	Docker client reaches out to the daemon, tells it to get the hello-world image and run a container from that.
-  - Docker daemon looks for the image within your local repository and realizes that it's not there, resulting in the Unable to find image 'hello-world:latest' locally that's printed on your terminal.
- - The daemon then reaches out to the default public registry which is Docker Hub and pulls in the latest copy of the hello-world image, indicated by the latest: Pulling from library/hello-world line in your terminal.
- - Docker daemon then creates a new container from the freshly pulled image.
- - Finally, Docker daemon runs the container created using the hello-world image outputting the wall of text on your terminal.

## Docker Registry

An image registry is a centralized place where you can upload your images and can also download images created by others. Docker Hub is the default public registry for Docker. Another very popular image registry is Quay by Red Hat.
![Docker Registry](docker-registry.png)

You can share any number of public images on Docker Hub for free. People around the world will be able to download them and use them freely. 

## Creating Dockerhub  Account

### Sign Up with Email Address
- Go to the Docker sign-up page https://registry.hub.docker.com/signup.
- Enter a unique, valid email address.
- Choose a username (`your Docker ID`) between 4 and 30 characters, containing only numbers and lowercase letters.
- Set a password (at least 9 characters long).
- Click “Sign Up.”
- Docker will send a verification email to the provided address. Verify your email to complete the registration process1.

### Sign Up with Google or GitHub
- Ensure your email address is verified with your social provider (Google or GitHub).
- Go to the Docker sign-up page https://registry.hub.docker.com/signup .
- Select your preferred social provider (Google or GitHub).
- Authorize Docker to access your social account information.
- Choose a username (`your Docker ID`).
- Click “Sign Up.”

### Sign In
After registering and verifying your Docker ID email address, you can sign in:
-  Use your email address (or username) and password.
- Alternatively, sign in with your social provider (Google or GitHub).
- You can also sign in through the CLI using the docker login command1.

# **1. Introduction**
---
# **1. Understanding the Basics**
### **What is Virtualization?**
- **Definition**: Virtualization involves running multiple virtual machines (VMs) on a single physical machine. Each VM contains its own operating system, libraries, and applications.
- **Benefits**: Resource sharing, isolation, and flexibility.
- **Drawbacks**:
  - Heavyweight: Each VM includes a full OS, consuming more resources.
  - Slower startup: Booting a VM can take several minutes.

#### **What is Containerization?**
- **Definition**: Containerization is a lightweight alternative to virtualization. It allows you to run multiple applications isolated from one another while sharing the host system’s kernel.
- **How it Works**:
  - Containers package an application and its dependencies into a single unit.
  - They rely on the host OS, making them lightweight and fast.
- **Benefits**:
  - Efficient use of resources.
  - Faster startup times (seconds).
  - Portability: "Write once, run anywhere."

#### **Why Use Containers?**
- Solve the "It works on my machine" problem by ensuring consistency across development, testing, and production environments.
- Enable microservices architecture, where each service runs in its own container.

#### **What is Docker?**
- **Definition**: Docker is a platform that simplifies containerization. It helps developers package applications into standardized units (containers).
- **Key Components**:
  - **Docker Images**: Blueprints for containers.
  - **Docker Containers**: Running instances of images.
  - **Docker Hub**: A repository to share Docker images.

---
## INTRODUCTION TO DOCKER:
Docker solves several problems related to software development, deployment, and scalability by providing a lightweight, 
consistent, and portable containerization platform. Below is a detailed explanation of the problems Docker addresses, 
supported by real-world scenarios

---

### 1. "It Works on My Machine" Problem:
#### Problem:
- Applications often behave differently across environments (development, testing, production) due to discrepancies in 
software versions, dependencies, or configurations.

#### How Docker Solves It:
- Docker containers encapsulate the application along with its dependencies, environment variables, and libraries, 
ensuring consistency across all environments.

#### Scenario:
- A developer builds an application on their local machine using Python 3.9.
- The QA team tests the same application in an environment running Python 3.6, causing crashes due to version incompatibilities.
- With Docker: The developer creates a container that includes Python 3.9 and all dependencies. The same container is used in QA 
and production, eliminating environment-specific issues.

---

### 2. Dependency Management:
#### Problem:
- Different applications may require conflicting versions of the same dependency, leading to compatibility issues when deployed 
on the same server.

#### How Docker Solves It:
- Containers isolate dependencies for each application, ensuring that multiple applications can run independently on the 
same host without interference.

#### Scenario:
- A server hosts two applications:
  - App A needs `libX v1.0`.
  - App B needs `libX v2.0`.
- Installing both versions of `libX` causes conflicts.
- With Docker: App A and App B are packaged in separate containers with their respective dependencies, resolving the conflict.

---

### 3. Resource Inefficiency with Virtual Machines:
 Problem:
- Virtual Machines (VMs) are resource-intensive because they include a full operating system (OS) for each instance,
 even if the application is lightweight.

How Docker Solves It:
- Docker containers share the host OS kernel, making them lightweight and enabling the deployment of many containers
 on the same hardware.

Scenario:
- A company uses VMs to host microservices:
  - Each VM uses 2 GB of RAM and 20 GB of disk space for its OS, even if the microservice needs only 200 MB.
-With Docker: Containers use significantly less memory and storage, enabling the deployment of more microservices 
on the same hardware,reducing costs.

---

### 4. Complex CI/CD Pipelines:
 Problem:
- Continuous Integration/Continuous Deployment (CI/CD) pipelines are often complex because different build 
  environments need to be managed for various stages like development, testing, and production.

#### How Docker Solves It:
- Docker standardizes environments with Docker images, making it easy to replicate the same environment for testing, 
  staging, and production.

#### Scenario:
- A CI/CD pipeline fails because the testing server lacks a required library installed on the developer’s machine.
- With Docker: The developer creates a Docker image with all required libraries. The same image is used in testing, 
  staging, and production, ensuring consistency.

---

### 5. Scalability Challenges:
#### Problem:
- Scaling applications often requires significant time and effort to configure additional servers and replicate environments.

#### How Docker Solves It:
- Docker makes it easy to replicate containers across multiple servers, enabling quick scaling.

#### Scenario:
- A retail website experiences a traffic surge during a sale. The team needs to quickly add new servers to handle the load.
- With Docker: The application container is deployed across multiple servers or orchestrated with tools like 
 Kubernetes to auto-scale based on demand.

---

### 6. Portability Issues:
#### Problem:
- Applications deployed on one platform (e.g., a specific Linux distribution) might not run on another due to differences 
   in underlying infrastructure.

#### How Docker Solves It:
- Docker ensures that containers run consistently on any system with Docker installed, whether it's on-premises, 
  in the cloud, or on a developer’s laptop.

#### Scenario:
- A company develops an application on Ubuntu but needs to deploy it to a cloud provider using Red Hat Enterprise Linux.
- With Docker: The application container runs on both systems without modification.

---

### 7. Complex Application Deployment:
#### Problem:
- Deploying multi-service applications involves managing dependencies, networking, and configurations for each service, 
which can be error-prone and time-consuming.

#### How Docker Solves It:
- Docker Compose simplifies the deployment of multi-container applications by defining all services, networks, and 
configurations in a single `docker-compose.yml` file.

#### Scenario:
- A web application has:
  - A Node.js backend.
  - A React frontend.
  - A MongoDB database.
- Without Docker: Each service must be installed, configured, and managed separately.
- With Docker: A single `docker-compose.yml` file specifies the configuration, and `docker-compose up` starts all services 
  with one command.

---

### 8. Vendor Lock-In:
#### Problem:
- Applications tightly coupled with specific infrastructure or tools (e.g., AWS-specific features) are difficult to m
igrate to other platforms.

#### How Docker Solves It:
- Containers abstract the application from the underlying infrastructure, allowing easy migration across platforms.

#### Scenario:
- A company wants to migrate from AWS to Azure.
- Without Docker: Significant reconfiguration is required to adapt to Azure’s environment.
- With Docker: Containers run seamlessly on Azure, as they are independent of the underlying infrastructure.

---

### 9. Simplifying Collaboration
#### Problem:
- Development teams often face challenges when onboarding new members or sharing development environments.

#### How Docker Solves It:
- Developers can share the same Docker image, ensuring everyone works in an identical environment.

#### Scenario:
- A new developer joins a project and spends days setting up their local environment.
- With Docker: The new developer pulls the project’s Docker image and starts contributing within minutes.

---

### 10. Security Isolation:
Problem:
- Running multiple applications on the same server can lead to security vulnerabilities if one application is compromised.

#### How Docker Solves It:
- Containers provide process and network isolation, reducing the attack surface between applications.

#### Scenario:
- A compromised application in a shared environment could access sensitive data from another application.
- With Docker: Containers isolate applications, preventing lateral movement of threats.

---


### **3. Getting Started with Docker**
#### **Installing Docker**
Follow installation steps for your operating system from the [Docker Docs](https://docs.docker.com/get-docker/).

## DOCKER INSTALLATION

Make sure the following are installed on your EC2 instance or local machine:

- **Docker**
- **Node.js** (for local development)
  
## Steps to Set Up and Run the Application

### 1. Install Docker on Your EC2 Instance

First, install Docker on your EC2 instance if it is not already installed:

```bash
#!/bin/bash
sudo yum update -y
sudo yum -y install docker
sudo service docker start
sudo systemctl enable docker.service 
sudo usermod -a -G docker ec2-user 
sudo chmod 666 /var/run/docker.sock
```

Log out and back in again to apply the Docker group changes.

Verify Docker is installed by running:

```bash
docker --version
```

---

### **4. Docker Basics**
#### **Running Your First Container**
Start with a test container:
```bash
docker run hello-world
```
- This downloads the `hello-world` image, creates a container, and runs it.

---

### **6. Writing a Dockerfile**
We’ll rebuild the Hilltop Consultancy App image using a `Dockerfile`.

#### **Step 1: Create a Dockerfile**
A **Dockerfile** is a text file containing a series of instructions used to define and build a Docker image. It acts as a blueprint for creating containers, specifying what is included in the image, 
such as the base image, application code, libraries, environment variables, and commands to run when the container starts.

---

### **Key Features of a Dockerfile**
- **Declarative Format**: Instructions in a Dockerfile specify "what to do," and Docker executes them to create an image.
- **Layered Build Process**: Each instruction creates a new layer in the image, making builds efficient as unchanged layers are cached.

---

### **Components of a Dockerfile**
Here’s a breakdown of common instructions in a Dockerfile:

1. **`FROM`**:
   - Specifies the base image to use (e.g., an operating system or runtime environment).
     ```dockerfile
     FROM node:10-alpine
     ```
   - Here, `node:18-alpine` is a lightweight Node.js runtime image.
  
     
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app


2. **`WORKDIR`**:
   - Sets the working directory inside the container.
     ```dockerfile
     WORKDIR /home/node/app
     ```

3. **`COPY`**:
   - Copies files from the host machine to the image.
     ```dockerfile
     package*.json ./
     ```

4. **`RUN`**:
   - Executes commands during the build process (e.g., installing dependencies).
   - Example:
     ```dockerfile
     RUN npm install
     ```

5. **`EXPOSE`**:
   - Declares the port the container listens on at runtime (for documentation purposes).
     ```dockerfile
     EXPOSE 8080
     ```

6. **`CMD`**:
   - Specifies the command to run when the container starts.
     ```dockerfile
     CMD ["npm", "start"]
     ```

7. **`ENV`**:
   - Sets environment variables in the container.
     ```dockerfile
     ENV NODE_ENV=production
     ```

8. **`LABEL`**:
   - Adds metadata to the image.
     ```dockerfile
     LABEL maintainer="htconsult.dk"
     ```
---
## EXAMPLE OF DOCKERFILE
1. Navigate to the app directory.
2. Create a file named `Dockerfile` with the following content:
   ```dockerfile
   # Use the official Node.js image as the base
   FROM node:18-alpine

   # Set the working directory in the container
   WORKDIR /app

   # Copy package.json and install dependencies
   COPY package*.json ./
   RUN npm install

   # Copy the rest of the application code
   COPY . .

   # Expose the app's port
   EXPOSE 8080

   # Command to run the app
   CMD ["npm", "start"]
   ```

### Steps:

1. **Build the Docker Image**  
   In the root of your project directory (where the `Dockerfile` is located), run:
   ```bash
   docker build -t hilltopconsultancy/docker-learning:v1 .
   ```
   This command:
   - Names your image `hilltopconsultancy/my-app`.
   - Tags it with version `1.0`.

---

2. **Test the Docker Image (Optional)**  
   Run the image locally to ensure it works:
   ```bash
   docker run -p 2020:8080 hilltopconsultancy/docker-learning:v1
   ```
   Visit `http://localhost:8080` in your browser to confirm it's functioning.

---

3. **Log In to Docker Hub**  
   Log in to your Docker Hub account:
   ```bash
   docker login
   ```
   Provide your username (`hilltopconsultancy`) and password when prompted.

---

4. **Push the Image to Docker Hub**  
   Push the built image to your Docker Hub repository:
   ```bash
   docker push hilltopconsultancy/docker-learning:v1
   ```

---

5. **Verify on Docker Hub**  
   Go to [Docker Hub](https://hub.docker.com) and log in. Navigate to your `hilltopconsultancy` account to confirm the `my-app` repository contains the pushed image.

---

6. **Pull the Image (Optional)**  
   On another system or after removing the local image, pull the image to confirm it works:
   ```bash
   docker pull hilltopconsultancy/my-app:1.0
   ```
---

### **Dockerfile**  
A **Dockerfile** is a text file containing instructions to build a Docker image. It specifies all the steps, such as selecting a base image, installing dependencies, copying files, and defining how the application runs. 

**Example**:
```dockerfile
# Start with a Node.js base image
FROM node:18-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the application code
COPY . .

# Expose the application's port
EXPOSE 8080

# Run the application
CMD ["node", "app.js"]
```

---

### **Docker Image**  
A **Docker image** is a lightweight, standalone, and executable software package that contains everything needed to run an application,
including the code, runtime, libraries, and dependencies. Think of it as a snapshot of your application at a specific point in time.

**Key Points**:
- Built from a Dockerfile.
- Immutable (cannot be changed once created).
- Used to create Docker containers.

---

### **Docker Container**  
A **Docker container** is a running instance of a Docker image. It is an isolated environment where your application runs, behaving like a lightweight virtual machine but sharing the host system's kernel.

**Key Points**:
- Containers are ephemeral (short-lived), but their state can be preserved using volumes or by committing changes to a new image.
- Multiple containers can run from the same image.

**Example**:
```bash
docker run -p 8080:8080 my-app
```
This command runs a container from the `my-app` image and maps port `8080` of the container to port `8080` on the host.

---

### **Docker Hub**  
**Docker Hub** is a public registry for Docker images. It allows users to share, store, and distribute Docker images. 
You can pull official or community-contributed images or push your own images to Docker Hub for reuse or distribution.

**Key Points**:
- Free and paid tiers are available.
- Common images: `node`, `nginx`, `ubuntu`, etc.

**Example**:
```bash
# Pull an official Node.js image from Docker Hub
docker pull node:18-alpine
```

---

### **Docker Repository**  
A **Docker repository** is a collection of related Docker images, often different versions of the same application or software.
For example, a `node` repository may contain images for different versions of Node.js (e.g., `18-alpine`, `16-buster`).

**Key Points**:
- A repository can be public or private.
- Exists on platforms like Docker Hub, AWS ECR, GitHub Container Registry, etc.

**Example**:
- **Public Repo**: `docker.io/library/node` (default location for Docker Hub images).
- **Private Repo**: `my-org/my-private-image`.
---

## Docker Commands

### Frequently Used Docker Commands and Explanations

1. **`docker --version`**
   - **Explanation**: Displays the installed version of Docker on the system.

2. **`docker pull <image>`**
   - **Explanation**: Downloads a Docker image from Docker Hub or another registry to your local machine.

3. **`docker build -t <image_name> .`**
   - **Explanation**: Builds a Docker image from a `Dockerfile` in the current directory and tags it with a name.

4. **`docker run -d -p <host_port>:<container_port> <image_name>`**
   - **Explanation**: Runs a Docker container in detached mode, mapping the container’s port to the host machine’s port.

5. **`docker ps`**
   - **Explanation**: Lists running containers.

6. **`docker ps -a`**
   - **Explanation**: Lists all containers, including stopped ones.

7. **`docker stop <container_id>`**
   - **Explanation**: Stops a running container using its container ID.

8. **`docker start <container_id>`**
   - **Explanation**: Starts a stopped container using its container ID.

9. **`docker rm <container_id>`**
   - **Explanation**: Removes a stopped container.

10. **`docker rmi <image_id>`**
    - **Explanation**: Deletes a Docker image from the local machine.

11. **`docker exec -it <container_id> /bin/bash`**
    - **Explanation**: Starts an interactive terminal inside a running container.

12. **`docker logs <container_id>`**
    - **Explanation**: Shows the logs of a running or stopped container.

13. **`docker-compose up`**
    - **Explanation**: Starts all services defined in a `docker-compose.yml` file.

14. **`docker-compose down`**
    - **Explanation**: Stops and removes all containers, networks, and volumes created by `docker-compose up`.

---
