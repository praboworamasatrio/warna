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
        sh " docker rm -f maven-build-container"
        
        //Run maven image
        sh "docker run --name maven-build-container maven-build"
   }
   
   stage('Deploy Spring Boot Application') {
        
         //Remove maven-build-container if it exisits
        sh " docker rm -f java-deploy-container"
       
        sh "docker run --name java-deploy-container --volumes-from maven-build-container -d -p 8080:8080 tomcat:8.0.51-jre8-alpine"
		
		//def wait_results = sh(script: "docker exec -it java-deploy-container cp /deploy/application/target/ROOT.war /usr/local/tomcat/webapps", returnStdout: true)
		sh "winpty docker exec java-deploy-container cp /deploy/application/target/ROOT.war /usr/local/tomcat/webapps"
   }

}
