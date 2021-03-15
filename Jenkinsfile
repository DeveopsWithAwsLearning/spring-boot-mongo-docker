node('master'){
    def mavenHome = tool name: "Maven3.6.3"
    def buildNumber = BUILD_NUMBER
    
    stage("Checkout code from Git"){
        git credentialsId: 'a3b2f900-588c-4a6f-9866-9206772f6cc8',
        url: 'https://github.com/DeveopsWithAwsLearning/spring-boot-mongo-docker.git'
          }
    
    stage("Build code package with Maven"){
       sh "${mavenHome}/bin/mvn clean package"    
    }
    
    stage("Build Docker Image"){
        sh "docker build -t swamipeddineni/spring-boot-docker:${buildNumber} ."
    }
    
    stage("Login into DockerHub and Push Image into DockerHub"){
     withCredentials([string(credentialsId: 'DocHubPwd', variable: 'DocHubPwd')]) {
       sh "docker login -u swamipeddineni -p ${DocHubPwd}"
      }
       sh "docker push swamipeddineni/spring-boot-docker:${buildNumber}"
    }
    
        stage("Deploy Application as Docker Container into DockerDev Deployment Server"){
        sshagent(['Docker_Dep_SSH']) {
		    sh 'scp -o StrictHostKeyChecking=no  docker-compose.yml docker-composedev.yml ubuntu@65.0.21.156:
        sh 'ssh -o StrictHostKeyChecking=no ubuntu@65.0.21.156 docker-compose -f docker-compose.yml -f docker-composedev.yml up -d'
        }
    }

          stage("Deploy Application as Docker Container into DockerQa Deployment Server"){
          sshagent(['Docker_Qa_Dep']) {
		    sh 'scp -o StrictHostKeyChecking=no  docker-compose.yml docker-composeqa.yml ubuntu@15.207.249.182:
        sh 'ssh -o StrictHostKeyChecking=no ubuntu@15.207.249.182 docker-compose -f docker-compose.yml -f docker-composeqa.yml up -d'
        }
    }

   
}
