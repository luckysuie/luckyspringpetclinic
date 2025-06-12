pipeline {
    agent any
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
        stage('Deploy JAR to VM') {
    steps {
        sshagent(['ubuntu-ssh']) {
            sh """
                echo '🚀 Copying JAR to remote server...'
                scp -o StrictHostKeyChecking=no target/spring-petclinic-*.jar lucky@34.135.142.241:/home/lucky/app.jar

                echo '🔁 Restarting app on remote server...'
                ssh -o StrictHostKeyChecking=no ubuntu@34.135.142.241 '
                    pkill -f "java -jar" || true
                    nohup java -jar /home/lucky/app.jar > /home/lucky/app.log 2>&1 &
                '
            """
        }
    }
}

    }
}