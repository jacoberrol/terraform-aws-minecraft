variable "vpc_id" {
  description = "VPC for security group"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "VPC subnet id to place the instance"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "EC2 key name for provisioning and access"
  type        = string
  default     = ""
}

variable "bucket_name" {
  description = "Bucket name for persisting minecraft world"
  type        = string
  default     = ""
}

variable "bucket_force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. This will destroy your minecraft world!"
  type        = bool
  default     = false
}

variable "bucket_object_versioning" {
  description = "Enable object versioning (default = true). Note this may incur more cost."
  type        = bool
  default     = true
}

// For tags
variable "name" {
  description = "Name to use for servers, tags, etc (e.g. minecraft)"
  type        = string
  default     = "minecraft"
}

variable "pt_name" {
  description = "Name to use for servers, tags, etc (e.g. minecraft)"
  type        = string
  default     = "pterodactyl"
}

variable "namespace" {
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
  type        = string
  default     = "oliverj.io"
}

variable "environment" {
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
  type        = string
  default     = "prod"
}

variable "tags" {
  description = "Any extra tags to assign to objects"
  type        = map
  default     = {}
}

// Minecraft-specific defaults
variable "mc_port" {
  description = "TCP port for minecraft"
  type        = number
  default     = 25565
}

variable "mc_port2" {
  description = "TCP port for minecraft"
  type        = number
  default     = 25566
}

variable "mc_port3" {
  description = "TCP port for minecraft"
  type        = number
  default     = 25567
}

variable "teradactyl_port" {
  description = "TCP port for Teradactyl"
  type = number
  default = 80
}

variable "secure_teradactyl_port" {
  description = "TCP port for Teradactyl"
  type = number
  default = 443
}

variable "daemon_teradactyl_port" {
  description = "TCP port for Teradactyl"
  type = number
  default = 8080
}

variable "sftp_teradactyl_port" {
  description = "TCP port for Teradactyl"
  type = number
  default = 2022
}

variable "udp_teradactyl_port" {
  description = "UDP port for Teradactyl"
  type = number
  default = 24454
}


variable "geyser_port" {
  description = "UDP port for Geyser"
  type = number
  default = 19132
}

variable "ts_voice" {
  description = "UDP port for teamspeak voice"
  type = number
  default = 9987
}

variable "ts_fs" {
  description = "TCP port for teamspeak filetransfer"
  type = number
  default = 30033
}

variable "ts_sq" {
  description = "TCP port for teamspeak serverquery"
  type = number
  default = 10011
}

variable "mc_root" {
  description = "Where to install minecraft on your instance"
  type        = string
  default     = "/home/minecraft"
}

variable "mc_version" {
  description = "Which version of minecraft to install"
  type        = string
  default     = "latest"
}

variable "mc_type" {
  description = "Type of minecraft distribution - snapshot or release"
  type        = string
  default     = "release"
}

variable "mc_backup_freq" {
  description = "How often (mins) to sync to S3"
  type        = number
  default     = 5
}

variable "pt_root" {
  description = "Where to install pterodactyl on your instance"
  type        = string
  default     = "/home/pterodactyl"
}

variable "pt_backup_freq" {
  description = "How often (mins) to sync to S3"
  type        = number
  default     = 5
}

// You'll want to tune these next two based on the instance type
variable "java_ms_mem" {
  description = "Java initial and minimum heap size"
  type        = string
  default     = "2G"
}

variable "java_mx_mem" {
  description = "Java maximum heap size"
  type        = string
  default     = "2G"
}

// Instance vars
variable "associate_public_ip_address" {
  description = "By default, our server has a public IP"
  type        = bool
  default     = true
}

variable "ami" {
  description = "AMI to use for the instance - will default to latest Ubuntu"
  type        = string
  default     = "ami-013f17f36f8b1fefb"
}

variable "pt_ami" {
  description = "AMI to use for the instance - will default to latest Ubuntu"
  type        = string
  default     = "ami-04505e74c0741db8d"
}

// https://aws.amazon.com/ec2/instance-types/
variable "instance_type" {
  description = "EC2 instance type/size - the default is not part of free tier!"
  type        = string
  default     = "t2.medium"
}

variable "allowed_cidrs" {
  description = "Allow these CIDR blocks to the server - default is the Universe"
  type        = string
  default     = "0.0.0.0/0"
}
