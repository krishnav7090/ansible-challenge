pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = "us-east-1"
        ANSIBLE_HOST_KEY_CHECKING = "False"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/<your-username>/terraform-ansible-jenkins.git'
            }
        }

        stage('Terraform Init & Apply') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws-creds']
                ]) {
                    sh '''
                      cd terraform
                      terraform init
                      terraform apply -auto-approve
                    '''
                }
            }
        }

        stage('Run Ansible Playbooks') {
            steps {
                sshagent(['ec2-ssh-key']) {
                    sh '''
                      cd ansible
                      ansible-playbook -i inventory.ini common.yml
                      ansible-playbook -i inventory.ini backend.yml
                      ansible-playbook -i inventory.ini frontend.yml
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "Deployment completed successfully"
        }
        failure {
            echo "Deployment failed"
        }
    }
}
