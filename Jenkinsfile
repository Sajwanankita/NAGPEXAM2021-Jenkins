pipeline{
  agent any
  
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
          rtUpload{
            serverId: '123456789@artifactory',
              spec: """
              {
              "files":[
                  {
                      "pattern":"**/*.war",
                      "target":"NAGP_EXAM2020"
                  }
                ]
              }
              """
          }
        }
    }
    

  }
}
