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
    }
}
