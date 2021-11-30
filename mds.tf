## Copyright © 2021, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_mysql_mysql_db_system" "mds01_mysql_db_system" {
  #Required
  admin_password          = var.mysql_db_system_admin_password
  admin_username          = var.mysql_db_system_admin_username
  availability_domain     = data.oci_identity_availability_domains.ADs.availability_domains[0]["name"]
  compartment_id          = var.use_cloud_guard ? var.compartment_SZ_ocid : var.compartment_ocid
  configuration_id        = data.oci_mysql_mysql_configurations.mds_mysql_configurations.configurations[0].id
  shape_name              = data.oci_mysql_mysql_configurations.mds_mysql_configurations.configurations[0].shape_name
  subnet_id               = oci_core_subnet.vcn02_subnet_db01.id
  data_storage_size_in_gb = var.mysql_db_system_data_storage_size_in_gb
  display_name            = var.mysql_db_system_display_name
  hostname_label          = var.mysql_db_system_hostname_label
  defined_tags            = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
