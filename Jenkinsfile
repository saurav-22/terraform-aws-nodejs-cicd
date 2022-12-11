pipeline{
    agent any
    parameters {
        text(name: "branch", defaultValue: "main")
    }
    environment {
        AWS_DEFAULT_REGION="ap-south-1"
    }
    stages{
        stage('GIT Checkout'){
            steps{
                 sh label: '', script: '''
                    mkdir -p ${branch}
                    rm -rf ${branch}/*'''
            		dir("${branch}"){
            		    // Get node app code from a GitHub repository
                        git branch: "${branch}", url: 'https://github.com/saurav-22/saurav-upgrad-assignment.git'
            			sh "rm -rf .git"
            		}
                }    
            }
            stage('Docker Image build and push to ECR'){
                steps{
		            dir("${branch}"){	
			            script { 
                            try  {
			                docker.withRegistry("public.ecr.aws/y2j8x9n3/saurav-node-app") {
    				            sh '''
                    				cd ${branch}
                    				docker build -t saurav-node-app .
                    				docker tag saurav-node-app:latest public.ecr.aws/y2j8x9n3/saurav-node-app:latest
                    				docker push public.ecr.aws/y2j8x9n3/saurav-node-app:latest
    				            '''
			                    }
				            }  catch (Exception err) {
						    echo "Build is failed"
					    	echo err
						    script { BUILDFAIL = 'TRUE' 
						        currentBuild.result = 'FAILURE'
						    } }
			            }
                    }
                }
            }
        }
}
