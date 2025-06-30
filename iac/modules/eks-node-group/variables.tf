variable "cluster-name" {
  type        = string
}

variable "node-group-name" {
  type        = string
}

variable "node_role_arn" {
  type        = string
}

variable "cluster-subnet-ids" {
  type        = list(string)
}
