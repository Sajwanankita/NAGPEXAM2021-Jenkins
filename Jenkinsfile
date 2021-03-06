pipeline{
  agent any
  
  environment{
    DOCKERHUB_REPO="sajwanankita/nagpjenkinsexam"
    CONTAINER_NAME="demo_container"
  }
  
  tools{
    maven 'Maven3'
    jdk 'JDK'
  }
  
  stages{
    stage("clean"){
      steps{
        deleteDir()
      }
    }  
    
    stage("checkout"){
      steps{
        checkout scm
      }
    }
   
    stage("Build Project and Run Test Cases"){
      steps{
        bat 'mvn clean install'
      }
    }
    
    
     stage("Sonar Analysis"){
       agent any
        steps{
          withSonarQubeEnv('Test_Sonar'){
            bat 'mvn clean package sonar:sonar'
          }
        }
    }

    stage("Push war to artifactory"){
        steps{
          rtUpload(
            serverId: '123456789@artifactory',
              spec:'''
              {
              "files":[
                  {
                      "pattern":"**/*.war",
                      "target":"NAGP_EXAM2020"
                  }
                ]
              }
              '''
          )
        }
    }
    
    stage("Build docker image"){
        steps{
            bat 'docker build -t %DOCKERHUB_REPO%:%BUILD_NUMBER% -f Dockerfile .'
        }
    }
    
    stage("Push to Docker Hub"){
        steps{
            bat 'docker push %DOCKERHUB_REPO%:%BUILD_NUMBER%'
        }
    }
    
 	stage ('Stop Running Containers') {
				steps {
				   bat '''
			    FOR /F "tokens=* USEBACKQ" %%F IN (`docker ps -aqf "name=^%CONTAINER_NAME%"`) DO (
							SET ContainerID=%%F
				)
				
						
				IF [%ContainerID%] EQU []  (
				   ECHO "Docker container with name %CONTAINER_NAME% does not exists. Creating container..."
				) ELSE (
				    ECHO "Docker container with name %CONTAINER_NAME% already exists. Removing container..."
					docker stop %ContainerID%
					docker rm %ContainerID%
				)
			  
			 '''
			}
		}

 
    
     stage("Deployment By Docker"){
        steps{
            bat '''
              docker run --name %CONTAINER_NAME% -d -p 8090:8080 %DOCKERHUB_REPO%:%BUILD_NUMBER%
            '''
        }
    }
    

  }
}
