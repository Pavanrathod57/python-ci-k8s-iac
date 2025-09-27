def call() {
    def imageTag = env.BUILD_NUMBER

    withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG_FILE')]) {
        sh """
        export KUBECONFIG="\$KUBECONFIG_FILE"
        sed -i "s|${env.REGISTRY_URL}/${env.IMAGE_NAME}:latest|${env.REGISTRY_URL}/${env.IMAGE_NAME}:${imageTag}|g" kubernetes/deployment.yaml || true
        kubectl apply -f kubernetes/service.yaml
        kubectl apply -f kubernetes/ingress.yaml
        kubectl apply -f kubernetes/configmap.yml
        kubectl apply -f kubernetes/deployment.yaml
        """
    }
}
