pipeline {
    agent any

    tools {
        maven 'maven' // Ensure this matches the Maven installation name in Jenkins
    }

    environment {
        ImageName = 'my-app-image'
        BUILD_TAG = "latest"
    }

    stages {
        stage('Checkout From Git') {
            steps {
                git branch: 'main', url: 'https://github.com/luckysuie/luckyspringpetclinic.git'
            }
        }

        stage('Maven Validate') {
            steps {
                echo 'Validating the project...'
                sh 'mvn validate'
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

        stage('Maven Package') {
            steps {
                echo 'Packaging the project...'
                sh 'mvn package'
            }
        }

        }
    }



























































































// Jenkinsfile for a CI/CD pipeline using Jenkins, Maven, Docker, Azure Container Registry, and Kubernetes
// pipeline {
//     agent any

//     environment {
//         IMAGE_NAME = 'my-app-image'
//         BUILD_TAG = "latest"
//         TENANT_ID = '9288e819-a217-4590-8b41-5088c8ee0457'
//         ACR_NAME = 'dockerregnodejss'
//         ACR_LOGIN_SERVER = "${ACR_NAME}.azurecr.io"
//         FULL_IMAGE_NAME = "${ACR_NAME}.azurecr.io/${IMAGE_NAME}:${BUILD_TAG}"
//         RESOURCE_GROUP = 'demo-rg'
//         CLUSTER_NAME = 'demo-aks'
//     }

//     stages {
//         stage('Checkout From Git') {
//             steps {
//                 git branch: 'main', url: 'https://github.com/luckysuie/luckyspringpetclinic.git'
//             }
//         }

//         stage('Maven Compile') {
//             steps {
//                 echo 'Compiling the project...'
//                 sh 'mvn compile'
//             }
//         }

//         stage('Maven Test') {
//             steps {
//                 echo 'Running tests...'
//                 sh 'mvn test'
//             }
//         }

//         stage('Trivy Scan') {
//             steps {
//                 echo 'Running Trivy scan...'
//                 sh 'trivy fs --output trivy-report.txt --severity HIGH,CRITICAL .'
//             }
//         }

//         stage('Sonar Analysis') {
//             environment {
//                 SCANNER_HOME = tool 'sonar-scanner'
//             }
//             steps {
//                 withSonarQubeEnv('sonarserver') {
//                     sh '''
//                         $SCANNER_HOME/bin/sonar-scanner \
//                         -Dsonar.organization=sonarproject456 \
//                         -Dsonar.projectName=jenkins \
//                         -Dsonar.projectKey=sonarproject456_jenkins \
//                         -Dsonar.java.binaries=. \
//                         -Dsonar.exclusions=**/trivy-report.txt
//                     '''
//                 }
//             }
//         }

//         stage('Maven Package') {
//             steps {
//                 echo 'Packaging the project...'
//                 sh 'mvn package'
//             }
//         }

//         stage('Build Docker Image') {
//             steps {
//                 echo 'Building Docker image...'
//                 script {
//                     docker.build("${IMAGE_NAME}:${BUILD_TAG}")
//                 }
//             }
//         }

//         stage('Login to Azure Container Registry') {
//             steps {
//                 withCredentials([usernamePassword(credentialsId: 'azure-credentials', usernameVariable: 'AZURE_USERNAME', passwordVariable: 'AZURE_PASSWORD')]) {
//                     script {
//                         echo "Logging into Azure Container Registry..."
//                         sh '''
//                             az login --service-principal -u "$AZURE_USERNAME" -p "$AZURE_PASSWORD" --tenant "$TENANT_ID"
//                             az acr login --name dockerregnodejss
//                         '''
//                     }
//                 }
//             }
//         }

//         stage('Push Docker Image to ACR') {
//             steps {
//                 script {
//                     echo 'Pushing Docker image to Azure Container Registry...'
//                     sh '''
//                         docker tag ${IMAGE_NAME}:${BUILD_TAG} ${FULL_IMAGE_NAME}
//                         docker push ${FULL_IMAGE_NAME}
//                     '''
//                 }
//             }
//         }
//       stage('Login to Kuberetes') {
//             steps {
//                 withCredentials([usernamePassword(credentialsId: 'azure-credentials', usernameVariable: 'AZURE_USERNAME', passwordVariable: 'AZURE_PASSWORD')]) {
//                     script {
//                         echo "Logging into Azure kubernetes Service..."
//                         sh '''
//                             az login --service-principal -u "$AZURE_USERNAME" -p "$AZURE_PASSWORD" --tenant "$TENANT_ID"
//                             az aks get-credentials --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME
//                         '''
//                     }
//                 }
//             }
//         }
//         stage('Deploy to Kubernetes') {
//             steps {
//                 script {
//                     echo 'Deploying to Kubernetes...'
//                     sh '''
//                         kubectl apply -f k8s/petclinic.yml
//                     '''
//                 }
//             }
//         }
//     }
// }
