resource "google_compute_instance" "single_server" {
    name         = var.instance_name
    machine_type = var.machine_type

    boot_disk {
        initialize_params {
            image = "ubuntu-1804-lts"
        }
    }

    network_interface {
        network = "default"

        access_config {
            // Assigns Ephemeral public IP    
        }
    }

    # metadata_startup_script = "echo 'Hello from Terraform!' > index.html ; nohup busybox httpd -f -p 8080 &"

    # Same but readable:
    metadata_startup_script = <<-EOF
                              echo 'Hello from Terraform!' > index.html
                              nohup busybox httpd -f -p 8080 &
                              EOF
}

resource "google_compute_firewall" "single_server_firewall_rule" {
    name    = "single-server-rule"
    network = "default"

    allow {
        protocol = "tcp"
        ports    = ["8080"]
    }
}
