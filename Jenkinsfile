#!/usr/bin/env groovy

node ('master'){
    def crumb

    stage('get crumb') {

        def curlString = "curl -u " + USER + ":" + PASSWORD + " " + JENKINS_URL + "/crumbIssuer/api/xml?xpath=concat\\(//crumbRequestField,%22:%22,//crumb\\)"
        crumb = sh(script: curlString, returnStdout: true)
        echo "$crumb"
    }
    
    stage('trigger build 1'){

        def lastBuildNumberCurl = "curl -u " + USER + ":" + PASSWORD + " " + JENKINS_URL + "/job/maven-snapshot/lastBuild/buildNumber"
        lastBuildNumber = sh(script: lastBuildNumberCurl, returnStdout: true)

        def buildCurlString = "curl -u " + USER + ":" + PASSWORD + " -X POST " + JENKINS_URL + "/job/maven-snapshot/build" + "  -H \"" + crumb + "\""
        sh buildCurlString

        sleep 60
        def newBuildNumer = (lastBuildNumber as int) + 1
        def artCurlString = "curl -I -u " + USER + ":" + PASSWORD + " " + ARTIFACTORY_URL + "/api/build/maven-snapshot/" + newBuildNumer
        echo sh(script: artCurlString, returnStdout: true)

    }

    stage('trigger build 2'){
        def lastBuildNumberCurl = "curl -u " + USER + ":" + PASSWORD + " " + JENKINS_URL + "/job/maven-release-pipeline/lastBuild/buildNumber"
        lastBuildNumber = sh(script: lastBuildNumberCurl, returnStdout: true)

        def buildCurlString = "curl -u " + USER + ":" + PASSWORD + " -X POST " + JENKINS_URL + "/job/maven-release-pipeline/build" +  "  -H \"" + crumb + "\""
        sh buildCurlString

        sleep 60
        def newBuildNumer = (lastBuildNumber as int) + 1
        def artCurlString = "curl -I -u " + USER + ":" + PASSWORD + " " + ARTIFACTORY_URL + "/api/build/maven-release-pipeline/" + newBuildNumer
        echo sh(script: artCurlString, returnStdout: true)
    }
    
    stage('trigger build 3'){
        def lastBuildNumberCurl = "curl -u " + USER + ":" + PASSWORD + " " + JENKINS_URL + "/job/step1-create-application-war-file/lastBuild/buildNumber"
        lastBuildNumber = sh(script: lastBuildNumberCurl, returnStdout: true)

        def paramsJson = '{"parameter":[{"name":"SERVER_URL","value":"http://jfrog.local/artifactory"},{"name":"GRADLE_TOOL","value":"gradle-3.5"},{"name":"DEPLOY_REPO","value":"gradle-release"},{"name":"SERVER_ID","value":"artifactory-ha"}]}'
        def buildCurlString = "curl -u " + USER + ":" + PASSWORD + " -X POST " + JENKINS_URL + "/job/step1-create-application-war-file/build" + "  -H \"" + crumb + "\"" + " --data-urlencode json=" + "'" + paramsJson + "'"
        sh buildCurlString

        sleep 100
        def newBuildNumer = (lastBuildNumber as int) + 1
        def artCurlString = "curl -I -u " + USER + ":" + PASSWORD + " " + ARTIFACTORY_URL + "/api/build/step1-create-application-war-file/" + newBuildNumer
        echo sh(script: artCurlString, returnStdout: true)
    }

    stage('trigger build 4'){
        def lastBuildNumberCurl = "curl -u " + USER + ":" + PASSWORD + " " + JENKINS_URL + "/job/step2-create-docker-image-template/lastBuild/buildNumber"
        lastBuildNumber = sh(script: lastBuildNumberCurl, returnStdout: true)

        def paramsJson='{"parameter":[{"name":"SERVER_URL","value":"http://jfrog.local/artifactory"},{"name":"CREDENTIALS","value":"f6ee691e-e446-4556-b63b-c4b3b8c054f0"},{"name":"ARTDOCKER_REGISTRY","value":"jfrog.local:5001"},{"name":"SERVER_ID","value":"artifactory-ha"},{"name":"REPO","value":"docker"},{"name":"PROMOTE_REPO","value":"docker-prod-local"},{"name":"SOURCE_REPO","value":"docker-stage-local"},{"name":"SERVER_ID","value":"artifactory-ha"}]}'
        def buildCurlString = "curl -u " + USER + ":" + PASSWORD + " -X POST " + JENKINS_URL + "/job/step2-create-docker-image-template/build" +  "  -H \"" + crumb + "\"" + " --data-urlencode json=" +"'" + paramsJson + "'"
        sh buildCurlString

        sleep 100
        def newBuildNumer = (lastBuildNumber as int) + 1
        def artCurlString = "curl -I -u " + USER + ":" + PASSWORD + " " + ARTIFACTORY_URL + "/api/build/step2-create-docker-image-template/" + newBuildNumer
        echo sh(script: artCurlString, returnStdout: true)
    }

    stage('trigger build 5'){
        def lastBuildNumberCurl = "curl -u " + USER + ":" + PASSWORD + " " + JENKINS_URL + "/job/step3-create-docker-image-product/lastBuild/buildNumber"
        lastBuildNumber = sh(script: lastBuildNumberCurl, returnStdout: true)

        def paramsJson='{"parameter":[{"name":"SERVER_URL","value":"http://jfrog.local/artifactory"},{"name":"CREDENTIALS","value":"f6ee691e-e446-4556-b63b-c4b3b8c054f0"},{"name":"ARTDOCKER_REGISTRY","value":"jfrog.local:5001"},{"name":"SERVER_ID","value":"artifactory-ha"},{"name":"REPO","value":"docker"},{"name":"PROMOTE_REPO","value":"docker-prod-local"},{"name":"SERVER_ID","value":"artifactory-ha"}]}'
        def buildCurlString = "curl -u " + USER + ":" + PASSWORD + " -X POST " + JENKINS_URL + "/job/step3-create-docker-image-product/build" +  "  -H \"" + crumb + "\"" + " --data-urlencode json=" +"'" + paramsJson + "'"
        sh buildCurlString

        sleep 100
        def newBuildNumer = (lastBuildNumber as int) + 1
        def artCurlString = "curl -I -u " + USER + ":" + PASSWORD + " " + ARTIFACTORY_URL + "/api/build/step3-create-docker-image-product/" + newBuildNumer
        echo sh(script: artCurlString, returnStdout: true)
    }
}
