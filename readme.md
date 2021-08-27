## Inspec with GCP

Testing your images with inspec & packer

### Something to test

Throwing up a GCE instance with a bootscript that installs LAMP

### Quick test with packer

`gcloud auth application-default login`
`packer build -var "sshkey=$(cat sshkey.pub)" -var "project_id=$SANDBOX" -var subnetwork=default packer.pkr.hcl`

### Gitlab CI test

`gitlab-runner register`
`gitlab-runner exec shell .`