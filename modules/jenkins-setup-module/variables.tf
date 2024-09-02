variable "java_version" {
  description = "The version of Java to install for Jenkins."
  type        = string
  default     = "openjdk-17-jre"
}

variable "jenkins_repo_key_url" {
  description = "URL for the Jenkins repository key."
  type        = string
  default     = "https://pkg.jenkins.io/debian/jenkins.io-2023.key"
}

variable "jenkins_repo_url" {
  description = "URL for the Jenkins repository."
  type        = string
  default     = "https://pkg.jenkins.io/debian"
}