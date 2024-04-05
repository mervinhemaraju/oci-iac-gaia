variable "region" {
  type        = string
  description = "The region where the resources will be created."
  default     = "af-johannesburg-1"
}

variable "token_doppler_iac_cloud_main" {
  type        = string
  description = "The Doppler token for the secrets manager cloud main repo."
}
