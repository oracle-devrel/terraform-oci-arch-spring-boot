## Copyright © 2021, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_cloud_guard_cloud_guard_configuration" "enable_cloud_guard" {
  provider         = oci.homeregion
  count            = var.use_cloud_guard ? 1 : 0
  compartment_id   = var.tenancy_ocid
  reporting_region = var.cloud_guard_configuration_reporting_region == "" ? data.oci_identity_region_subscriptions.home_region_subscriptions.region_subscriptions[0].region_name : var.cloud_guard_configuration_reporting_region
  status           = var.cloud_guard_configuration_status
}


resource "oci_cloud_guard_detector_recipe" "cloned_detector_recipe" {
  provider                  = oci.homeregion
  count                     = var.use_cloud_guard ? 1 : 0
  compartment_id            = var.compartment_ocid
  display_name              = var.detector_recipe1_display_name
  source_detector_recipe_id = data.oci_cloud_guard_detector_recipes.list_detector_recipes.detector_recipe_collection.0.items.0.id
  defined_tags              = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_cloud_guard_responder_recipe" "cloned_responder_recipe" {
  provider                   = oci.homeregion
  count                      = var.use_cloud_guard ? 1 : 0
  compartment_id             = var.compartment_ocid
  description                = var.responder_recipe1_description
  display_name               = var.responder_recipe1_display_name
  source_responder_recipe_id = data.oci_cloud_guard_responder_recipes.list_responder_recipes.responder_recipe_collection.0.items.0.id
  defined_tags               = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }

}
resource "oci_cloud_guard_detector_recipe" "cloned2_detector_recipe" {
  provider                  = oci.homeregion
  count                     = var.use_cloud_guard ? 1 : 0
  compartment_id            = var.compartment_ocid
  display_name              = var.detector_recipe2_display_name
  source_detector_recipe_id = data.oci_cloud_guard_detector_recipes.list_detector_recipes.detector_recipe_collection.0.items.0.id
  defined_tags              = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_cloud_guard_responder_recipe" "cloned2_responder_recipe" {
  provider                   = oci.homeregion
  count                      = var.use_cloud_guard ? 1 : 0
  compartment_id             = var.compartment_ocid
  description                = var.responder_recipe2_description
  display_name               = var.responder_recipe2_display_name
  source_responder_recipe_id = data.oci_cloud_guard_responder_recipes.list_responder_recipes.responder_recipe_collection.0.items.0.id
  defined_tags               = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}


resource "oci_cloud_guard_target" "test_target" {
  provider           = oci.homeregion
  count              = var.use_cloud_guard ? 1 : 0
  compartment_id     = var.compartment_ocid
  display_name       = var.target1_display_name
  target_resource_id = var.compartment_ocid

  target_resource_type = var.target_target_resource_type
  description          = var.target_description
  state                = var.target_state

  target_detector_recipes {
    detector_recipe_id = oci_cloud_guard_detector_recipe.cloned_detector_recipe[count.index].id
  }
  target_responder_recipes {
    responder_recipe_id = oci_cloud_guard_responder_recipe.cloned_responder_recipe[count.index].id

  }
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }

}

resource "oci_cloud_guard_target" "test_target2" {
  provider       = oci.homeregion
  count          = var.use_cloud_guard ? 1 : 0
  compartment_id = var.compartment_SZ_ocid
  display_name   = var.target2_display_name

  target_resource_id   = var.compartment_SZ_ocid
  target_resource_type = var.target_target_resource_type
  description          = var.target_description
  state                = var.target_state

  target_detector_recipes {
    detector_recipe_id = oci_cloud_guard_detector_recipe.cloned2_detector_recipe[count.index].id
  }
  target_responder_recipes {
    responder_recipe_id = oci_cloud_guard_responder_recipe.cloned2_responder_recipe[count.index].id

  }
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }

}

