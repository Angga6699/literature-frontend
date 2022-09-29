def branch = "production"
def remoteurl = "https://github.com/malikalrizky/literature-frontend.git"
def remotename = "jenkins"
def dir = "~/literature-frontend/"
def ip = "103.186.0.248"
def username = "malikal"
def image = "malikalrk/literature-fe:latest"
def key = "app-key"
def compose = "fe.yml"

pipeline {
    agent any

    stages {
        stage('Pull From Frontend Repo') {
            steps {
                sshagent(credentials: ["${key}"]) {
                    sh """
                        ssh -tt ${username}@${ip} <<pwd
                        cd ${dir}
                        git remote add ${remotename} ${remoteurl} || git remote set-url ${remotename} ${remoteurl}
                        git pull ${remotename} ${branch}
                        pwd
                    """
                }
            }
        }
            
        stage('Build Docker Image') {
            steps {
                sshagent(credentials: ["${key}"]) {
                    sh """
                        ssh -tt ${username}@${ip} <<pwd
                        cd ${dir}
                        docker build -t ${image} .
                        pwd
                    """
                }
            }
        }
            
        stage('Deploy Image') {
            steps {
                sshagent(credentials: ["${key}"]) {
                    sh """
                        ssh -tt ${username}@${ip} <<pwd
                        cd ${dir}
                        // docker compose -f ${compose} down
                        docker compose -f ${compose} up -d
                        pwd
                    """
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sshagent(credentials: ["${key}"]) {
                    sh """
                        ssh -tt ${username}@${ip} <<pwd
                        docker image push ${image}
                        docker image prune -f --all
                        pwd
                    """
                }
            }
        }
    }
}
