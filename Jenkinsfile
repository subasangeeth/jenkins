pipeline {
    agent any
    
    tools{
        jdk 'jdk21'
        maven 'mvn'
    }
    
    stages {
        
        stage('Checkout Code'){
         
            steps {
            git branch :'main',
                url : 'https://github.com/subasangeeth/jenkins.git'
            
            }    
        }
        
        stage('Build') {
            
            steps{
                 dir('Jenkins-CICD'){
                     sh 'ls'
                      sh 'mvn clean install -DskipTests'
                 }
            }
        }
        
        stage('Dockerize'){
            
            steps{
                script{
                     dir('Jenkins-CICD'){
                docker.build('jenkins:v1')
                     }
                }
            }
        }
        
        stage ('Deploy'){
            
            steps{
                sh 'docker stop springboot-app || true'
                sh 'docker rm springboot-app || true'
                sh 'docker run -d -p 8000:8000 --name springboot-app jenkins:v1'
            }
        }
    }
}
