module "test-db-password" {
  source              = "../module"
  name                = "/test/myservice/DB_PASSWORD"
  encrypted_file_path = "./ciplerblobs/db_password.encr"
}

module "test-email-password" {
  source              = "../module"
  name                = "/test/myservice/EMAIL_PASSWORD"
  encrypted_file_path = "./ciplerblobs/email_password.encr"
}
