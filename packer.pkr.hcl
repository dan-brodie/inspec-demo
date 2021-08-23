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
  provisioner "inspec" {
      inspec_env_vars = [ "CHEF_LICENSE=accept"]
      profile = "tests/inspec/"
  }
}