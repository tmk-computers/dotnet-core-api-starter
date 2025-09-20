pipeline {
    agent any

    environment {
        APP_NAME = "tmkapi"
        GIT_REPO = "http://github.com/tmk-computers/backend-api-starter"
        DEPLOY_DIR = "/home/root/tmkapi-prod" // Path on VPS with docker-compose.prod.yml
        VPS_IP = "72.60.111.143"
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Cloning repository..."
                git branch: 'main', url: "${GIT_REPO}"
            }
        }

        stage('Deploy to VPS') {
            steps {
                echo "Deploying to production VPS..."
                // SSH into VPS, pull latest code, build image, and run containers
                sh """
                ssh root@${VPS_IP} '
                    cd ${DEPLOY_DIR} &&
                    git pull origin main &&
                    docker compose up -d --build
                '
                """
            }
        }

        stage('Cleanup') {
            steps {
                echo "Removing dangling Docker images on VPS..."
                sh """
                ssh root@${VPS_IP} '
                    docker image prune -f
                '
                """
            }
        }
    }

    post {
        success {
            echo 'Production deployment completed successfully!'
        }
        failure {
            echo 'Deployment failed. Check logs.'
        }
    }
}