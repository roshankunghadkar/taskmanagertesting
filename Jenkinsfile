pipeline{
    agent any
    tools {
        terraform 'Terraform'
    }
    stages {
        
        stage('git checkout'){
            steps{
                git credentialsId: 'jenkins-gitlab', url: 'https://gitlab.com/roshankunghadkar/taskmanagertesting.git'
            }
        }
        stage('Example') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'azure-creds', passwordVariable: 'PW', usernameVariable: 'ID')]) {
                            sh 'az login -u $ID -p $PW'
                        }
                
            }
                   
        }
        stage('terraform init'){
            steps{
                sh 'terraform init'
            }
        }
        stage('terraform apply'){
            steps{
                sh 'terraform apply -var="resourcegroup=${ResourceGroup}" -var="location=${Location}" -var="vmname=${VMname}" --auto-approve'
            }
        }
        stage('fetching ip from tf-backup file'){
            steps{
                sh 'sh ip_fetch.sh'
            }
        }
        stage('running test cases'){
            steps{
                catchError(buildResult: 'FAILURE', stageResult: 'FAILURE'){
                    sh '''python3 -m rflint --ignore LineTooLong /var/lib/jenkins/workspace/TestAutomation-PoC'''
                    sh '''python3 -m robot --outputdir /var/lib/jenkins/workspace/Robot-reports TestCases/'''
                    //sh '''python3 -m robot --outputdir /var/lib/jenkins/workspace/Robot-reports TestCases/02_Login_Test_Case.robot'''
                    sh 'exit 0'

                }
                
            }
        }
        stage('display test reports'){
            steps{
                publishHTML (target : [allowMissing: false,
                         alwaysLinkToLastBuild: true,
                         keepAll: true,
                         reportDir: '/var/lib/jenkins/workspace/Robot-reports',
                         reportFiles: 'log.html',
                         reportName: 'Test Reports',
                         reportTitles: 'The Report'])
            }
        }
    }
    post{
        failure{
            echo 'something failed - message from echo'
            error 'test case failed'
            
        }
        success {
            echo 'test cases passed - infra will be destroyed'
            sh 'terraform destroy --auto-approve'
            
            cleanWs()
            
        }
    
    }
}
