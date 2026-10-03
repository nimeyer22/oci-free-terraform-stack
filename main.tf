# Tenancy OCID Value
variable "tenancy_ocid" {}

# User OCID Value
variable "user_ocid" {}

# Fingerprint Value
variable "fp" {}

# Private Key
variable "private_key" {
  sensitive = true
}

# SSH public key to use for SSH access
variable "ssh_pub_key" {}

variable "availability_domain_index" {
  description = "Zero-based availability domain index for compute and the data volume"
  type        = number
  default     = 0
}

variable "create_ampere_instance" {
  description = "Whether to create the VM.Standard.A1.Flex instance and its data volume"
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

# Define the module source and its location                    
module "oci-stack" {
  source                   = "./oci-stack-module"
  tenancy_ocid             = var.tenancy_ocid
  user_ocid                = var.user_ocid
  compartment_name         = "oci-stack"
  fingerprint              = var.fp
  region                   = "eu-frankfurt-1"
  vm_name                  = "oci-stack-instance"
  private_key              = var.private_key
  ssh_public_key           = var.ssh_pub_key
  availability_domain_index = var.availability_domain_index
  create_ampere_instance    = var.create_ampere_instance
  x86_instance_count        = var.x86_instance_count
  tags                     = { Project = "oci-tf-stack" }

}

output "module_public_ips_x86_64" {
  value = module.oci-stack.public-ip-x86_64-instances
}

output "module_private_ips_x86_64" {
  value = module.oci-stack.private-ip-x86_64-instances
}

output "module_instance_id_x86_64" {
  value = module.oci-stack.instance-id-x86_64-instances
}

output "module_public_ip_ampere" {
  value = module.oci-stack.public-ip-ampere-instance
}

output "module_private_ip_ampere" {
  value = module.oci-stack.private-ip-ampere-instance
}

output "module_instance_id_ampere" {
  value = module.oci-stack.instance-id-ampere-instance
}
