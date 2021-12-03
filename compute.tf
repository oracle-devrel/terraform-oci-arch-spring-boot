## Copyright © 2021, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_core_instance" "webserver" {
  count               = var.numberOfNodes
  availability_domain = var.availability_domain_name == "" ? data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain_number]["name"] : var.availability_domain_name
  compartment_id      = var.compartment_ocid
  fault_domain        = "FAULT-DOMAIN-${(count.index % 3) + 1}"
  display_name        = "SpringBootAppServer${count.index}"
  shape               = var.WebserverInstanceShape

  dynamic "shape_config" {
    for_each = local.is_flexible_webserver_instance_shape ? [1] : []
    content {
      memory_in_gbs = var.WebserverInstanceFlexShapeMemory
      ocpus         = var.WebserverInstanceFlexShapeOCPUS
    }
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.vcn01_subnet_app01.id
    display_name     = "primaryvnic"
    assign_public_ip = false
    nsg_ids          = [oci_core_network_security_group.SSHSecurityGroup.id, oci_core_network_security_group.APPSecurityGroup.id]
  }

  source_details {
    source_type             = "image"
    source_id               = lookup(data.oci_core_images.WebserverInstanceImageOCID.images[0], "id")
    boot_volume_size_in_gbs = "50"
  }

  dynamic "agent_config" {
    for_each = var.use_bastion_service ? [1] : []
    content {
      are_all_plugins_disabled = false
      is_management_disabled   = false
      is_monitoring_disabled   = false
      plugins_config {
        desired_state = "ENABLED"
        name          = "Bastion"
      }
    }
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data           = data.template_cloudinit_config.cloud_init.rendered
  }

  # Needed for bastion agent to start on the compute
  provisioner "local-exec" {
    command = "sleep 240"
  }

  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}



data "oci_core_vnic_attachments" "webserver_primaryvnic_attach" {
  count               = var.numberOfNodes
  availability_domain = var.availability_domain_name == "" ? data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain_number]["name"] : var.availability_domain_name
  compartment_id      = var.compartment_ocid
  instance_id         = oci_core_instance.webserver[count.index].id
}

data "oci_core_vnic" "webserver_primaryvnic" {
  count   = var.numberOfNodes
  vnic_id = data.oci_core_vnic_attachments.webserver_primaryvnic_attach[count.index].vnic_attachments.0.vnic_id
}

