variable "project_id" { type = string }
variable "subnetwork" { type = string }
variable "sshkey" { type = string }

source "googlecompute" "inspec-test" {
  project_id = "${var.project_id}"
  source_image_family = "centos-7"
  ssh_username = "packer"
  zone = "europe-west2-a"
  subnetwork = "${var.subnetwork}"
  metadata = {
        enable-oslogin = "false",
        ssh-keys = "packer:${var.sshkey}"
  }
  startup_script_file = "boot.sh"
}

build {
  sources = [
    "source.googlecompute.inspec-test"
  ]

  provisioner "shell-local" {
    environment_vars = ["BUILDER=${build.Host}"]
    command = "docker run --rm -v $LOCAL_WORKSPACE_FOLDER/tests:/workspace -w /workspace chef/inspec:4.41.7 detect -t ssh://packer@$BUILDER -i sshkey"
  }
}