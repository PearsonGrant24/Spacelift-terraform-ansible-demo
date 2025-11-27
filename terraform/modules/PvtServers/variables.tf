locals {
  environments = {
    dev   = 2
    stage = 2
    prod  = 2
  }

  instances = flatten([
    for env, count in local.environments : [
        for i in range(count) : {
            name = "${env}-${i + 1}"
            env  = env
        }
    ]
  ])
}