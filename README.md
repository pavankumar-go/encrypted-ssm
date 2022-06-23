#### Q: How to store a secret value in AWS SSM Parameter Store & Manage its lifecyle without saving it in plain text form ? (Via Terraform)
#### A: follow below steps
#### prerequisites:
---
    1. AWS KMS key for encrypting your plain text passwords
#### Steps
---
##### 1. Let's say you need to encrypt and store your database password `ex: MyDBPassword1234`
######  i. encrypt the plain text password using kms key
---
    $ aws kms encrypt --key-id <YOUR_KMS_KEY_ID> --plaintext $(echo MyDBPassword1234 | base64) --no-cli-pager --query CiphertextBlob
    ** notice the base64, because --plaintext arg expects a base64 input **
    
    which outputs a cipher text blob that looks like
    "AQICAHihcFJ1Z7iE.................."

###### ii. store the output in a file 
---
    $ echo "AQICAHihcFJ1Z7iE.................." > ./demo-service/ciplerblobs/mydbpassword.encr

##### 2. Using terraform aws_ssm_parameter & aws_kms_secrets to push the encrypted passwords to AWS Pamater Store
---
######  i. write a module to refer the encrypted password file path

```
module "test-db-password" {
  source              = "../module"
  name                = "/test/myservice/DB_PASSWORD"
  encrypted_file_path = "./ciplerblobs/mydbpassword.encr"
}
```
and run ` terraform init && terraform apply`


#### Need to update the password for the same key ?
---
**Follow Step 1 and 2 again.**
New updated password will be saved as Version 2
Check `Envidences` folder for more info.

