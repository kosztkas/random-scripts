# Generate inventory file for Ansible, directly from TF
resource “local_file” “inventory” {
 filename = “./inventory/hosts.ini”
 content = <<EOF
[k8s_nodes]
%{for w_ip in proxmox_vm_qemu.kube-worker[*].ipconfig0}
${w_ip}
%{endfor}
[k8s_control]
%{for m_ip in proxmox_vm_qemu.kube-master[*].ipconfig0}
${m_ip}
%{endfor}
EOF
