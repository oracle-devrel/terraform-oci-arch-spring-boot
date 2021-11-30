## Copyright © 2021, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {}
variable "region" {}
variable "compartment_ocid" {}
variable "compartment_SZ_ocid" {
  default = ""
}
#variable "user_ocid" {}
#variable "fingerprint" {}
#variable "private_key_path" {}

variable "ssh_public_key" {
  default = ""
}

variable "springboot_download_url" {
  default = "https://github.com/oracle-devrel/terraform-oci-arch-spring-boot/releases/latest/download/ocispringbootdemo-0.0.1-SNAPSHOT.jar"
}

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.0.2"
}

variable "availability_domain_name" {
  default = ""
}
variable "availability_domain_number" {
  default = 0
}

variable "use_bastion_service" {
  default = false
}

variable "use_cloud_guard" {
  default = true
}

variable "cloud_guard_configuration_status" {
  default = "ENABLED"
}
variable "target1_display_name" {
  default = "Non_SZ_Compartment"
}

variable "target2_display_name" {
  default = "SZ_Compartment"
}

variable "detector_recipe1_display_name" {
  default = "test1-detector"
}

variable "responder_recipe1_display_name" {
  default = "test1-responder"
}

variable "detector_recipe2_display_name" {
  default = "test2-detector"
}

variable "responder_recipe2_display_name" {
  default = "test2-responder"
}

variable "igw_display_name" {

  default = "internet-gateway"
}

variable "vcn01_cidr_block" {
  default = "10.0.0.0/16"
}
variable "vcn01_dns_label" {
  default = "vcn01"
}
variable "vcn01_display_name" {
  default = "vcn01"
}

variable "vcn01_subnet_pub01_cidr_block" {
  default = "10.0.1.0/24"
}

variable "vcn01_subnet_pub01_display_name" {
  default = "vcn01_subnet_pub01"
}

variable "vcn01_subnet_pub02_cidr_block" {
  default = "10.0.2.0/24"
}

variable "vcn01_subnet_pub02_display_name" {
  default = "vcn01_subnet_pub02"
}

variable "vcn01_subnet_app01_cidr_block" {
  default = "10.0.10.0/24"
}

variable "vcn01_subnet_app01_display_name" {
  default = "vcn01_subnet_app01"
}

variable "vcn02_cidr_block" {
  default = "11.0.0.0/16"
}
variable "vcn02_dns_label" {
  default = "vcn02"
}
variable "vcn02_display_name" {
  default = "vcn02"
}

variable "vcn02_subnet_db01_cidr_block" {
  default = "11.0.20.0/24"
}

variable "vcn02_subnet_db01_display_name" {
  default = "vcn02_subnet_db01"
}

variable "lb_shape" {
  default = "flexible"
}

variable "flex_lb_min_shape" {
  default = "10"
}

variable "flex_lb_max_shape" {
  default = "100"
}

# OS Images
variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "7.9"
}

variable "BastionInstanceShape" {
  default = "VM.Standard.E3.Flex"
}

variable "BastionInstanceFlexShapeOCPUS" {
  default = 1
}

variable "BastionInstanceFlexShapeMemory" {
  default = 1
}

variable "WebserverInstanceShape" {
  default = "VM.Standard.E3.Flex"
}

variable "WebserverInstanceFlexShapeOCPUS" {
  default = 1
}

variable "WebserverInstanceFlexShapeMemory" {
  default = 10
}

variable "numberOfNodes" { default = 3 }

variable "mysql_shape_name" {
  default = "MySQL.VM.Standard.E3.1.8GB"
}

variable "mysql_db_system_admin_password" {
  default = ""
}
variable "mysql_db_system_admin_username" {
  default = "admin"
}

variable "mysql_db_system_backup_policy_is_enabled" {
  default = "NO"
}
variable "mysql_db_system_data_storage_size_in_gb" {
  default = "50"
}
variable "mysql_db_system_display_name" {
  default = "AppDB"
}
variable "mysql_db_system_hostname_label" {
  default = "AppDB1"
}


########################################################
variable "detector_recipe_access_level" {
  default = "ACCESSIBLE"
}

variable "detector_recipe_compartment_id_in_subtree" {
  default = true
}
//Refer to the note in managed_list.tf for the above two variables

variable "detector_recipe_defined_tags_value" {
  default = "value"
}

variable "detector_recipe1_description" {
  default = "description"
}
variable "detector_recipe2_description" {
  default = "description"
}
/*
The configuration and condition Objects are dependent on the rule id.
Hence for testing purposes we are going to hardcode a rule id and
corresponding valid condition and configuration
*/
variable "detector_recipe_detector_rules_details_condition" {
  default = "{\"kind\":\"SIMPLE\",\"parameter\":\"lbCertificateExpiringSoonFilter\",\"operator\":\"EQUALS\",\"value\":\"10\",\"valueType\":\"CUSTOM\"}"
}

variable "detector_recipe_detector_rules_details_configurations_config_key" {
  default = "lbCertificateExpiringSoonConfig"
}

variable "detector_recipe_detector_rules_details_configurations_data_type" {
  default = "multiList"
}

variable "detector_recipe_detector_rules_details_configurations_name" {
  default = "Days before expiring - Setting 1"
}

variable "detector_recipe_detector_rules_details_configurations_value" {
  default = "30"
}

//Acceptable values come from ConfigurationListItemTypeEnum
variable "detector_recipe_detector_rules_details_configurations_values_list_type" {
  default = "CUSTOM"
}

//Has some specific acceptable managed list types values, picking one for testing purposes
variable "detector_recipe_detector_rules_details_configurations_values_managed_list_type" {
  default = "RESOURCE_OCID"
}

variable "detector_recipe_detector_rules_details_configurations_values_value" {
  default = "ocid.detectectorrecipe.test1"
}

variable "detector_recipe_detector_rules_details_is_enabled" {
  default = true
}

variable "detector_recipe_detector_rules_details_labels" {
  default = []
}

//Acceptable values come from RiskLevelEnum
variable "detector_recipe_detector_rules_details_risk_level" {
  default = "HIGH"
}

variable "detector_recipe_freeform_tags" {
  default = {
    "bar-key" = "value"
  }
}

//Acceptable values come from LifecycleStateEnum
variable "detector_recipe_state" {
  default = "ACTIVE"
}


variable "target_description" {
  default = "Custom Target for High Security Zone Compartment"
}
variable "target_display_name" {
  default = "TF Demo Target"
}
variable "target_state" {
  default = "ACTIVE"
}
variable "target_target_resource_type" {
  default = "COMPARTMENT"
}
variable "target_target_detector_recipes_detector_rules_details_condition_groups_condition" {
  default = "{\"kind\":\"SIMPLE\",\"parameter\":\"lbCertificateExpiringSoonFilter\",\"operator\":\"EQUALS\",\"value\":\"20\",\"valueType\":\"CUSTOM\"}"
}
variable "target_target_responder_recipes_responder_rules_details_mode" {
  default = "AUTOACTION"
}

variable "cloud_guard_configuration_reporting_region" {
  default = ""
}

variable "responder_recipe1_description" {
  default = "Custom Responder Recipe"
}

variable "responder_recipe2_description" {
  default = "Custom Responder Recipe"
}

variable "responder_recipe_responder_rules_details_is_enabled" {
  default = false
}
variable "responder_recipe_state" {
  default = "ACTIVE"
}

# Dictionary Locals
locals {
  compute_flexible_shapes = [
    "VM.Standard.E3.Flex",
    "VM.Standard.E4.Flex",
    "VM.Standard.A1.Flex",
    "VM.Optimized3.Flex"
  ]
}

# Checks if is using Flexible Compute Shapes
locals {
  is_flexible_webserver_instance_shape = contains(local.compute_flexible_shapes, var.WebserverInstanceShape)
  is_flexible_bastion_instance_shape   = contains(local.compute_flexible_shapes, var.BastionInstanceShape)
}

# Checks if is using Flexible LB Shapes
locals {
  is_flexible_lb_shape = var.lb_shape == "flexible" ? true : false
}


