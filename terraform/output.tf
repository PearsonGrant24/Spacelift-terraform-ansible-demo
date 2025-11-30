# output "instance_public_ips" {
#     value = {
#         for env in distinct(values(aws_instance.server_1)[*].tags.Environment) :
#         env => [for k, inst in aws_instance.server_1 : inst.public_ip if inst.tags.Environment == env]
#     }
  
# }

output "instance_public_ips" {
  value = module.ec2.public_ips_by_env
}
