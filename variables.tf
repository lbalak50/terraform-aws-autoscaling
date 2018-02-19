###################
# Required Inputs #
###################
variable "name" {
    description = "Name of this resource"
}

variable "subnet_ids" {
    description = "A list of subnet ids to launch all servers launched by this launch configuration into"
    type    = "list"
}



###################
# Optional Inputs #
###################
variable "is_live" {
  description = "Is a live environment.  If true we make live-specific tweaks to this autoscaler"
  default     = false
}

variable "tags" {
    description = "A map of tags to add to all resources"
    type        = "list"
    default     = []
}

variable "image_id" {
    description = "The AMI image id you'd like to associate with the autoscaling launch configuration"
    default     = ""
}

variable "instance_type" {
    description = "The type of instance you'd like to launch with the autoscaling launch configuration"
    default     = "t2.nano"
}

variable "iam_instance_profile" {
    description = "The name of the instance profile we'll assign to all servers launched by this launch configuration"
    default     = ""
}

variable "key_name" {
    description = "The name of the SSH key to assign to all servers launched by this launch configuration"
    default     = ""
}

variable "security_groups" {
    description = "A list of security group ids to associate with all servers launched by this launch configuration"
    type    = "list"
    default = []
}

variable "volume_size" {
    description = "The size of the root disk volume on servers launched from this launch configuration"
    default     = "10"
}

variable "min_size" {
    description = "The minimum number of servers to have running via this autoscaling group"
    default     = "1"
}

variable "max_size" {
    description = "The maximum number of servers to have running via this autoscaling group"
    default     = "2"
}

variable "load_balancers" {
    description = "The load balancers to associate with this autoscaling group"
    type    = "list"
    default = []
}

variable "target_group_arns" {
    description = "The target group ARNs to associate with this autoscaling group"
    type    = "list"
    default = []
}

variable "health_check_grace_period" {
    description = "The health check grace period"
    default     = "300"
}

variable "user_data" {
    description = "The user-data script to make the instance run on boot via cloud-init"
    default     = ""
}








###################
# Tertiary Inputs #
###################
variable "associate_public_ip_address" {
    description = "If you wish to associate public ips to servers launched from this launch configuration"
    default     = false
}

variable "spot_price" {
    description = "If you wish to be launching spot instances, specify the max price here"
    default     = ""
}



######################
# Data Lookup Inputs #
######################
# This gets the latest official ubuntu AMI on our region
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}
