output "jenkins_initial_admin_password" {
  value       = module.jenkins_setup.jenkins_initial_admin_password
  description = "The initial admin password for Jenkins."
}