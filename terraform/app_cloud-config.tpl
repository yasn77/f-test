#cloud-config

apt_sources:
  - source: "deb https://apt.dockerproject.org/repo ubuntu-xenial main"
    keyid: 58118E89F3A912897C070ADBF76221572C52609D
    filename: docker.list

packages:
 - python
 - docker-engine
 - curl
 - git

write_files:
  - content: |
      #!/bin/bash
      cd /src
      git pull -r
      /usr/local/bin/docker-compose -f /src/app/docker-compose.yml up -d --build --force-recreate --scale f-test=3
    path: /usr/local/bin/deploy.sh
    permissions: '0700'

runcmd:
 - [ curl, -L, 'https://github.com/docker/compose/releases/download/1.13.0/docker-compose-Linux-x86_64', -o, /usr/local/bin/docker-compose ]
 - [ curl, 'https://amazon-ssm-eu-west-1.s3.amazonaws.com/latest/debian_amd64/amazon-ssm-agent.deb', -o, /tmp/amazon-ssm-agent.deb ]
 - [ chmod, +x, /usr/local/bin/docker-compose ]
 - [ git, clone, 'https://github.com/yasn77/f-test.git', /src ]
 - [ /usr/local/bin/deploy.sh ]
 - [ dpkg, -i, /tmp/amazon-ssm-agent.deb ]
 - [ systemctl, enable, amazon-ssm-agent ]
 - [ systemctl, start, amazon-ssm-agent ]
 - "echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAlFy0q/SSd+0pGYl4b0ZMchQukW93fY5mSxHVqKPmlUrCKQqWhfCZQF/J1DliL43Uo+vZ4hJTD7HyaWb8rJtd1I9RqJPA37pgsSdZ0cI5YOxDdJ63pDh9DRs8glaC+uaiLj8JO/5ki2q8s9c9v8T1/PtGYudO8Aq51DZIhJSw0eryAMjPUyRMHkeWepNXxwJBn6Nem0RTGm7EnGXev037Ow5U7s1iytN22dDeGjFSH2X52/w7HyeBaWUq604mk3x7B1PMn7eA5YYlkoifSqOOgAyz2Jve711ZsYQjRF8XsYvBYryMIISU2A+JkKKrbdAyID5UImEny7bbLKNNDSpUfQ== t.shobaita@fetchr.us' >> /home/ubuntu/.ssh/authorized_keys"
