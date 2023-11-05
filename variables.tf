
variable YC_TOKEN {}
variable YC_CLOUD_ID {}
variable YC_FOLDER_ID {}
variable YC_ZONE {}
variable worker_count {
  type = number   
  default = 10
}
variable master_count {
  type = number
  default = 3
}

#  variable env {
#  type = string
#  default = terraform.workspace
#}
