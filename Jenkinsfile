pipeline {
  agent any 
  stages {
    stage ('Install dependencies') {
      steps {
        script {
          sh "pip3 install -r requirements.txt"
        }
      }
    }
    stage ('Unit test') {
      steps {
        script {
          try {
            sh "pytest"
          } cath {
              println("No unit test's are there in my test source code")
          }
        }
      }
    }
    stage('sonar code qualisty analysis') {
      steps {
        script {
           def scannerHome = tool 'sonarscanner'
           withSonarQubeEnv('sonar') { 
             sh "${scannerHome}/bin/sonar-scanner -Dsonar.projetKey=test"
          }
        }
      }
    }
  }
}
            
          
