#### Q: How to store a secret value in AWS SSM Parameter Store & Manage its lifecyle without saving it in plain text form ? (Via Terraform)
#### A: follow below steps
#### prerequisites:
---
    1. AWS KMS key for encrypting your plain text passwords
#### Steps
---
##### 1. Let's say you need to encrypt and store your database password `ex: MyDBPassword@!#%(*&$#*1234`
######  i. encrypt the plain text password using kms key
---
    $ aws kms encrypt --key-id <YOUR_KMS_KEY_ID> --plaintext $(echo 'MyDBPassword@!#%(*&$#*1234' | base64) --no-cli-pager --query CiphertextBlob
    ** notice the base64, because --plaintext arg expects a base64 input **
    
    which outputs a cipher text blob that looks like
    "AQ......."

###### ii. store the output in a yaml file (we will staore all the secerts in a single yaml file)
---
    $ echo "DBPASSWORD: AQ......." > mysecrets.yaml.encrypted

##### 2. Using terraform aws_ssm_parameter & aws_kms_secrets to push the encrypted passwords to AWS Pamater Store
---
######  i. write a module to refer the encrypted password file path

```
module "test-db-password" {
  source                      = "../module"
  encrypted_secrets_file_path = "./mysecrets.yaml.encrypted"
  parameters                  = [    // list of parameters
    {
      key  = "/test/myservice/DBPASSWORD" // name of the parameter key that will hold the decrypted value in AWS Paramater Store
      name = "DBPASSWORD"                 // yaml key as in "./mysecrets.yaml.encrypted" that holds encrypted value
    }
   ]
}
```
and run ` terraform init && terraform apply`


#### To update the password or Adding another Paramater
---
**Follow Step 1 and 2 again.**
New updated passwords will be saved as Version 2

```
module "example-service" {
  source                      = "../module"
  encrypted_secrets_file_path = "./mysecrets.yaml.encrypted"
  parameters                  = [    // list of parameters
    {
      key  = "/test/myservice/DBPASSWORD"    // name of the parameter key that will hold the decrypted value in AWS Paramater Store
      name = "DBPASSWORD"                    // yaml key as in "./mysecrets.yaml.encrypted" that holds encrypted value
    },
    {
      key  = "/test/myservice/EMAIL_PASSWORD" // name of the parameter key that will hold the decrypted value in AWS Paramater Store
      name = "EMAIL_PASSWORD"                 // yaml key as in "./mysecrets.yaml.encrypted" that holds encrypted value
    }
   ]
}
```

Check `envidences` folder for more info.
