node {

   stage('Clone Repository') {
        // Get some code from a GitHub repository
        git 'https://github.com/praboworamasatrio/color.git'
    
   }
   stage('Build Maven Image') {
        docker.build("maven-build")
   }
   
   stage('Run Maven Container') {
       
        //Remove maven-build-container if it exisits
        sh 'docker rm -f maven-build-container || echo "remove container if already exist"'
        
        //Run maven image
        sh "docker run --name maven-build-container maven-build"
   }
   
   stage('Deploy Spring Boot Application') {
        
         //Remove maven-build-container if it exisits
        sh 'docker rm -f java-deploy-container || echo "remove container if already exist"'
       
        sh "docker run --name java-deploy-container --volumes-from maven-build-container -d -p 8080:8080 tomcat:8.0.51-jre8-alpine"
		sh "docker cp java-deploy-container:/deploy/application/target/ROOT.war /c/boy/"
		sh "docker cp /c/boy/ROOT.war java-deploy-container:/usr/local/tomcat/webapps/"
   }

}
