# Terraform/Tofu Deployment

Set the environment

```
export ENVIRONMENT='test'
```

Initialize Tofu

```
tofu init -backend-config="environments/${ENVIRONMENT}/backend_config.hcl"
```

Run a plan 

```
tofu plan -var-file="environments/${ENVIRONMENT}/vars.tfvars"
```

Apply the plan 

```
tofu apply -var-file="environments/${ENVIRONMENT}/vars.tfvars"
```