def call() {
    withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG_FILE')]) {
        sh '''
        export KUBECONFIG="$KUBECONFIG_FILE"
        kubectl rollout status deployment/flask-hello-world --timeout=120s
        SERVICE_IP=$(kubectl get svc flask-hello-world-lb -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
        if [ -z "$SERVICE_IP" ]; then
            echo "Service external IP not assigned yet. Listing service:"
            kubectl get svc
            exit 0
        fi
        echo "Hitting http://$SERVICE_IP/"
        curl -fsS "http://$SERVICE_IP/" || (echo "curl failed"; exit 1)
        '''
    }
}
