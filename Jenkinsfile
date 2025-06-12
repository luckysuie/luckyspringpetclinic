pipeline {
    agent any
    options {
        // "Restart from stage" in Blue Ocean UI
        restartableStages()
    }
    environment {
    IMAGE_NAME = 'my-app-image'
    BUILD_TAG = "${BUILD_NUMBER}"
}
    stages {
        stage('Checkout From Git') {
            steps {
                git branch: 'main', url: 'https://github.com/luckysuie/luckyspringpetclinic.git'
            }
        }

        stage('Maven Compile') {
            steps {
                echo 'Compiling the project...'
                sh 'mvn compile'
            }
        }

        stage('Maven Test') {
            steps {
                echo 'Running tests...'
                sh 'mvn test'
            }
        }

        stage('Trivy Scan') {
            steps {
                echo 'Running Trivy scan...'
                sh 'trivy fs --output trivy-report.txt --severity HIGH,CRITICAL .'
            }
        }

        stage('Sonar Analysis') {
            environment {
                SCANNER_HOME = tool 'sonar-scanner'
            }
            steps {
                withSonarQubeEnv('sonarserver') {
                    sh '''
                    $SCANNER_HOME/bin/sonar-scanner \
                    -Dsonar.organization=sonarproject456 \
                    -Dsonar.projectName=jenkins \
                    -Dsonar.projectKey=sonarproject456_jenkins \
                    -Dsonar.java.binaries=. \
                    -Dsonar.exclusions=**/trivy-report.txt
                    '''
                }
            }
        }

        stage('Sonar Quality Gate') {
            steps {
                echo 'Waiting for SonarQube quality gate...'
                timeout(time: 1, unit: 'MINUTES') {
                waitForQualityGate abortPipeline: true, credentialsId: 'sonartoken'
                }
            }
        }
        stage('Maven Package') {
            steps {
                echo 'Packaging the project...'
                sh 'mvn package'
            }
        }
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    docker.build("${IMAGE_NAME}:${BUILD_TAG}")
                }
            }
        }
    }
}