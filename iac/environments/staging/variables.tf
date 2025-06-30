###GKE###
variable "cluster-name" {
    description = "Node-pool auto-scalling"
}

variable "cluster-version" {
    description = "Node-pool auto-scalling"
}

variable "node-group-name" {
  type        = string
}
