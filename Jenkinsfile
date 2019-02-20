pipeline {
   agent any
  
   stages {
      stage ('Compile Stage') {
        steps {
          withMaven(maven : 'maven-3.2.1') {
            mvn clean compile
          }
        }
      }
    
      stage ('Testing Stage') {
        steps {
          withMaven(maven : 'maven-3.2.1') {
            mvn test
          }
        }
      }
      
  }
}
