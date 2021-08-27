provider "google" {

  version = "~> 3.0"
}

module "instance_template" {
  source          = "../../../modules/instance_template"
  region          = var.region
  project_id      = var.project_id
  subnetwork      = var.subnetwork
  service_account = var.service_account
}

module "compute_instance" {
  source            = "../../../modules/compute_instance"
  region            = var.region
  zone              = var.zone
  subnetwork        = var.subnetwork
  num_instances     = var.num_instances
  hostname          = "instance-simple"
  instance_template = module.instance_template.self_link
  access_config = [{
    nat_ip       = var.nat_ip
    network_tier = var.network_tier
  }, ]
}