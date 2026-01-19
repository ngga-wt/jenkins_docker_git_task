pipeline {
  agent any
  environment {
      START_TIME = sh(script: 'date +"%Y-%m-%d %H:%M:%S"',returnStdout: true).trim()
      USER_NAME = sh(script: 'whoami', returnStdout: true).trim()
      imageName = 'ubutntu_24_latest_v1'
      containerName = 'ubuntu_24_container_v1'
    }
  stages {
    stage('Build docker image') {
      steps {
        script {
        }
      }
    }
}
