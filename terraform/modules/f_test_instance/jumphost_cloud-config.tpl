#cloud-config

packages:
 - python
 - curl

runcmd:
 - "echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAlFy0q/SSd+0pGYl4b0ZMchQukW93fY5mSxHVqKPmlUrCKQqWhfCZQF/J1DliL43Uo+vZ4hJTD7HyaWb8rJtd1I9RqJPA37pgsSdZ0cI5YOxDdJ63pDh9DRs8glaC+uaiLj8JO/5ki2q8s9c9v8T1/PtGYudO8Aq51DZIhJSw0eryAMjPUyRMHkeWepNXxwJBn6Nem0RTGm7EnGXev037Ow5U7s1iytN22dDeGjFSH2X52/w7HyeBaWUq604mk3x7B1PMn7eA5YYlkoifSqOOgAyz2Jve711ZsYQjRF8XsYvBYryMIISU2A+JkKKrbdAyID5UImEny7bbLKNNDSpUfQ== t.shobaita@fetchr.us' >> /home/ubuntu/.ssh/authorized_keys"
