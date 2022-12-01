def server = "angga@192.168.100.59"
def credential = "angga"
def workdir = "/home/angga/literature-frontend"
def imagename = "angga/literature-frontend"
def branch = "Production"

pipeline {
    agent any

    stages {
        stage('Pull from Github') {
            steps {
                sshagent(credentials: ["${credential}"]) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${server} << EOF
                        cd ${workdir}
                        git pull origin ${branch}
                    """
                }
            }
        }
            
        stage('Build docker image') {
            steps {
                sshagent(credentials: ["${credential}"]) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${server} << EOF
                        cd ${workdir}
                        docker build -t ${imagename}:${env.BUILD_ID} .
                    """
                }
            }
        }
            
        stage('Deploy image into container') {
            steps {
                sshagent(credentials: ["${credential}"]) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${server} << EOF
                        cd ${workdir}
                        docker compose down
                        docker rmi ${imagename}:latest
                        docker tag ${imagename}:${env.BUILD_ID} ${imagename}:latest
                        docker compose up -d
                    """
                        }
            }
        }
    }
}
