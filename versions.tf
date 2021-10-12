terraform {
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "1.0.2"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

provider "mongodbatlas" {}
