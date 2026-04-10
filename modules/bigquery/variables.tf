variable "project_id" {
  type = string
}

variable "env" {
  type = string
}

variable "datasets" {
  type        = list(string)
  description = "List of dataset names to create"
  default     = ["raw", "staging", "intermediate", "marts", "features"]
}

variable "location" {
  type    = string
  default = "EU"
}