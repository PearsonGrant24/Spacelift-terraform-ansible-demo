
output "public_ips_by_env" {
  value = {
    for env in distinct([for i in aws_instance.servers : i.tags["Environment"]]) :
    env => [
      for inst in aws_instance.servers :
      inst.public_ip
      if inst.tags["Environment"] == env
    ]
  }
}
