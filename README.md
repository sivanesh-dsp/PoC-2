## Run this sequence of terraform commands

1. `terraform init`
2. `terraform apply -target=module.docker_setup -auto-approve`
3. `terraform apply -target=module.jenkins_setup -auto-approve`
4. `terraform apply -target=module.sonarqube_setup -auto-approve`

   ( Complete the manual setup of jenkins and sonarqube )
5. `terraform apply -auto-approve`
