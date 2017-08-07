#!/usr/bin/env groovy

node ('master'){
    def crumb
    
    stage('get crumb'){
    def curlString = "curl -u " + USER + ":" + PASSWORD + " " + JENKINS_URL + "/crumbIssuer/api/xml?xpath=concat\\(//crumbRequestField,%22:%22,//crumb\\)"
    echo "$curlString"
    crumb = sh(script: curlString, returnStdout: true)
    echo "$crumb"
    }
    
    stage('trigger build1'){
     def buildCurlString = "curl -u " + USER + ":" + PASSWORD + " -X POST " + JENKINS_URL + "/job/" + BUILD_NAME+ "/build" +  "  -H \"" + crumb + "\""
     echo "$buildCurlString"
     sh buildCurlString
    }
    
    stage('trigger build2'){
     def paramsJson='{"parameter":[{"name":"SERVER_URL","value":"http://jfrog.local/artifactory"},{"name":"GRADLE_TOOL","value":"gradle-3.5"},{"name":"DEPLOY_REPO","value":"gradle-release"},{"name":"SERVER_ID","value":"artifactory-ha"}]}'
     def buildCurlString = "curl -u " + USER + ":" + PASSWORD + " -X POST " + JENKINS_URL + "/job/" + "step1-create-application-war-file"+ "/build" +  "  -H \"" + crumb + "\"" + " --data-urlencode json=" +"'" + paramsJson + "'"
     echo "$buildCurlString"
     sh buildCurlString
    }
    
}
