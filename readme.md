## Inspec with GCP

### Something to test

Throwing up a GCE instance with a bootscript that installs LAMP

### Generate some keys because inspec doesnt integrate with gcloud-ssh

ssh-keygen -f sshkey -C packer -N '' -m PEM
packer build -var sshkey=$(cat sshkey.pub) packer.hcl

