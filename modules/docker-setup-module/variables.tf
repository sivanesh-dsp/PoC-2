variable "docker_gpg_key_url" {
  description = "URL for Docker's GPG key."
  type        = string
  default     = "https://download.docker.com/linux/ubuntu/gpg"
}

variable "docker_repo_url" {
  description = "URL for Docker's repository."
  type        = string
  default     = "https://download.docker.com/linux/ubuntu"
}

variable "docker_packages" {
  description = "List of Docker packages to install."
  type        = list(string)
  default     = [
    "docker-ce",
    "docker-ce-cli",
    "containerd.io",
    "docker-buildx-plugin",
    "docker-compose-plugin"
  ]
}
