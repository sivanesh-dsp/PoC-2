output "jenkins_initial_admin_password" {
  value       = data.local_file.jenkins_initial_admin_password.content
  description = "The initial admin password for Jenkins."
}