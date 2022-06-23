variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "name of the SSM parameter key eg: /test/MY_DB_PASSWORD"
  type = string
}

variable "description" {
  description = "key name description"
  type = string
  default = ""
}

variable "encrypted_file_path" {
  description = "file path containing the cipher blob of the plain text value"
  type = string
}