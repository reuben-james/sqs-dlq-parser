# SQS Queue Processor

A project to deploy a simple python based lambda and supporting AWS infrastructure using Terraform. 

Package the lambda: 

```
./package_lambda.sh
```

This will create, or overwrite `terraform/lambda_function.zip`

Then move into `terraform/` and refer to `terraform/README.md` for deployment instructions