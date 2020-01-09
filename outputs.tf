output "service_account" {
  value = google_service_account.this
}

output "name" {
  value = (
    length(google_cloudfunctions_function.this_archive) == 1
    ? google_cloudfunctions_function.this_archive[0].name
    : google_cloudfunctions_function.this_repo[0].name
  )
}

output "project" {
  value = (
    length(google_cloudfunctions_function.this_archive) == 1
    ? google_cloudfunctions_function.this_archive[0].project
    : google_cloudfunctions_function.this_repo[0].project
  )
}

output "region" {
  value = (
    length(google_cloudfunctions_function.this_archive) == 1
    ? google_cloudfunctions_function.this_archive[0].region
    : google_cloudfunctions_function.this_repo[0].region
  )
}

output "https_trigger_url" {
  value = (
    length(google_cloudfunctions_function.this_archive) == 1
    ? google_cloudfunctions_function.this_archive[0].https_trigger_url
    : google_cloudfunctions_function.this_repo[0].https_trigger_url
  )
}

output "source_repository" {
  value = (
    length(google_cloudfunctions_function.this_archive) == 1
    ? google_cloudfunctions_function.this_archive[0].source_repository
    : google_cloudfunctions_function.this_repo[0].source_repository
  )
}

output "runtime" {
  value = (
    length(google_cloudfunctions_function.this_archive) == 1
    ? google_cloudfunctions_function.this_archive[0].runtime
    : google_cloudfunctions_function.this_repo[0].runtime
  )
}

output "available_memory_mb" {
  value = (
    length(google_cloudfunctions_function.this_archive) == 1
    ? google_cloudfunctions_function.this_archive[0].available_memory_mb
    : google_cloudfunctions_function.this_repo[0].available_memory_mb
  )
}

output "service_account_email" {
  value = (
    length(google_cloudfunctions_function.this_archive) == 1
    ? google_cloudfunctions_function.this_archive[0].service_account_email
    : google_cloudfunctions_function.this_repo[0].service_account_email
  )
}

output "entry_point" {
  value = (
    length(google_cloudfunctions_function.this_archive) == 1
    ? google_cloudfunctions_function.this_archive[0].entry_point
    : google_cloudfunctions_function.this_repo[0].entry_point
  )
}
