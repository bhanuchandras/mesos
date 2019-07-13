data "template_file" "test" {
  template = "${file("./hosts.tpl")}"
  vars =   {
   master-ip = "${google_compute_instance.master.network_interface.0.access_config.0.nat_ip}"
   slave-ip = "${google_compute_instance.slave.network_interface.0.access_config.0.nat_ip}"
  }
}
resource "null_resource" "export_rendered_template" {
provisioner "local-exec" {
    command = "cat >host.json <<EOL\n${data.template_file.test.rendered}\nEOL"
  }
provisioner "local-exec" {
   command = "echo ${google_compute_instance.slave.network_interface.0.access_config.0.nat_ip} > slave_ip.txt"
  }
provisioner "local-exec" {
   command = "echo ${google_compute_instance.master.network_interface.0.access_config.0.nat_ip} > master_ip.txt"
  }
provisioner "local-exec" {
   command = "echo zk://${google_compute_instance.master.network_interface.0.access_config.0.nat_ip}:2181/mesos > zk_master.txt"
  }
provisioner "local-exec" {
   command = <<EOT
            echo MARATHON_MESOS_USER=root > marathon.txt
            echo MARATHON_MASTER=zk://${google_compute_instance.master.network_interface.0.access_config.0.nat_ip}:2181/mesos >> marathon.txt
            echo MARATHON_ZK=zk://${google_compute_instance.master.network_interface.0.access_config.0.nat_ip}:2181/marathon >> marathon.txt
   EOT
  }
}
