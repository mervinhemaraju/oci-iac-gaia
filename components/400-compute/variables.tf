variable "region" {
  type        = string
  description = "The region where the resources will be created."
  default     = "af-johannesburg-1"
}

variable "token_doppler_global" {
  type        = string
  description = "The Doppler token for the secrets manager cloud main repo."
}

variable "bucket_key_prefix_iac" {
  type        = string
  description = "The prefix for the bucket key."
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket."
}

variable "bucket_region" {
  type        = string
  description = "The region of the bucket."
}
