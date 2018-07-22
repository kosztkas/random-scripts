provider "alicloud" {
    access_key = "${var.alicloud_access_key}"
    secret_key = "${var.alicloud_secret_key}"
	
	region = "eu-central-1"
}

data "alicloud_instance_types" "default" {
  instance_type_family = "ecs.t5"
  cpu_core_count = "1"
  memory_size = "1"
}

// Zones data source for availability_zone
data "alicloud_zones" "default" {
  available_disk_category = "${var.disk_category}"
  available_instance_type = "${data.alicloud_instance_types.default.instance_types.0.id}"
}
// VPC Resource for Module
resource "alicloud_vpc" "vpc" {
  name = "${var.vpc_name}"
  description = "${var.vpc_description}"
  cidr_block = "${var.vpc_cidr}"
}

// VSwitch Resource for Module
resource "alicloud_vswitch" "vswitch" {
  count = "${var.vswitch_id == "" ? 1 : 0}"
  availability_zone = "${data.alicloud_zones.default.zones.0.id}"
  name = "${var.vswitch_name}"
  description = "${var.vswitch_description}"
  cidr_block = "${var.vswitch_cidr}"
  vpc_id = "${alicloud_vpc.vpc.id}"
}

// Security Group Resource for Module
resource "alicloud_security_group" "group" {
  count = "${var.sg_id == "" ? 1 : 0}"
  name = "${var.sg_name}"
  description = "${var.sg_description}"
  vpc_id = "${alicloud_vpc.vpc.id}"
}

resource "alicloud_instance" "instance" {
  instance_name = "${var.short_name}-${format(var.count_format, count.index+1)}"
  host_name = "${var.short_name}-${format(var.count_format, count.index+1)}"
  description = "${var.instance_description}"
  
  image_id = "${var.image_id}"
  instance_type = "${var.ecs_type == ""? data.alicloud_instance_types.default.instance_types.0.id : var.ecs_type}"
  count = "${var.count}"
  
  security_groups = ["${var.sg_id == "" ? join("", alicloud_security_group.group.*.id) : var.sg_id}"]
  vswitch_id = "${var.vswitch_id == "" ? join("", alicloud_vswitch.vswitch.*.id) : var.vswitch_id}"

  #internet_charge_type = "${var.internet_charge_type}"
  #internet_max_bandwidth_out = "${var.internet_max_bandwidth_out}"

  password = "${var.ecs_password}"

  instance_charge_type = "${var.instance_charge_type}"
  system_disk_category = "${var.disk_category}"
  system_disk_size = "${var.disk_size}"


  tags {
    role = "${var.role}"
  }

}
