resource "local_file" "ansible_inventory" {
  filename = "../ansible/inventory.ini"

  content = <<EOF
[frontend]
c8.local ansible_host=${aws_instance.amazon_vm.public_ip} ansible_user=ec2-user

[backend]
u21.local ansible_host=${aws_instance.ubuntu_vm.public_ip} ansible_user=ubuntu

[all:vars]
ansible_ssh_private_key_file=~/.ssh/NV.pem
EOF
}
