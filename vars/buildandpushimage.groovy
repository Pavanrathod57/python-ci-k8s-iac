def call(String registryUrl, String imageName) {
    def imageTag = "${env.BUILD_NUMBER}"
    withCredentials([string(credentialsId: 'do-token', variable: 'DO_TOKEN')]) {
        sh """
        echo "$DO_TOKEN" | docker login --username doctl --password-stdin ${registryUrl}
        docker build -t ${registryUrl}/${imageName}:${imageTag} .
        docker push ${registryUrl}/${imageName}:${imageTag}
        """
    }
}
