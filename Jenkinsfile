pipeline{
    agent any

    tools{
        maven 'maven'
        jdk 'java'
    }
    
    environment{
        FILE_PATH = 'Java-App/demo (2)/demo/pom.xml'
    }

    stages{
        stage('checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/rajnages/Jenkins-Master.git'
            }
        }
        stage('Build'){
            steps{
                sh """
                cd $FILE_PATH
                mvn clean package
                """
            }
        }
        stage('Test'){
            steps{
                sh """
                cd $FILE_PATH
                mvn test
                """
            }
        }
        stage('Deploy'){
            steps{
                sh """
                cd $FILE_PATH
                mvn deploy
                """
            }
        }
    }

    post{
        always{
            junit 'target/surefire-reports/*.xml'
            cleanWs()
        }
        success{
            echo 'Build and deploy process completed successfully!'
        }
        failure{
            echo 'There was an issue with the build or deployment.'
        }

    }
}