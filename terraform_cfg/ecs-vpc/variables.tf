variable "alicloud_access_key" {
  default = ""
}
variable "alicloud_secret_key" {
  default = ""
}

variable "availability_zones" {
  description = "List available zones to launch several VSwitches."
  type = "list"
  default = ["eu-central-1a"]
}

variable "count" {
  description = "The number of ECS instances being deployed"
  default = "1"
}
variable "count_format" {
  default = "%02d"
}

# Instance related variables
variable "image_id" {
description = "The ECS image's exact name used"
  default = "ubuntu_16_0402_64_20G_alibase_20180409.vhd"
}

variable "image_name_regex" {
  description = "The ECS image's name regex used to fetch specified image."
  default = "^ubuntu_16.*_64"
}

variable "role" {
  default = "test"
}
variable "datacenter" {
  default = "fra"
}
variable "short_name" {
  default = "tf-test"
}
variable "ecs_type" {
  default = "ecs.t5-lc1m1.small"
}

variable "ssh_username" {
  default = "root"
}
variable "ecs_password" {
  default = "Test12345"
}

variable "instance_charge_type" {
  default = "PostPaid"
}

variable "internet_charge_type" {
  default = "PayByTraffic"
}
variable "internet_max_bandwidth_out" {
  default = 5
}

variable "disk_category" {
  default = "cloud_efficiency"
}
variable "disk_size" {
  default = "40"
}

variable "nic_type" {
  description = "Type of the NIC configured for the instance, the options are 'intranet' or 'internet'"
  default = "intranet"
}

variable "instance_description" {
  description = "The instance description used to launch several new vswitch."
  default = "New ECS instance created by Terrafrom module tf-alicloud-vpc-cluster."
}

# VPC related variables
variable "vpc_name" {
  description = "The vpc name used to launch a new vpc."
  default = "TF-VPC"
}
variable "vpc_cidr" {
  description = "The cidr block used to launch a new vpc."
  default = "172.16.0.0/12"
}

variable "vpc_description" {
  description = "The vpc description used to launch a new vpc when 'vpc_id' is not specified."
  default = "A new VPC created by Terrafrom module tf-alicloud-vpc-cluster"
}

# VSwitch related variables
variable "vswitch_id" {
  description = "The vswitch id of existing vswitch."
  default = ""
}

variable "vswitch_description" {
  description = "The vswitch description used to launch several new vswitch."
  default = "New VSwitch created by Terrafrom module tf-alicloud-vpc-cluster."
}

variable "vswitch_name" {
  description = "The vswitch name used to launch a new vswitch when vswitch_id is not set."
  default = "TF_VSwitch"
}
variable "vswitch_cidr" {
  description = "The cidr block used to launch a new vswitch when vswitch_id is not set."
  default = "172.16.1.0/24"
}

# Security Group variables
variable "sg_id" {
  description = "The security group id of existing security group."
  default = ""
}

variable "sg_description" {
  description = "The security group description used to launch several new vswitch."
  default = "New SG created by Terrafrom module tf-alicloud-vpc-cluster."
}
variable "sg_name" {
  description = "The security group name used to launch a new security group when sg is not set."
  default = "TF_SG"
}
