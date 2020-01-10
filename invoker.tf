locals {
  cloudfunction = var.function_source != null ? google_cloudfunctions_function.this_archive : google_cloudfunctions_function.this_repo
}

resource "google_cloudfunctions_function_iam_member" "public_function" {
  count = var.is_public_function ? 1 : 0

  project        = local.cloudfunction.project
  region         = local.cloudfunction.region
  cloud_function = local.cloudfunction.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

resource "google_cloudfunctions_function_iam_member" "invokers" {
  count = var.is_public_function == false ? length(var.invoker_members) : 0

  project        = local.cloudfunction.project
  region         = local.cloudfunction.region
  cloud_function = local.cloudfunction.name

  role   = "roles/cloudfunctions.invoker"
  member = var.invoker_members[count.index]
}
