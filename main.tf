#######################
# Launch configuration
#######################
resource "aws_launch_configuration" "this" {
    name_prefix                 = "${var.name}-"
    image_id                    = "${length(var.image_id) > 0 ? var.image_id : data.aws_ami.ubuntu.id}"
    instance_type               = "${var.instance_type}"
    iam_instance_profile        = "${var.iam_instance_profile}"
    key_name                    = "${var.key_name}"
    security_groups             = ["${var.security_groups}"]
    user_data                   = "${var.user_data}"
    enable_monitoring           = "${var.is_live ? true : false}"

    // placement_tenancy           = "${var.placement_tenancy}"
    // ebs_optimized               = "${var.ebs_optimized}"
    // ebs_block_device            = "${var.ebs_block_device}"
    // ephemeral_block_device      = "${var.ephemeral_block_device}"

    associate_public_ip_address = "${var.associate_public_ip_address}"

    root_block_device           = [{
        volume_size = "${var.volume_size}"
        volume_type = "gp2"
    }]

    lifecycle {
        create_before_destroy = true
    }

    spot_price                  = "${var.spot_price}"
}

####################
# Autoscaling group
####################
resource "aws_autoscaling_group" "this" {
    name                 = "${var.name}"
    launch_configuration = "${aws_launch_configuration.this.name}"
    vpc_zone_identifier  = ["${var.subnet_ids}"]
    max_size             = "${var.max_size}"
    min_size             = "${var.min_size}"

    load_balancers            = ["${var.load_balancers}"]
    target_group_arns         = ["${var.target_group_arns}"]

    health_check_grace_period = "${var.health_check_grace_period}"
    health_check_type         = "ELB"

    // If we want to enable waiting for healthy instances (in terraform) for CI/CD?
    // min_elb_capacity          = "${var.min_elb_capacity}"
    // wait_for_elb_capacity     = "${var.wait_for_elb_capacity}"
    // wait_for_capacity_timeout = "0"

    // default_cooldown          = "${var.default_cooldown}"
    // force_delete              = "${var.force_delete}"

    termination_policies      = ["OldestLaunchConfiguration", "OldestInstance"]

    enabled_metrics           = ["GroupInServiceInstances"]

    // protect_from_scale_in     = "${var.protect_from_scale_in}"
    // placement_group           = "${var.placement_group}"

    tags = ["${var.tags}"]
}
