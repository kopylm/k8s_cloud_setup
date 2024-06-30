# Get availability zones in current region
data "aws_availability_zones" "available" {
  state = "available"
}
