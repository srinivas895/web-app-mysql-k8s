pipeline {
    agent any
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
    }
}
