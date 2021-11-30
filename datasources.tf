## Copyright © 2021, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Get list of availability domains
data "oci_identity_availability_domains" "ADs" {
  compartment_id = var.tenancy_ocid
}

data "oci_identity_region_subscriptions" "home_region_subscriptions" {
  tenancy_id = var.tenancy_ocid

  filter {
    name   = "is_home_region"
    values = [true]
  }
}

# Get the latest Oracle Linux image
data "oci_core_images" "BastionInstanceImageOCID" {
  compartment_id           = var.compartment_ocid
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version
  shape                    = var.BastionInstanceShape

  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}

# Get the latest Oracle Linux image
data "oci_core_images" "WebserverInstanceImageOCID" {
  compartment_id           = var.compartment_ocid
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version
  shape                    = var.WebserverInstanceShape

  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}

#Get list of MySQL configuration
data "oci_mysql_mysql_configurations" "mds_mysql_configurations" {
  compartment_id = var.use_cloud_guard ? var.compartment_SZ_ocid : var.compartment_ocid
  type           = ["DEFAULT"]
  shape_name     = var.mysql_shape_name
}


data "oci_cloud_guard_cloud_guard_configuration" "test_cloud_guard_configuration" {
  #Required
  compartment_id = var.compartment_ocid
}


data "oci_cloud_guard_detector_recipes" "list_detector_recipes" {
  provider       = oci.homeregion
  compartment_id = var.tenancy_ocid
  state          = var.detector_recipe_state
  display_name   = "OCI Configuration Detector Recipe"

  depends_on = [oci_cloud_guard_cloud_guard_configuration.enable_cloud_guard]
  #depends_on = [oci_cloud_guard_cloud_guard_configuration.vcn01_cloud_guard_configuration]
}

data "oci_cloud_guard_responder_recipes" "list_responder_recipes" {
  provider       = oci.homeregion
  compartment_id = var.tenancy_ocid
  state          = var.responder_recipe_state
  display_name   = "OCI Responder Recipe"

  depends_on = [oci_cloud_guard_cloud_guard_configuration.enable_cloud_guard]
  #depends_on = [oci_cloud_guard_cloud_guard_configuration.vcn01_cloud_guard_configuration]
}

data "oci_cloud_guard_target" "test_target" {
  count     = var.use_cloud_guard ? 1 : 0
  target_id = oci_cloud_guard_target.test_target[count.index].id
}

data "template_file" "key_script" {
  template = file("./scripts/sshkey.tpl")
  vars = {
    ssh_public_key = tls_private_key.public_private_key_pair.public_key_openssh
  }
}

data "template_cloudinit_config" "cloud_init" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "ainit.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.key_script.rendered
  }
}
