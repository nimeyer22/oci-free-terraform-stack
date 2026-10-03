variable "tenancy_ocid" {
  description = "The OCID of the tenancy"
  type        = string
}

variable "user_ocid" {
  description = "The OCID of the user"
  type        = string
}

variable "private_key" {
  description = "Unencrypted OCI API signing private key in PEM format"
  type        = string
  sensitive   = true
}

variable "fingerprint" {
  description = "The fingerprint for the key pair"
  type        = string
}

variable "region" {
  description = "The OCI region for resources"
  type        = string
}

variable "compartment_name" {
  description = "The name of the compartment"
  type        = string
}

variable "tags" {
  description = "Freeform tags for the resources"
  type        = map(any)
  default     = {}
}

variable "vm_name" {
  description = "The name of the VM instances"
  type        = string
}

variable "ssh_public_key" {
  description = "The public key for SSH access to instances"
  type        = string
}

variable "availability_domain_index" {
  description = "Zero-based index of the availability domain used for compute and the data volume"
  type        = number
  default     = 0

  validation {
    condition     = var.availability_domain_index >= 0 && var.availability_domain_index <= 2 && floor(var.availability_domain_index) == var.availability_domain_index
    error_message = "availability_domain_index must be a whole number from 0 through 2 for eu-frankfurt-1."
  }
}

variable "create_ampere_instance" {
  description = "Whether to create the VM.Standard.A1.Flex instance and 50 GB data volume"
  type        = bool
  default     = false
}

variable "x86_instance_count" {
  description = "Number of VM.Standard.E2.1.Micro instances to create"
  type        = number
  default     = 0

  validation {
    condition     = var.x86_instance_count >= 0 && var.x86_instance_count <= 2 && floor(var.x86_instance_count) == var.x86_instance_count
    error_message = "x86_instance_count must be a whole number from 0 through 2."
  }
}
