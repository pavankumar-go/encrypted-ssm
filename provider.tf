provider "aws" {
  region                  = "ap-south-1"
  version                 = "~>4.19.0"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                 = "default"
}
