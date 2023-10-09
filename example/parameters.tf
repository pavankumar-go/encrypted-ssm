module "example-service" {
  source                      = "../module"
  encrypted_secrets_file_path = "./example-secrets.yaml.encrypted"
  parameters = [
    {
      key  = "/test/myservice/PASS1" // name of the parameter 
      name = "PASS1"                 // yaml key as in "./example-secrets.yaml.encrypted" that holds encrypted value
    },
    {
      key  = "/test/myservice/PASS2"
      name = "PASS2"
    }
  ]
}
