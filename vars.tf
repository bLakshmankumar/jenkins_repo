variable "access_key" {
    description = "access_key"
    type = string
    default = "Bk****************"
}

variable "secret_key" {
    description = "Sc_key"
    type = string
    default = "7********************"
  
}

variable "region" {
    description = "region"
    type = string
    default = "us-east-2"
}

variable "ami" {
    description = "AMI-id"
    type = string
    default = "***********"
}

variable "instance_type" {
    description = "instance_type"
    type = string
    default = "t2.micro"
}

variable "key_name" {
    description = "instance_key"
    type = string
    default = "***key"
}

variable "vpc_id" {
     description = "vpc_id"
    type = string
    default = "*********"
  
}