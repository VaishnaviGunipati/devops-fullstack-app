pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = "us-east-1"
        FRONTEND_IMAGE = "sample-frontend"
        BACKEND_IMAGE = "sample-backend"
        FRONTEND_ECR = "your-aws-account-id.dkr.ecr.us-east-1.amazonaws.com/frontend-repo"
        BACKEND_ECR = "your-aws-account-id.dkr.ecr.us-east-1.amazonaws.com/backend-repo"
    }

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/TechVerito-Software-Solutions-LLP/devops-fullstack-app.git'
            }
        }

        stage('Build Docker Images') {
            steps {
                sh '''
                docker build -t $FRONTEND_IMAGE ./frontend
                docker build -t $BACKEND_IMAGE ./backend
                '''
            }
        }

        stage('Tag & Push to ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $(echo $FRONTEND_ECR | cut -d'/' -f1)
                docker tag $FRONTEND_IMAGE:latest $FRONTEND_ECR:latest
                docker tag $BACKEND_IMAGE:latest $BACKEND_ECR:latest
                docker push $FRONTEND_ECR:latest
                docker push $BACKEND_ECR:latest
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                kubectl apply -f k8s/backend-deployment.yaml
                kubectl apply -f k8s/frontend-deployment.yaml
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Deployment completed successfully!"
        }
        failure {
            echo "❌ Build or Deployment failed."
        }
    }
}
