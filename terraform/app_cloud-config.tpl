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
  - contents: |
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
