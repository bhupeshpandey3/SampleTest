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
                    app = docker.build("sample-test")
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Empty'
            }
        }

        stage('Push to ECR') {
            steps {
                script {
                    docker.withRegistry('https://461060215591.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:aws-cred') {
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
                    sh 'docker run -itd --name sample-test 461060215591.dkr.ecr.us-east-1.amazonaws.com/sample-test:${TAG}'
                    }
                }
            }
        }
    }
}
