pipeline {
    agent any

    environment {
        FRONTEND_IMAGE = "sample-frontend"
        BACKEND_IMAGE = "sample-backend"
    }

    stages {

        stage('Checkout') {
            steps {
                echo "📦 Checking out source code from your repo..."
                git branch: 'main', url: 'https://github.com/VaishnaviGunipati/devops-fullstack-app.git'
            }
        }

        stage('Build Docker Images') {
            steps {
                echo "🐳 Building Docker images for frontend and backend..."
                sh '''
                docker build -t $FRONTEND_IMAGE ./frontend
                docker build -t $BACKEND_IMAGE ./backend
                '''
            }
        }

        stage('Run Containers for Testing') {
            steps {
                echo "🧪 Running both containers locally for quick test..."
                sh '''
                docker run -d -p 80:80 --name frontend-test $FRONTEND_IMAGE
                docker run -d -p 8080:8080 --name backend-test $BACKEND_IMAGE
                '''
            }
        }

        stage('Deploy to Kubernetes (K3s)') {
            steps {
                echo "🚀 Deploying frontend and backend to K3s cluster..."
                sh '''
                kubectl apply -f k8s/backend-deployment.yaml
                kubectl apply -f k8s/frontend-deployment.yaml
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline executed successfully! App deployed on K3s."
        }
        failure {
            echo "❌ Pipeline failed. Check console output for details."
        }
        always {
            echo "🧹 Cleaning up local test containers..."
            sh '''
            docker rm -f frontend-test || true
            docker rm -f backend-test || true
            '''
        }
    }
}
