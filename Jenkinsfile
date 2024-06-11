
pipeline{

	agent any

	//rename the user name michaelgwei86 with the username of your dockerhub repo
	environment {
		DOCKERHUB_CREDENTIALS=credentials('DOCKERHUB_CREDENTIALS')
		IMAGE_REPO_NAME = "hilltopconsultancy/class2024a-img-"
		CONTAINER_NAME= "hilltopconsultancy/class2024a-cont-"
	}
	
//Downloading files into repo
	stages {
		stage('Git checkout') {
            		steps {
                		echo 'Cloning project codebase...'
                		git branch: 'main', url: 'https://github.com/HILL-TOPCONSULTANCY/hilltop-docker-learning.git'
            		}
        	}
	
//Building and tagging our Docker image

		stage('Build-Image') {
			
			steps {
				//sh 'docker build -t hilltopconsultancy/class2024a-img-:$BUILD_NUMBER .'
				sh 'docker build -t $IMAGE_REPO_NAME:$BUILD_NUMBER .'
				sh 'docker images'
			}
		}
		
//Logging into Dockerhub
		stage('Login to Dockerhub') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

//Building and tagging our Docker container
		stage('Build-Container') {

			steps {
				//sh 'docker run --name hilltopconsultancy/class2024a-cont-$BUILD_NUMBER -p 8082:8080 -d hilltopconsultancy/class2024a-img-:$BUILD_NUMBER'
				sh 'docker run --name $CONTAINER_NAME-$BUILD_NUMBER -p 8089:8080 -d $IMAGE_REPO_NAME:$BUILD_NUMBER'
				sh 'docker ps'
			}
		}

//Pushing the image to the docker

		stage('Push to Dockerhub') {
			//Pushing image to dockerhub
			steps {
				//sh 'docker push hilltopconsultancy/class2024a-img:$BUILD_NUMBER'
				sh 'docker push $IMAGE_REPO_NAME:$BUILD_NUMBER'
			}
		}
        
	}

}