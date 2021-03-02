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
    
   stage("Build Project"){
      steps{
        bat 'mvn build'
      }
    }
    
    stage("Run Test Cases and generate test reports"){
      steps{
        bat 'mvn clean install'
      }
    }
    
    

  }
}
