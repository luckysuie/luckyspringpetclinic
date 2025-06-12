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
        stage('sonar Analysis')
        {
            steps {
                echo 'Running SonarQube analysis...'
                sh 'mvn sonar:sonar -Dsonar.organization=Sonarproject -Dsonar.projectKey=luckysonarproject456_jenkins -Dsonar.host.url=https://sonarcloud.io -Dsonar.login=yea1725c30036484241e88affb6185ee709d5ca8e'
            }
        }
    }
}
