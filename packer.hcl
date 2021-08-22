variable "env" {
  type    = string
  default = "test"
}
# create a GCE instance with some extra config to test
source "googlecompute" "inspec-test" {
  project_id = "{{user `gcp-project`}}"
  source_image_family = "rocky-linux-8"
  ssh_username = "packer"
  zone = "europe-west2-a"
  subnetwork = "default"
  metadata = {
        enable-oslogin = "false",
        ssh-keys = "packer:{{user `sshkey`}}"
  }
  startup_script_file = ".\boot.sh"
}
# build it
build {
  sources = [
    "source.googlecompute.inspec-test"
  ]

# dont use the inspec provisioner - this POC should run in gitlab eventually.
  provisioner "shell-local" {
    environment_vars = ["VMIP=${build.Host}"]
    command = "docker run --rm -v $(pwd):/workspace -w /workspace chef/inspec:4.41.7 detect -t ssh://packer@$VMIP -i sshkey"
  }
}