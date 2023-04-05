variable "apic_user" {
  type    = string
  default = "admin"
}

variable "apic_password" {
  type    = string
  default = "admin"
}

variable "apic_url" {
  type    = string
  default = "admin"
}

variable "epg_count" {
  type    = number
  default = 10
}

variable "name_prefix" {
  type        = string
  description = "prefix for object names"
}