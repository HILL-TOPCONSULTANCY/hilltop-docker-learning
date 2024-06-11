## Creating NodeJS application
### Prequisite 
- Amazon Linux EC2 instance
- Docker installed on the EC2 instance
- Node.js and npm installed on the instance
- A Docker hub account

###   Installing  nodejs application dependencies

To create an image, we will first need to make our application files, which we can then copy to the container. These files will include our application’s static content, code, and dependencies.
- Create a directory for your project in your non-root user’s home directory. The directory in this example named `node_project`.

```
mkdir node_project
```

- Navigate to this directory

```
cd node_project
```

This will be the root directory of the project

- Next, create a `package.json` file with the project’s dependencies and other identifying information. Open the file with `vim` 
```
vi  package.json

```

- Add the following information about the project, including its name, author, license, entrypoint, and dependencies. Be sure to replace the author information with your own name and contact details:
```



## Devops-fully-Docker-Image-deployment-with-Jenkins
Fully automated and secured Terraform infra pipeline

## CICD Infra setup
1) ###### GitHub setup
    Fork GitHub Repository by using the existing repo "jenkins-cicd-repo" (https://github.com/HILL-TOPCONSULTANCY/jenkins-cicd-repo.git)     
    - Go to GitHub (github.com)
    - Login to your GitHub Account
    - Fork repository "jenkins-cicd-repo" (https://github.com/HILL-TOPCONSULTANCY/jenkins-cicd-repo.git) & name it "jenkins-cicd-repo.git"
    - Clone your newly created repo to your local

2) ###### Jenkins
    - Create an **Amazon Linux 2 VM** instance and call it "Jenkins"
    - Instance type: t2.medium
    - Security Group (Open): 8080, 9100 and 22 to 0.0.0.0/0
    - Key pair: Select or create a new keypair
    - **Attach Jenkins server with IAM role having "AdministratorAccess"**
    - Launch Instance
    - After launching this Jenkins server, attach a tag as **Key=Application, value=jenkins**
    - SSH into the instance and Run the following commands in the **jenkins.sh** file found in the **installation-files** directory

### Jenkins setup
1) #### Access Jenkins
    Copy your Jenkins Public IP Address and paste on the browser = **ExternalIP:8080**
    - Login to your Jenkins instance using your Shell (GitBash or your Mac Terminal)
    - Copy the Path from the Jenkins UI to get the Administrator Password
        - Run: `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
        - Copy the password and login to Jenkins
    - Plugins: Choose Install Suggested Plugings 
    - Provide 
        - Username: **admin**
        - Password: **admin**
        - Name and Email can also be admin. You can use `admin` all, as its a poc.
    - Continue and Start using Jenkins

2)  #### Pipeline creation
    - Click on **New Item**
    - Enter an item name: **jenkins-cicd-pipeline** & select the category as **Pipeline**
    - Now scroll-down and in the Pipeline section --> Definition --> Select Pipeline script from SCM
    - SCM: **Git**
    - Repositories
        - Repository URL: FILL YOUR OWN REPO URL (that we created by importing in the first step)
        - Branch Specifier (blank for 'any'): */main
        - Script Path: Jenkinsfile
    - Save

3)  #### Plugin installations:
    - Click on "Manage Jenkins"
    - Click on "Plugin Manager"
    - Click "Available"
    - Search and Install the following Plugings "Install Without Restart"        
        - **Terraform**

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
    - Access your repo **jenkins_with_terraform_deployment** on github
    - Goto Settings --> Webhooks --> Click on Add webhook 
    - Payload URL: **htpp://REPLACE-JENKINS-SERVER-PUBLIC-IP:8080/github-webhook/**    (Note: The IP should be public as GitHub is outside of the AWS VPC where Jenkins server is hosted)
    - Click on Add webhook

2) #### Configure on the Jenkins side to pull based on the event
    - Access your jenkins server, pipeline **jenkins-cicd-pipeline**
    - Once pipeline is accessed --> Click on Configure --> In the General section --> **Select GitHub project checkbox** and fill your repo URL of the project.
    - Scroll down --> In the Build Triggers section -->  **Select GitHub hook trigger for GITScm polling checkbox**

Once both the above steps are done click on Save.


### Codebase setup

1) #### For checking the Gitbut webhook uncomment lines 18-24 in main.tf file
    - Go back to your local, open your "jenkins-cicd-repo" project on VSCODE
    - Open "main.tf file" uncomment lines   
    - Save the changes in both files
    - Finally push changes to repo
        `git add .`
        `git commit -m "relevant commit message"`
        `git push`
### Finally observe the whole flow and understand the integrations

# Happy learning from Hilltop  Consultancy
