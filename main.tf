/*
* main.tf
*/

provider "aws" {
  region = ""
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "4.1.0"
  # VPC id where the load balancer and other resources will be deployed.
  vpc_id = ""
  # The security groups to attach to the load balancer. e.g. ["sg-edcd9784","sg-edcd9785"]
  security_groups = []
  # The resource name and Name tag of the load balancer.
  load_balancer_name = ""
  # A list of subnets to associate with the load balancer. e.g. ['subnet-1a2b3c4d','subnet-1a2b3c4e','subnet-1a2b3c4f']
  subnets = []
}

module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "2.5.0"
  # The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier
  identifier = ""
  # The database engine to use
  engine = ""
  # The name of your final DB snapshot when this DB instance is deleted.
  final_snapshot_identifier = ""
  # The instance type of the RDS instance
  instance_class = ""
  # Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file
  password = ""
  # The allocated storage in gigabytes
  allocated_storage = ""
  # Username for the master DB user
  username = ""
  # The engine version to use
  engine_version = ""
  # The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'
  maintenance_window = ""
  # The port on which the DB accepts connections
  port = ""
  # The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window
  backup_window = ""
}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.8.0"
  # A list of security group IDs to associate with
  vpc_security_group_ids = []
  # ID of AMI to use for the instance
  ami = ""
  # The type of instance to start
  instance_type = ""
  # Name to be used on all resources as prefix
  name = ""
}

module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "1.0.0"
  # (Optional) If specified, the AWS region this bucket should reside in. Otherwise, the region used by the callee.
  region = ""
  # (Optional) A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide.
  policy = ""
  # (Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name.
  bucket = ""
  # (Optional, Forces new resource) Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket.
  bucket_prefix = ""
  # (Optional) Specifies who should bear the cost of Amazon S3 data transfer. Can be either BucketOwner or Requester. By default, the owner of the S3 bucket would incur the costs of any data transfer. See Requester Pays Buckets developer guide for more information.
  request_payer = ""
  # (Optional) Sets the accelerate configuration of an existing bucket. Can be Enabled or Suspended.
  acceleration_status = ""
}

module "networking" {
  source  = "cn-terraform/networking/aws"
  version = "2.0.4"
  # List of CIDRs to use on each availability zone for public subnets
  public_subnets_cidrs_per_availability_zone = []
  # AWS VPC CIDR Block
  vpc_cidr_block = ""
  # List of availability zones to be used by subnets
  availability_zones = []
  # AWS Region the infrastructure is hosted in
  region = ""
  # AWS API key credentials to use
  profile = ""
  # Name preffix for resources on AWS
  name_preffix = ""
  # List of CIDRs to use on each availability zone for private subnets
  private_subnets_cidrs_per_availability_zone = []
}

module "elb" {
  source  = "terraform-aws-modules/elb/aws"
  version = "2.3.0"
  # The name of the ELB
  name = ""
  # A list of security group IDs to assign to the ELB
  security_groups = []
  # A health check block
  health_check = {}
  # A list of listener blocks
  listener = []
  # A list of subnet IDs to attach to the ELB
  subnets = []
  # The prefix name of the ELB
  name_prefix = ""
}

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.2.0"
  # Name of security group
  name = ""
  # ID of the VPC where to create security group
  vpc_id = ""
}
