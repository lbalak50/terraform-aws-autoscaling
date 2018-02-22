# Launch configuration
output "launch_configuration_id" {
    description = "The ID of the launch configuration"
    value       = "${aws_launch_configuration.this.id}"
}

output "launch_configuration_name" {
  description = "The name of the launch configuration (this is a prefix/autogenerated name, so this needs an output)"
  value       = "${aws_launch_configuration.this.name}"
}

# Autoscaling group
output "id" {
  description = "The autoscaling group id"
  value       = "${element(concat(aws_autoscaling_group.this.*.id, list("")), 0)}"
}

output "min_size" {
  description = "The minimum size of the autoscale group"
  value       = "${aws_autoscaling_group.this.min_size}"
}

output "max_size" {
  description = "The maximum size of the autoscale group"
  value       = "${aws_autoscaling_group.this.max_size}"
}

output "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = "${aws_autoscaling_group.this.desired_capacity}"
}
