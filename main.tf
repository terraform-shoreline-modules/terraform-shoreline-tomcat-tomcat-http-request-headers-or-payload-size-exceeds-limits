terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "tomcat_http_request_headers_or_payload_size_exceeds_limits" {
  source    = "./modules/tomcat_http_request_headers_or_payload_size_exceeds_limits"

  providers = {
    shoreline = shoreline
  }
}