module "example-service" {
  source              = "../module"
  encrypted_file_path = "./example-service-secrets.yaml.encrypted"
  parameters = [
    {
      key  = "/test/myservice/PASS1"
      name = "PASS1"
    },
    {
      key  = "/test/myservice/PASS2"
      name = "PASS2"
    },
    {
      key  = "/test/myservice/PASS3"
      name = "PASS3"
    }
  ]
}
