pipeline {
    agent any

    environment {
        // Define environment variables if needed (e.g., Java version, Maven home)
        JAVA_HOME = tool name: 'java', type: 'JDK'
        MAVEN_HOME = tool name: 'maven', type: 'Maven'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the repository
                git 'https://github.com/rajnages/Jenkins-Master.git'  // Replace with your repo URL
            }
        }

        stage('Build') {
            steps {
                script {
                    // Clean and compile the project using Maven
                    sh "'${MAVEN_HOME}/bin/mvn' clean install"
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run unit tests using Maven
                    sh "'${MAVEN_HOME}/bin/mvn' test"
                }
            }
        }

        stage('Package') {
            steps {
                script {
                    // Package the application (e.g., creating a .jar file)
                    sh "'${MAVEN_HOME}/bin/mvn' package"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy the application (e.g., to a server, S3, or another environment)
                    // Replace this with your actual deployment steps
                    echo "Deploying the application..."
                    // Example: sh 'scp target/your-app.jar user@server:/path/to/deploy'
                }
            }
        }
    }

    post {
        success {
            echo 'Build and deploy process completed successfully!'
        }
        failure {
            echo 'There was an issue with the build or deployment.'
        }
        always {
            // Clean up actions (e.g., archiving artifacts or sending notifications)
            archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
        }
    }
}
