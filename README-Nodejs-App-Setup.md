## Creating NodeJS application
### Prequisite 
- Amazon Linux EC2 instance
- Docker installed on the EC2 instance
- Node.js and npm installed on the instance
- A Docker hub account

### Installing Docker on the  Amazon Linux server
Run the following commands to install the docker Daemon on the Amazon  linux instance

```
#!/bin/bash
sudo yum update -y
sudo yum -y install docker
sudo service docker start
sudo systemctl enable docker.service
sudo usermod -a -G docker ec2-user
sudo chmod 666  /var/run/docker.sock
```
---

###   Installing  Node.js application dependencies

To create an image, we will first need to make our application files, which we can then copy to the container. These files will include our application’s static content, code, and dependencies.
Create a directory for your project in your non-root user’s home directory. The directory in this example named `node_project`.

```
mkdir node_project
```
Navigate to this directory
```
cd node_project
```

This will be the root directory of the project

Next, create a `package.json` file with the project’s dependencies and other identifying information. Open the file with `vim` 
```
vi  package.json
```
Add the following information about the project, including its name, author, license, entrypoint, and dependencies. Be sure to replace the author information with your own name and contact details:

```
{
    "name": "hilltop-nodejs-image",
    "version": "1.0.0",
    "description": "Hilltop Demo App",
    "author": "Hilltop Consultancy", 
    "license": "MIT",
    "main": "app.js",
    "keywords": [
    "nodejs", 
    "bootstrap", 
    "express"
    ], 
    "dependencies": {
    "express": "^4.16.4" }
}
```
- This file includes the project name, author, and license under which it is being shared
- Lists the MIT license in the license field, permitting the free use and distribution of the application code.
- "main": The entrypoint for the application, app.js. You will create this file next.
- "dependencies": The project dependencies — in this case, Express 4.16.4 or above.

Save and close the file by typing `wq!` and then `ENTER` to confirm your changes. 

Setup Node.js on the Amazon Linux 2 instance by running the following commands. You can check the installation  steps here https://000004.awsstudygroup.com/6-awsfcjmanagement-linux/6.2-setupnodejsonec2linux/ 


```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
```
---
```
. ~/.nvm/nvm.sh
```
---
```
nvm install 16
```
---
```
npm install express

```
---

### Creating the Application Files

We will create a website that offers users information about Docker. This application will have a main entrypoint, `app.js`, and a `views` directory that will include the project’s static assets.

The landing page, `index.html`, will offer users some preliminary information and a link to a page with more detailed Containers information, `containers.html`. 

In the `views` directory, you will create both the landing page and `containers.html`.

- First, open app.js in the main project directory (node_project) to define the project’s routes
```
vi app.js
```

-  Copy and paste the following application code into the app.js file created
```
const express = require('express'); 
const app = express();
const router = express.Router();

const path = __dirname + '/views/'; 
const port = 8080;

router.use(function (req,res,next) { 
    console.log('/' + req.method); 
    next();
});

router.get('/', function(req,res){ 
    res.sendFile(path + 'index.html');
});

router.get('/containers', function(req,res){ 
    res.sendFile(path + 'containers.html');
}); 

app.use(express.static(path));
app.use('/', router);

app.listen(port, function () {
    console.log('Example app listening on port 8080!')
})
```
- The `require` function loads the `express` module, which is used to create the `app` and `router` objects. The `router` object will perform the routing function of the application and as you define HTTP method routes you will add them to this object to define how your application will handle requests.
- The first section of the file also sets a couple of constants, `path` and `port`:
- path: Defines the base directory, which will be the `views` subdirectory within the current project directory.
- port: Tells the app to listen on and bind to port `8080`.

- The `router.use` function loads a middleware function that will log the router’s requests and pass them on to the application’s routes. These are defined in the subsequent functions, which specify that a `GET` request to the base project URL should return the `index.html` page, while a GET request to the `/containers` route should return `containers.html`.

- Finally, mount the router middleware and the application’s static assets and tell the app to listen on port `8080`

- Save and close the file when finished
- Next, we add some static content to the application. Start by creating the `views` directory:
```
mkdir views
```
We create a landing page file, `index.html`:
```
vi views/index.html
```
Add the following code to the file, which will import Boostrap and create a jumbotron component with a link to the more detailed `index.html` info page:

```
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Docker Demo</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <link href="css/styles.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Merriweather:400,700" rel="stylesheet" type="text/css">
</head>

<body>
    <nav class="navbar navbar-dark bg-dark navbar-static-top navbar-expand-md">
        <div class="container">
            <button type="button" class="navbar-toggler collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false"> <span class="sr-only">Toggle navigation</span>
            </button> <a class="navbar-brand" href="#">HilltopConsultancy</a>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav mr-auto">
                    <li class="active nav-item"><a href="/" class="nav-link">Home</a>
                    </li>
                    <li class="nav-item"><a href="/containers" class="nav-link">Containers</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="jumbotron">
        <div class="container">
            <h1>Docker Learning with Hilltop-Consultancy</h1>
            <p>Are you ready to learn about Docker architechture?</p>
            <br>
            <p><a class="btn btn-primary btn-lg" href="/containers" role="button">Get Container Info</a>
            </p>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-lg-6">
            <h3>What is a Docker Image?</h3>
                <p>Images are multi-layered self-contained files that act as the template for creating containers. They are like a frozen, read-only copy of a container. Images can be exchanged through registries.
                </p>
            </div>
            <div class="col-lg-6">
                <h3>What is a Docker Container?</h3>
                <p>A container is an abstraction at the application layer that packages code and dependencies together. Instead of virtualizing the entire physical machine, containers virtualize the host operating system only.
                </p>
            </div>
        </div>
    </div>
</body>

</html>
```
---

With the application landing page in place, you can create your `containers` information page, `containers.html`, which will offer interested users more information about Containers.

- We create a `containers.html` the file:
```
vi views/containers.html
```
---

Add the following code to the file, which will import `Boostrap` and create a jumbotron component with a link to the more detailed `containers.html` info page 

```
<!DOCTYPE html>
<html lang="en">

<head>
    <title>About Docker</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <link href="css/styles.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Merriweather:400,700" rel="stylesheet" type="text/css">
</head>
<nav class="navbar navbar-dark bg-dark navbar-static-top navbar-expand-md">
    <div class="container">
        <button type="button" class="navbar-toggler collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false"> <span class="sr-only">Toggle navigation</span>
        </button> <a class="navbar-brand" href="/">Everything Docker</a>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav mr-auto">
                <li class="nav-item"><a href="/" class="nav-link">Home</a>
                </li>
                <li class="active nav-item"><a href="/sharks" class="nav-link">Containers</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="jumbotron text-center">
    <h1>Docker Info</h1>
</div>
<div class="container">
    <div class="row">
        <div class="col-lg-6">
            <p>
                <div class="caption">A container is an abstraction at the application layer that packages code and dependencies together. Instead of virtualizing the entire physical machine, containers virtualize the host operating system only.
                </div>
                <img src="https://www.freecodecamp.org/news/content/images/2021/04/virtual-machines.svg" alt="ContainerArchiteture">
            </p>
        </div>
        <div class="col-lg-6">
            <p>
                <div class="caption">You can share any number of public images on Docker Hub for free. People around the world will be able to download them and use them freely. Images that I've uploaded are available </div>
                <img src="https://www.freecodecamp.org/news/content/images/2021/01/docker-hub.png" alt="Sammy the Shark">
            </p>
        </div>
    </div>
</div>

</html>
```
---
Note that in this file, you once again use the active `Bootstrap` class to indicate the current page.

-  Save and close the file when you are finished.
- Finally, create the custom CSS `style` sheet that you’ve linked to in `index.html` and `containers.html` by creating a `css` folder in the `views` directory:
```
mkdir views/css
```

Open the style sheet
```
vi views/css/styles.css
```

Add the following code, which will set the desired color and font for your pages:
```
.navbar {
    margin-bottom: 0;
}

body {
    background: #020A1B;
    color: #ffffff;
    font-family: 'Merriweather', sans-serif;
}

h1
h2 {
    font-weight: bold;
}

p {
    font-size: 16px;
    color: #ffffff;
}

.jumbotron {
    background: hsla(29, 92%, 55%, 0.694);
    color: white;
    text-align: center;
}

.jumbotron p {
    color: white;
    font-size: 26px;
}

.btn-primary {
    color: #fff;
    text-color: #b15f1c;
    border-color: white;
    margin-bottom: 5px;
}

img,
video,
audio {
    margin-top: 20px;
    max-width: 80%;
}

div.caption: {
    float: left;
    clear: both;
}
```

- Save and close the file when you are finished.

- To start the application, make sure that you are in your project’s root directory
```
cd ~/node_project
```

- Start the application with node app.js:
```
node app.js
```

- Navigate your browser to `http://your_server_ip:8080`. The following is your landing page:

### Writing the Dockerfile

The `Dockerfile` specifies what will be included in your application container when it is executed. Using a Dockerfile allows you to define your container environment and avoid discrepancies with dependencies or runtime versions.

i.	In the project’s root directory (`node_project`), create the Dockerfile:
```
vi Dockerfile
```
ii.	Paste the following instructions in the Dockerfile:
```
FROM node:10-alpine

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

WORKDIR /home/node/app

COPY package*.json ./

USER node

RUN npm install

COPY --chown=node:node . .

EXPOSE 8080

CMD [ "node", "app.js" ]
```

This image includes Node.js and npm. Each Dockerfile must begin with a FROM instruction

- `FROM node:10-alpine`

By default, the Docker Node image includes a non-root `node` user that you can use to avoid running your application container as `root`. We will therefore use the node user’s home directory as the working directory for our application and set them as our user inside the container
To fine-tune the permissions on your application code in the container, create the `node_modules` subdirectory in `/home/node` along with the app directory. Creating these directories will ensure that they have the correct permissions, which will be important when you create local node modules in the container with `npm install`. In addition to creating these directories, set ownership on them to your node user. 

- `RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app`

- We set the working directory of the application to /home/node/app.

`WORKDIR /home/node/app`

Next, copy the package.json and package-lock.json (for npm 5+) files. 

`COPY package*.json ./`

To ensure that all of the application files are owned by the non-root node user, including the contents of the node_modules directory, switch the user to node before running npm install. 
USER node

After copying the project dependencies and switching the user, `run npm install`

`RUN npm install`

Next, copy the application code with the appropriate permissions to the application directory on the container.

`COPY --chown=node:node . .`

This will ensure that the application files are owned by the non-root node user.

Finally, expose port `8080` on the container and start the application:

`EXPOSE 8080`

`CMD [ "node", "app.js" ]`

`CMD` runs the command to start the application — in this case, `node`, `app.js`.

- Save and close the file when you are finished editing.

### Creating a .dockerignore file
Before building the application image, add a .dockerignore file. Working in a similar way to a .gitignore file, .dockerignore specifies which files and directories in your project directory should not be copied over to your container.

- Open the `.dockerignore `file
```
vi .dockerignore
```

Inside the file, add your local `node modules`, `npm logs`, `Dockerfile`, and `.dockerignore`, `.git`, `.gitignore` file:

- Save and close the file when you are finished.

### Building the Docker image
Build the application image using the docker build command. Using the -t flag with docker build will allow you to tag the image with a memorable name. Because you’re going to push the image to Docker Hub, include your `Docker Hub username` in the tag. 

You can tag the image as `hilltopconsultancy/class2024a:v1`

 Remember to also replace `your_dockerhub_username` with your own Docker Hub username

To build the image, run the command

```
docker build -t hilltopconsultancy/class2024a:v1 .
```

The `.` specifies that the build context is the current directory.
It will take some time to build the image. Once it is complete, check your images:
```
docker images
```
---

### Building the creating a container from  the Image
It is now possible to create a container with this image using `docker run`. You will include three flags with this command
- `-p`: This publishes the port on the container and maps it to a port on your host. You can use port 80 on the host, but you should feel free to modify this as necessary if you have another process running on that port. 
- `-d`: This runs the container in the background.
- `--name`: This allows you to give the container a memorable name.

Run the following command to build the container
```
docker run --name hilltopconsultancy-class2024a-img -p 80:8080 -d hilltopconsultancy/class2024a:v1
```
---
Once your container is up and running, you can inspect a list of your running containers with 
```
docker ps
```
---

### Pushing  the image to Dockerhub
Now that you have created an image for your application, you can push it to Docker Hub for future use. By pushing your application image to a registry like Docker Hub, you make it available for subsequent use as you build and scale your containers. To demonstrate how this works, you will push the application image to a repository and then use the image to recreate your container.

- The first step to pushing the image is to log in to the Docker Hub account you created in the prerequisites

```
docker login -u your_dockerhub_username
```

- When prompted, enter your Docker Hub account password. 
Logging in this way will create a `~/.docker/config.json` file in your user’s home directory with your Docker Hub credentials.

- push the application image to Docker Hub using the tag you created earlier, `hilltopconsultancy/class2024a:v1`

```
docker push hilltopconsultancy/class2024a:v1
```
---

## Devops-fully-Docker-Image-deployment-with-Jenkins
Creating a Jenkins pipeline for the deployment

- Pull the Jenkins image from dockerhub
```
docker pull jenkins/jenkins:latest
```
- Start the Jenkins  CI service by  running the `jenkins` container image
```
docker run  -d -p 8080:8080 jenkins/jenkins:latest
```

- Jenkins setup
1) #### Access Jenkins
    Copy your Jenkins Public IP Address and paste on the browser = **ExternalIP:8080**
    - Login to your Jenkins instance using your Shell (GitBash or your Mac Terminal)
    - Copy the Path from the Jenkins UI to get the Administrator Password
        - Run: `docker exec 979dc3192c9c cat /var/jenkins_home/secrets/initialAdminPassword` #remember to replace `979dc3192c9c` with your container ID
        - Copy the password and login to Jenkins
    - Plugins: Choose Install Suggested Plugings 
    - Provide 
        - Username: **admin**
        - Password: **admin**
        - Name and Email can also be admin. You can use `admin` all, as its a poc.
    - Continue and Start using Jenkins

2)  #### Pipeline creation
    - Click on **New Item**
    - Enter an item name: **hilltopconsultancy-nodejs-app-pipeline** & select the category as **Pipeline**
    - Now scroll-down and in the Pipeline section --> Definition --> Select Pipeline script from SCM
    - SCM: **Git**
    - Repositories
        - Repository URL: FILL YOUR OWN REPO URL (that we created by importing in the first step)
        - Branch Specifier (blank for 'any'): */main
        - Script Path: Jenkinsfile
    - Save

4)  #### Credentials setup(AWS):
    - Click on Manage Jenkins --> Manage Credentials --> Global credentials (unrestricted) --> Add Credentials
        1)  ###### DOCKER Credential (DOCKERHUB_CREDENTIALS)
            - Kind: Username and Password
            - Username: "Enter your Dockerhub user name" 
            - Password: "Enter your Dockerhub password"          
            - Description: DOCKERHUB_CREDENTIALS
            - Click on Create            

### Performing continous integration with GitHub webhook

1) #### Add jenkins webhook to github
    - Access your repo **hilltop-docker-learning** on github
    - Goto Settings --> Webhooks --> Click on Add webhook 
    - Payload URL: **htpp://REPLACE-JENKINS-SERVER-PUBLIC-IP:8080/github-webhook/**    (Note: The IP should be public as GitHub is outside of the AWS VPC where Jenkins server is hosted)
    - Click on Add webhook

2) #### Configure on the Jenkins side to pull based on the event
    - Access your jenkins server, pipeline **hilltopconsultancy-nodejs-app-pipeline**
    - Once pipeline is accessed --> Click on Configure --> In the General section --> **Select GitHub project checkbox** and fill your repo URL of the project.
    - Scroll down --> In the Build Triggers section -->  **Select GitHub hook trigger for GITScm polling checkbox**

Once both the above steps are done click on Save.


### Codebase setup

1) #### For checking the Gitbut webhook, go to your index.html file  uncomment lines 32 by removing the <!-- --> in the index.html file
    - Go back to your local, open your "hilltop-docker-learning" project on VSCODE
    - cd to `project`
    - Open "index.html file" uncomment lines   
    - Save the changes in both files
    - Finally push changes to repo
        `git add .`
        `git commit -m "relevant commit message"`
        `git push`
### Finally observe the whole flow and understand the integrations

# Happy learning from HilltopConsultancy
