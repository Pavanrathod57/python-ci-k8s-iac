def call() {
    def imageTag = env.BUILD_NUMBER

    def deployApproval = input(
        message: "Do you want to deploy the pipeline to Kubernetes?",
        ok: "Yes, Deploy",
        parameters: [
            booleanParam(defaultValue: false, description: 'Check to deploy', name: 'DEPLOY')
        ]
    )

    if (deployApproval) {
        withCredentials([file(credentialsId: env.KUBECONFIG_CRED, variable: 'KUBECONFIG_FILE')]) {
            sh """
            export KUBECONFIG="\$KUBECONFIG_FILE"
            sed -i "s|${env.REGISTRY_URL}/${env.IMAGE_NAME}:latest|${env.REGISTRY_URL}/${env.IMAGE_NAME}:${imageTag}|g" kubernetes/deployment.yaml || true
            kubectl apply -f kubernetes/service.yaml
            kubectl apply -f kubernetes/ingress.yaml
            kubectl apply -f kubernetes/configmap.yml
            kubectl apply -f kubernetes/deployment.yaml
            """
        }
    } else {
        echo "Deployment skipped by user."
    }
}
