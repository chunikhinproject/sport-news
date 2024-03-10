variable "gcp_credentials" {
  type        = string
  description = "Location of service account for GCP"
}

variable "gcp_project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "gcp_region" {
  type        = string
  description = "GCP Region"
}

variable "gke_cluster_name" {
  type        = string
  description = "GKE Cluster Name"
}

variable "gke_zones" {
  type        = list(string)
  description = "List of zones for the GKE Cluster"
}

variable "gke_regional" {
  type        = bool
  description = "Is the GKE Cluster regional"
}

variable "gke_network" {
  type        = string
  description = "VPC Network name"
}

variable "gke_subnetwork" {
  type        = string
  description = "VPC Sub Network name"
}

variable "gke_default_nodepool_name" {
  type        = string
  description = "GKE Default node pool name"
}

variable "gke_service_account_name" {
  type        = string
  description = "GKE Service Account Name"
}

variable "pubsub_htafc_topic_name" {
  type        = string
  description = "PubSub HTAFC Topic Name"
}

variable "redis_name" {
  description = "Name of Redis"
  default     = "sport-news-cache"
}

variable "redis_tier" {
  description = "Tier of Redis"
  default     = "BASIC"
}

variable "redis_memory_size_gb" {
  type        = number
  description = "Size of Redis memory"
  default     = 1
}

variable "redis_replica_count" {
  type        = number
  description = "Redis's replica count"
  default     = 0
}

variable "redis_network" {
  description = "Network of Redis"
  default     = "default"
}

variable "redis_replicas_mode" {
  description = "If enabled read endpoint will be provided and the instance can scale up and down the number of replicas"
  default     = "READ_REPLICAS_DISABLED"
}

variable "redis_version" {
  description = "Version of Redis"
  default     = "REDIS_6_X"
}

variable "redis_display_name" {
  default     = "Sport News Cache"
  description = "Display name for Redis service"
}
