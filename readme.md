## Inspec with GCP

Testing your images with inspec & packer

### Something to test

Throwing up a GCE instance with a bootscript that installs LAMP

### Generate some keys because inspec doesnt integrate with gcloud-ssh

`gcloud auth application-default login`
`packer build -var "sshkey=$(cat sshkey.pub)" -var "project_id=$SANDBOX" -var subnetwork=default packer.pkr.hcl`