variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
variable "description" {
  description = "key name description"
  type = string
  default = ""
}

variable "encrypted_secrets_file_path" {
  description = "file path containing the cipher blob of the plain text value"
  type = string
}

variable "parameters" {
  description = "file path containing the cipher blob of the plain text value"
}