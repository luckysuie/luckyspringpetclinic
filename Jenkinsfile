pipeline {
    agent any

    tools {
        maven 'maven' // Make sure this matches the Maven tool name in Jenkins
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

        stage('SonarCloud Analysis') {
            environment {
                SCANNER_HOME = tool 'sonar-scanner'
            }
            steps {
                withSonarQubeEnv('sonarserver') {
                    sh '''
                        $SCANNER_HOME/bin/sonar-scanner \
                        -Dsonar.organization=sonarproject456 \
                        -Dsonar.projectName=jenkins \
                        -Dsonar.projectKey=sonarproject456_jenkins789 \
                        -Dsonar.sources=src \
                        -Dsonar.java.binaries=target/classes \
                        -Dsonar.host.url=https://sonarcloud.io
                    '''
                }
            }
        }

        stage('Publish Sonar Report') {
            steps {
                echo 'Publishing SonarCloud report...'
                withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_TOKEN')]) {
                    sh '''
                        mvn clean verify sonar:sonar \
                        -Dsonar.projectKey=sonarproject456_jenkins789 \
                        -Dsonar.organization=sonarproject456 \
                        -Dsonar.host.url=https://sonarcloud.io \
                        -Dsonar.login=$SONAR_TOKEN \
                        -Dsonar.qualitygate.wait=false
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh '''
                    docker build -t ${ImageName}:${BUILD_TAG} .
                '''
            }
        }
        stage('Login to ACR and Push Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'azure-sp', usernameVariable: 'AZURE_USERNAME', passwordVariable: 'AZURE_PASSWORD'),
                string(credentialsId: 'azure-tenant', variable: 'TENANT_ID')]) {
                    script {
                        echo "Logging into Azure Container Registry..."
                        sh '''
                            az login --service-principal -u "$AZURE_USERNAME" -p "$AZURE_PASSWORD" --tenant "$TENANT_ID"
                            az acr login --name luckyregistry
                            docker push luckyregistry.azurecr.io/${ImageName}:${BUILD_TAG}
                        '''
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    echo 'Deploying to Kubernetes...'
                    sh '''
                        az aks get-credentials --resource-group LUCKY --name demo-aks
                        kubectl apply -f k8s/petclinic.yml
                    '''
                }
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
