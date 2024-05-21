terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3"{
    bucket = "video-tf-backend"
    key    = "backend"
    region = "eu-west-2a"

provider "aws" {
  region = "eu-west-2a"
}
