module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.gcp_project_id
  name                       = var.gke_cluster_name
  region                     = var.gcp_region
  regional                   = var.gke_regional
  ip_range_pods              = ""
  ip_range_services          = ""
  zones                      = var.gke_zones
  network                    = var.gke_network
  subnetwork                 = var.gke_subnetwork
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  deletion_protection        = false

  node_pools = [
    {
      name               = var.gke_default_nodepool_name
      machine_type       = "e2-small"
      min_count          = 1
      max_count          = 1
      local_ssd_count    = 0
      spot               = false
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS_CONTAINERD"
      enable_gcfs        = false
      enable_gvnic       = false
      logging_variant    = "DEFAULT"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = var.gke_service_account_name
      preemptible        = true
      initial_node_count = 1
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}

module "pubsub" {
  source = "terraform-google-modules/pubsub/google"

  topic      = var.pubsub_htafc_topic_name
  project_id = var.gcp_project_id
}


resource "google_app_engine_application" "sport_news" {
  project       = var.gcp_project_id
  location_id   = var.gcp_region
  database_type = "CLOUD_FIRESTORE"
}

resource "google_project_service" "firestore" {
  project                    = var.gcp_project_id
  service                    = "firestore.googleapis.com"
  disable_dependent_services = true
  depends_on                 = [
    google_app_engine_application.sport_news
  ]
}

resource "google_redis_instance" "cache" {
  project            = var.gcp_project_id
  region             = var.gcp_region
  name               = var.redis_name
  tier               = var.redis_tier
  memory_size_gb     = var.redis_memory_size_gb
  replica_count      = var.redis_replica_count
  authorized_network = var.redis_network
  read_replicas_mode = var.redis_replicas_mode
  redis_version      = var.redis_version
  display_name       = var.redis_display_name
}
