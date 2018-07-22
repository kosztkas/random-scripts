provider "alicloud" {
    access_key = "${var.alicloud_access_key}"
    secret_key = "${var.alicloud_secret_key}"
	
	region = "eu-central-1"
}

resource "alicloud_oss_bucket" "bucket-new" {
    bucket = "terraformtestbucketvssb"
}
