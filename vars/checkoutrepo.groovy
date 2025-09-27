def call(String branch, String repoUrl, String credentialsId) {
    git branch: branch,
        url: repoUrl,
        credentialsId: credentialsId
}
