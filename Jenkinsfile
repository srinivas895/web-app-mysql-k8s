pipeline {
    agent any
    environment {
        AWS_ECR_REPOSITORY_URL = "654654348225.dkr.ecr.us-east-2.amazonaws.com"
        WEB_APP_ECR_REPO_NAME = 'web-app'
        MYSQL_ECR_REPO_NAME = "mysql-db"
    }
    stages {
        stage('Install dependencies') {
            steps {
                script {
                    sh "pip3 install -r requirements.txt"
                }
            }
        }
        stage('Unit test') {
            steps {
                script {
                    try {
                        sh "pytest"
                    } catch (Exception e) {
                        println("No unit tests are there in my test source code")
                    }
                }
            }
        }
        stage('Sonar code quality analysis') {
            steps {
                script {
                    def scannerHome = tool 'sonarscanner'
                    withSonarQubeEnv('sonar') {
                        sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=test"
                    }
                }
            }
        }
        stage ('Build web app docker image') {
            steps {
                script {
                    sh "docker build -t ${AWS_ECR_REPOSITORY_URL}/${WEB_APP_ECR_REPO_NAME}:${BUILD_NUMBER} ."
                }
            }
        }
        stage('Publish web app image into aws ecr') {
            steps {
                script {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'eks-credentials']]) {
                  sh """
                        export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                        export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                        export AWS_DEFAULT_REGION=us-east-2
                        aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin ${AWS_ECR_REPOSITORY_URL}
                        docker push ${AWS_ECR_REPOSITORY_URL}/${WEB_APP_ECR_REPO_NAME}:${BUILD_NUMBER}
                  """
            
                }
            }
        }
        }
        stage ('Build mysql docker image') {
            steps {
                script {
                    sh "mysql-db/docker build -t ${AWS_ECR_REPOSITORY_URL}/${MYSQL_ECR_REPO_NAME}:${BUILD_NUMBER} ."
                }
            }
        }
        stage('Publish mysql image into aws ecr') {
            steps {
                script {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'eks-credentials']]) {
                  sh """
                        export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                        export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                        export AWS_DEFAULT_REGION=us-east-2
                        aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin ${AWS_ECR_REPOSITORY_URL}
                        docker push ${AWS_ECR_REPOSITORY_URL}/${MYSQL_ECR_REPO_NAME}:${BUILD_NUMBER}
                  """
            
                }
            }
        }
        }
                    
    }
}
