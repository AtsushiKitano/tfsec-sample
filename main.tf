resource "google_compute_network" "main" {
  name                    = "sample"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "main" {
  name          = "sample"
  ip_cidr_range = "192.168.0.0/24"
  region        = "asia-northeast1"
  network       = google_compute_network.main.self_link
}

resource "google_compute_firewall" "main" {
  name        = "sample"
  network     = google_compute_network.main.self_link
  priority    = 1000
  target_tags = []

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"] #tfsec:ignore:GCP003

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
