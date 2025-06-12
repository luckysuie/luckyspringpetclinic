pipeline {
    agent any
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
        stage ('Trivy Scan') {
            steps {
                echo 'Running Trivy scan...'
                sh 'trivy fs --output trivy-report.txt --severity HIGH,CRITICAL .'
            }
        }
         
        }
        stage('Sonar Analysis') {
    environment {
        SCANNER_HOME = tool 'Sonar-scanner'
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

        }
