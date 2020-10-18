application = "warna"
project = "demo"

openshiftApiURL = "https://api.ocp4.ogya.int:6443"
openshiftAuthToken = null

contextDir = "/"
gitBranch = "master"
gitURL = "https://github.com/praboworamasatrio/warna"
openshiftTemplatePath = "openshift-templates/jws31-tomcat7-basic-s2i.json"


node('maven'){

   getJenkinsSACredentials()
    
    sh """
        set +x
        oc login --token=${openshiftAuthToken} ${openshiftApiURL} >/dev/null 2>&1 || echo 'OpenShift login failed'
    """
    
    //git changelog: false, poll: false, url: 'https://github.com/vidhyachari/openshift-hello-nodejs'
    // Checkout the source code
    checkout scm
    
    sh """
      oc process -f ${openshiftTemplatePath} \
        APPLICATION_NAME=${application} \
        SOURCE_REPOSITORY_REF=${gitBranch} \
        SOURCE_REPOSITORY_URL=${gitURL} \
        CONTEXT_DIR="/" \
        -n ${project} | oc apply -f - -n ${project}
      """

    //Start openshift build
    sh """
      oc get bc ${application} -n ${project}

      # Cancel any currently running builds
      oc cancel-build bc/${application} -n ${project}

      # Start build and follow logs
      oc start-build ${application} --follow -n ${project}
    """
   
   //Start Deployment
   sh """
      oc rollout cancel dc/${application} -n ${project}
      oc rollout latest dc/${application} -n ${project}
   """
   
}//node

def getJenkinsSACredentials(){

  withCredentials([[$class: 'StringBinding',
    credentialsId: 'jenkins-service-account',
    variable: 'authToken']]) {
    openshiftAuthToken = authToken
  }

}
