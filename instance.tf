resource "google_compute_instance" "master" {
  project      = "bhanu-mesos"
  name         = "mesos-master"
  machine_type = "n1-standard-1"
  zone         = "asia-south1-c"

  boot_disk {
    initialize_params {
      image = "rhel-cloud/rhel-7"
      type  = "pd-standard"
      size  = 20
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
tags = ["http-server"]
}

resource "google_compute_instance" "slave" {
  project      = "bhanu-mesos"
  name         = "mesos-slave"
  machine_type = "n1-standard-1"
  zone         = "asia-south1-c"

  boot_disk {
    initialize_params {
      image = "rhel-cloud/rhel-7"
      type  = "pd-standard"
      size  = 20
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
tags = ["http-server"]
}
