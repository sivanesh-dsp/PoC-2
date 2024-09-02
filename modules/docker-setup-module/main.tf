terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.1"
    }
  }
}

resource "null_resource" "docker_install" {
  provisioner "local-exec" {
    command = <<EOF
    # Update the package index
    sudo apt-get update

    # Install required packages
    sudo apt-get install -y ca-certificates curl

    # Create directory for Docker's GPG key
    sudo install -m 0755 -d /etc/apt/keyrings

    # Download Docker's official GPG key
    sudo curl -fsSL ${var.docker_gpg_key_url} -o /etc/apt/keyrings/docker.asc

    # Ensure the key file is readable
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add Docker's repository to Apt sources
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] ${var.docker_repo_url} $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Update the package index again with Docker packages
    sudo apt-get update

    # Install Docker packages
    sudo apt-get install -y ${join(" ", var.docker_packages)}

    # Add the current user to the Docker group
    sudo usermod -aG docker $USER

    # Print Docker version to confirm installation
    sudo docker --version
    EOF
  }
}
