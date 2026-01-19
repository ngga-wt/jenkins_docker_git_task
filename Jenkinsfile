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
          // Print Environment variables to console
          echo "START_AT: [$START_TIME] ,BUILD_NUMBER: $BUILD_NUMBER ,JOB_NAME: $JOB_NAME AND USER_NAME: ${USER_NAME}"

          // build docker image with custom name called ubuntu_24_latest_v1
          sh "docker build -t $imageName ."
        }
      }
    }
    stage('Run docker container') {
      steps {
        script {
          // get container name $containerName if exisst
          def myContainerName = sh(script: "docker ps -a | sed -rn \"s/.*($containerName)\$/\\1/p\"", returnStdout: true).trim()

          // if allready exisst exit with failure
          if (myContainerName == containerName) {
              error('Run stage condition failed, exiting pipeline') 
          }

          // else run ubuntu_24_latest_v1 image to create custom container name from env
          sh "docker run -itd --rm --name $containerName $imageName"
        }
      }
    }
  }
  post {
    success {
      script {

        retry(2) { 
            timeout(time: 10, unit: 'SECONDS') { 
            def myContainer = sh(script: "docker container ls | sed -rn \"s/.*($containerName)\$/\\1/p\"", returnStdout: true).trim()
 
            echo "$myContainer :: $containerName"
            //if allready running trow exception and retry 2 times
            if (myContainer == containerName) {
                error("Post action failed: container name $containerName shuld be stoped by know!") 
            }

            // else sleep 5 seconds and exit block of code
            sh 'sleep 5' // This command would cause a timeout
          }
        }
        def endAt = sh(script: 'date +"%Y-%m-%d %H:%M:%S"',returnStdout: true).trim()

        // Print Environment variables to console
        echo "START_AT: [$START_TIME] ,END_AT: [$endAt] ,BUILD_NUMBER: $BUILD_NUMBER ,JOB_NAME: $JOB_NAME AND USER_NAME: ${USER_NAME}"
      }
      echo 'Pipeline has finished with success.'
    }
  }
}
