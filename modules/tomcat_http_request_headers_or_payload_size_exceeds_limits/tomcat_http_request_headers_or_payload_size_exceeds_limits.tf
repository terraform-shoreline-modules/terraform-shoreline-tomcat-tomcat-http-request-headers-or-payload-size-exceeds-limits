resource "shoreline_notebook" "tomcat_http_request_headers_or_payload_size_exceeds_limits" {
  name       = "tomcat_http_request_headers_or_payload_size_exceeds_limits"
  data       = file("${path.module}/data/tomcat_http_request_headers_or_payload_size_exceeds_limits.json")
  depends_on = [shoreline_action.invoke_tomcat_config_update]
}

resource "shoreline_file" "tomcat_config_update" {
  name             = "tomcat_config_update"
  input_file       = "${path.module}/data/tomcat_config_update.sh"
  md5              = filemd5("${path.module}/data/tomcat_config_update.sh")
  description      = "Increase the maximum allowable size for HTTP request headers or payload in Tomcat configuration."
  destination_path = "/agent/scripts/tomcat_config_update.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_tomcat_config_update" {
  name        = "invoke_tomcat_config_update"
  description = "Increase the maximum allowable size for HTTP request headers or payload in Tomcat configuration."
  command     = "`chmod +x /agent/scripts/tomcat_config_update.sh && /agent/scripts/tomcat_config_update.sh`"
  params      = ["PATH_TO_TOMCAT_CONFIG_FILE","NEW_MAXIMUM_SIZE"]
  file_deps   = ["tomcat_config_update"]
  enabled     = true
  depends_on  = [shoreline_file.tomcat_config_update]
}

