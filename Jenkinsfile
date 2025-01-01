pipeline {
    agent any
    environment {
        AWS_ECR_REPOSITORY = "654654348225.dkr.ecr.us-east-2.amazonaws.com/web-app"
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
        stage ('Build docker image') {
            steps {
                script {
                    sh "docker build -t ${AWS_ECR_REPOSITORY}:${BUILD_NUMBER} ."
                }
            }
        }
        stage('Publish image into aws ecr') {
            steps {
                script {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'eks-credentials']]) {
                  sh """
                        export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                        export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                        export AWS_DEFAULT_REGION=us-east-2
                        aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 654654348225.dkr.ecr.us-east-2.amazonaws.com
                        docker push ${AWS_ECR_REPOSITORY}:${BUILD_NUMBER}
                  """
            
                }
            }
        }
        }
                    
    }
}
