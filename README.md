# tf-mongodb
TF Repo for Mongodb Atlas cluster and users

# Pre-Reqs

- Create a Mongodb cloud account
- Create a Mongodb cloud account project
- Create associated API key with sufficient permisisons

# Usage

- export MONGODB_ATLAS_PUBLIC_KEY="xxxx"
- export MONGODB_ATLAS_PRIVATE_KEY="xxxx"
- Modify modules/mongodb/variables.tf to configure the created Mongodb cloud project id
- Modify modules/mongodb/variables.json to configure which databases and users you want to deploy

# Outputs

- tf apply will output the required specific user connection_strings to connect to the database