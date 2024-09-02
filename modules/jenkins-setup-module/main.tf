terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.1"
    }
  }
}

resource "null_resource" "jenkins_install" {
  provisioner "local-exec" {
    command = <<EOF
    sudo apt-get update

    # Install Java (Jenkins requires Java)
    echo "Installing Java..."
    sudo apt-get install -y ${var.java_version}

    # Verify Java
    echo "Verifying Java"
    java -version

    echo "Adding Jenkins repository key..."
    curl -fsSL ${var.jenkins_repo_key_url} | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

    # Add Jenkins repository
    echo "Adding Jenkins repository..."
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] ${var.jenkins_repo_url} binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

    # Update package index again
    echo "Updating package index..."
    sudo apt-get update

    # Install Jenkins
    echo "Installing Jenkins..."
    sudo apt-get install -y jenkins

    # Start Jenkins service
    echo "Starting Jenkins..."
    sudo systemctl start jenkins

    # Enable Jenkins to start on boot
    echo "Enabling Jenkins to start on boot..."
    sudo systemctl enable jenkins

    # Add Jenkins user to Docker group
    echo "Adding Jenkins user to Docker group..."
    sudo usermod -aG docker jenkins

    # Restart Jenkins
    echo "Restarting Jenkins..."
    sudo systemctl restart jenkins

    # Display initial Jenkins admin password
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword > /tmp/initialAdminPassword.txt
    EOF
  }
}

data "local_file" "jenkins_initial_admin_password" {
  filename = "/tmp/initialAdminPassword.txt"
  depends_on = [null_resource.jenkins_install]
}
