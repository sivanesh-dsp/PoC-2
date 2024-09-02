variable "sonarqube_image" {
  description = "The Docker image for SonarQube."
  type        = string
  default     = "sonarqube:10.6-community"
}

variable "sonarqube_container_name" {
  description = "The name of the SonarQube container."
  type        = string
  default     = "sonarqube"
}

variable "sonarqube_ports" {
  description = "Ports to expose for the SonarQube container."
  type        = map(number)
  default     = {
    "9000" = 9000
  }
}

variable "sonarqube_volumes" {
  description = "Mapping of volume names to container paths for SonarQube."
  type        = map(string)
  default     = {
    "sonarqube_data"      = "/opt/sonarqube/data"
    "sonarqube_logs"      = "/opt/sonarqube/logs"
    "sonarqube_extensions" = "/opt/sonarqube/extensions"
  }
}
