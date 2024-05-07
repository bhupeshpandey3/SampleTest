pipeline {
    agent any

    options {
        skipStagesAfterUnstable()
    }
    
    environment {
        TAG = "${env.BUILD_NUMBER}-latest" // Combine BUILD_NUMBER and "latest" into a single variable
    }

    stages {
        stage('Clone repository') { 
            steps { 
                script {
                    checkout scm
                }
            }
        }

        stage('Build') { 
            steps { 
                script {
                    app = docker.build("testreporegistry/sampletest")
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Empty'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'doc-reg') {
                        app.push(TAG)
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                script {
                    sh 'docker rm -f sampletest'
                    sh 'docker run -itd --name sample-test testreporegistry/sampletest:${TAG}'
                    }
            }
        }
    }
}
