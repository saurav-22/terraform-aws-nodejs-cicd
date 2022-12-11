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
					        aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/y2j8x9n3
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
	    stage('Run container in app host'){
                steps{
		            dir("${branch}"){	
			            script { 
                            try  {
    				            sh '''
                    				ssh ec2-user@10.0.3.124
                                    docker pull public.ecr.aws/y2j8x9n3/saurav-node-app:latest
                                    docker run -p 8080:8080 saurav-node-app:latest
    				            '''
			                    }
				              catch (Exception err) {
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
