@Library('flask-hello-world-shared-lib') _

pipeline {
    agent any
    environment {
        REGISTRY_URL = "registry.digitalocean.com/kubernetes-image-registry-flask-app"
        IMAGE_NAME = "flask-hello-world"
    }

    stages {
        stage('Checkout') {
            steps {
                checkoutrepo('main', 'https://github.com/Pavanrathod57/python-ci-k8s-iac.git', 'Pavanrathod57')
            }
        }

        stage('Build & Push Image') {
            steps {
                buildandpushimage(REGISTRY_URL, IMAGE_NAME)
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                deploytok8s(REGISTRY_URL, IMAGE_NAME)
            }
        }

        stage('Verify') {
            steps {
                verifydeployment()
            }
        }
    }

    post {
        always {
            cleanupworkspace()
        }
    }
}
