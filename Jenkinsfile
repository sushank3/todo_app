pipeline{
    agent any

    stages {

        stage("Build docker file and push"){

            environment {
                DOCKER_IMAGE = "sushank3/todo_app:v${BUILD_NUMBER}"
                REGISTRY_CREDENTIALS = credentials('dockerhub')
            }

            steps{

                script {
                    sh "docker build -t ${DOCKER_IMAGE} ."
                    def dockerImage = docker.image("${DOCKER_IMAGE}")
                    docker.withRegistry("https://index.docker.io/v1/", "dockerhub") {
                        dockerImage.push()
                    }

                    slackSend(
                        color: '#36a64f',  
                        message: "Docker build ${env.BUILD_NUMBER} succeeded!",  
                        tokenCredentialId: 'slack-jenkins'  
                    )
                }
            }
        }

        // stage('Update Deployment File') {

        //     environment {
        //         GITLAB_PROJECT_NAME = "CI_CD-portfolio"
        //         GITLAB_USERNAME = "sushank3"
        //     }
        
        //     steps {
        //         sh 'echo passed'
        //         git branch: 'main', url: 'https://gitlab.com/sushank3/ci_cd-portfolio.git'
        //         withCredentials([string(credentialsId: 'github-cred', variable: 'GITLAB_TOKEN')]) {
        //             sh '''
        //                 git config user.email "sushankkr3@gmail.com"
        //                 git config user.name "sushank3"
                        
        //                 BUILD_NUMBER="${BUILD_NUMBER}"

        //                 CURRENT_IMAGE_VERSION=$(grep -oE 'sushank3/ci_cd-portfolio:v[0-9]+' deployment.yaml | cut -d':' -f2)
        //                 sed -i "s/${CURRENT_IMAGE_VERSION}/v${BUILD_NUMBER}/g" deployment.yaml
        //                 git add deployment.yaml
                        
        //                 git commit -m "Update deployment image to version ${BUILD_NUMBER}"
                        
        //                 git push "https://oauth2:${GITLAB_TOKEN}@gitlab.com/${GITLAB_USERNAME}/${GITLAB_PROJECT_NAME}" HEAD:main


        //             '''

        //         }

        //         script {
        //             slackSend(
        //                 color: '#36a64f',  
        //                 message: "Final Build ${env.BUILD_NUMBER} succeeded! and deployment file updated with new version",  
        //                 tokenCredentialId: 'slack-jenkins'  
        //             )
        //         }
        //     }
        // }
    }
    
}