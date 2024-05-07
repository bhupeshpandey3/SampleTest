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
                    withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-cred'
                        ]]) 
                    {
                    sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 461060215591.dkr.ecr.us-east-1.amazonaws.com"
                    sh 'docker rm -f sample-test'
                    sh 'docker run -itd --name sample-test 461060215591.dkr.ecr.us-east-1.amazonaws.com/sample-test:${TAG}'
                    }
                }
            }
        }
    }
}
