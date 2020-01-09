data "archive_file" "source" {
  count = var.function_source != null ? (var.function_source.directory != null ? 1 : 0) : 0

  type        = "zip"
  output_path = pathexpand("${var.function_source.directory}.zip")
  source_dir  = var.function_source.directory
}

resource "google_storage_bucket_object" "source" {
  count = var.function_source != null ? 1 : 0

  name   = var.function_source.name != null ? var.function_source.name : var.name
  bucket = var.function_source.bucket
  source = length(data.archive_file.source) == 1 ? data.archive_file.source[0].output_path : var.function_source.file

  content_disposition = "attachment"
  content_encoding    = "gzip"
  content_type        = "application/zip"
}

resource "google_service_account" "this" {
  account_id = join("-", [var.name, "cf"])
  project    = var.project_id

  display_name = "CF - ${var.name}"
  description  = "Service account for Cloudfunction: ${var.name}"
}

resource "google_project_iam_member" "roles" {
  count = length(var.roles)

  project = var.project_id
  role    = var.roles[count.index]
  member  = "serviceAccount:${google_service_account.this.email}"
}

resource "google_project_iam_member" "project_roles" {
  count = length(var.project_roles)

  project = var.project_roles[count.index].project_id
  role    = var.project_roles[count.index].role
  member  = "serviceAccount:${google_service_account.this.email}"
}

locals {
  trigger_http = var.trigger_http == true || length(var.event_triggers) == 0

  event_triggers = (
    local.trigger_http == false
    ? [
      for trigger in var.event_triggers :
      {
        event_type     = trigger.event_type
        resource       = trigger.resource
        failure_policy = trigger.retry == true ? [{ failure_policy = true }] : []
      }
    ]
    : []
  )
}

resource "google_cloudfunctions_function" "this_archive" {
  count = length(google_storage_bucket_object.source) == 1 ? 1 : 0

  name        = var.name
  description = var.description
  project     = var.project_id
  region      = var.region

  runtime             = var.runtime
  available_memory_mb = var.available_memory_mb
  max_instances       = var.max_instances
  timeout             = var.timeout

  source_archive_bucket = google_storage_bucket_object.source[0].bucket
  source_archive_object = google_storage_bucket_object.source[0].name
  entry_point           = var.entry_point
  environment_variables = var.environment_variables

  labels = var.labels

  vpc_connector = var.vpc_connector

  trigger_http = var.trigger_http

  dynamic "event_trigger" {
    for_each = local.event_triggers

    content {
      event_type = event_trigger.value.event_type
      resource   = event_trigger.value.resource

      dynamic "failure_policy" {
        for_each = event_trigger.value.failure_policy

        content {
          retry = failure_policy.value.retry
        }
      }
    }
  }
}

resource "google_cloudfunctions_function" "this_repo" {
  count = length(google_cloudfunctions_function.this_archive) == 0 && var.source_repository_url != null ? 1 : 0

  name        = var.name
  description = var.description
  project     = var.project_id
  region      = var.region

  runtime             = var.runtime
  available_memory_mb = var.available_memory_mb
  timeout             = var.timeout
  max_instances       = var.max_instances

  entry_point           = var.entry_point
  environment_variables = var.environment_variables

  source_repository {
    url = var.source_repository_url
  }

  labels = var.labels

  vpc_connector = var.vpc_connector

  trigger_http = var.trigger_http

  dynamic "event_trigger" {
    for_each = local.event_triggers

    content {
      event_type = event_trigger.value.event_type
      resource   = event_trigger.value.resource

      dynamic "failure_policy" {
        for_each = event_trigger.value.failure_policy

        content {
          retry = failure_policy.value.retry
        }
      }
    }
  }
}
