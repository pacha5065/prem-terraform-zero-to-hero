variable "cidr_block" {
  type = string
}

variable "ami" {
  description = "ami instance value"
  type = string
}

variable "instance_type" {
    description = "instance type"
    type = string
}

variable "public_cidr_1" {
  type = string
}
# variable "public_cidr_2" {
#   type = string
# }
# variable "public_cidr_3" {
#   type = string
# }

variable "private_cidr_1" {
  type = string
}
# variable "private_cidr_2" {
#   type = string
# }
# variable "private_cidr_3" {
#   type = string
# }