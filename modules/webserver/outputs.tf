output "public_ip" {
    value = google_compute_instance.single_server.network_interface.0.access_config.0.nat_ip
}
