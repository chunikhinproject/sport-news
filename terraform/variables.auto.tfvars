// gcp variables
gcp_credentials = "credentials.json"
gcp_project_id  = "sport-news-416201"
gcp_region      = "us-west1"

// gke variables
gke_zones                 = ["us-west1-a"]
gke_regional              = false
gke_network               = "default"
gke_subnetwork            = "default"
gke_service_account_name  = "terraform-sa@sport-news-416201.iam.gserviceaccount.com"
gke_cluster_name          = "sport-news-cluster"
gke_default_nodepool_name = "sport-news-nodepool"

// pubsub variables
pubsub_htafc_topic_name = "htafc-feeds"
