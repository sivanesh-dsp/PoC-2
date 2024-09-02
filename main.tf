terraform {
  required_providers {
    jenkins = {
      source = "overmike/jenkins"
      version = "0.6.1"
    }
  }
}

# module "setup" {
#   source = "./modules"
# }


# Define the Docker setup module
module "docker_setup" {
  source = "./modules/docker-setup-module"
}

# Define the Jenkins setup module
module "jenkins_setup" {
  source = "./modules/jenkins-setup-module"
}

#Define the Sonarqube setup module
module "sonarqube_setup" {
    source = "./modules/sonarqube-setup-module"
}



provider "jenkins" {
  server_url = "http://localhost:8080/" 
  username   = "admin"            
  password   = "admin"                             
}

resource "jenkins_job" "example" {
  depends_on = [module.sonarqube_setup]
  name       = "poc2-pipeline"
  template   = file("${path.module}/job.xml")
}


