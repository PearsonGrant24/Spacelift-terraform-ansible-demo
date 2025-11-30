variable "vpc_id" {
  type = string
}
variable "app_name" {
    type        = string
    default     = "terraform-ansible"
    description = "Name of the application"  
}