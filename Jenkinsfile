pipeline {
    agent any
    
    
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
                docker.build('app:v1')
                sh 'docker tag app:v1 subasangeeth/app:v1'
                sh 'docker push subasangeeth/app:v1'
                     }
                }
            }
        }
        
        stage ('Terraform'){
            
            steps{
                dir('Jenkins-CICD/terr_ible'){
                    sh "terraform init"
                    sh "terraform plan"
                    sh "terraform apply -auto-approve"
                
                }
            }
        }
        
        stage ('Ansible'){
            steps {
                
            dir('Jenkins-CICD/terr_ible/ansible'){
             script {
                    env.IP = sh(
                        script: "cd .. && terraform output -raw public_ip",
                        returnStdout: true
                    ).trim()
                sh "echo Terraform IP = ${env.IP}"
            
            sh '''echo "[ec2]" > hosts.ini'''
            sh "echo \"${env.IP} ansible_user=ec2-user ansible_ssh_private_key_file=sshkey.pem \" >> hosts.ini"
            sh "chmod 600 sshkey.pem"
            sh 'ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.ini playbook.yml'
            }
            }
            }
    }
}
}
