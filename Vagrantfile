# Script comum para todas as máquinas
$script_common = <<-'SCRIPT'
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get install -y ansible dos2unix sshpass tree

    if [ -d "/vagrant/ansible" ]; then
        cd /vagrant/ansible
        dos2unix *.yml 2>/dev/null
        dos2unix hosts 2>/dev/null
    fi
SCRIPT

Vagrant.configure("2") do |config|
  # Configuração Global de Box (para não repetir em todas)
  config.vm.box = "bento/ubuntu-24.04"

  # =================================================================
  # CONFIGURAÇÃO DO MASTER
  # =================================================================
  config.vm.define "master" do |master|
    master.vm.hostname = "master"
    master.vm.network "private_network", ip: "192.168.154.100"

    # Recursos específicos do Master
    master.vm.provider "vmware_workstation" do |v|
      v.cpus = 2
      v.memory = 2048
    end

    master.vm.provision "shell", inline: $script_common

    master.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "ansible/installdocker.yml"
      ansible.inventory_path = "ansible/hosts"
      ansible.limit = "master"
    end

    master.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "ansible/installkubernetesmaster.yml"
      ansible.inventory_path = "ansible/hosts"
      ansible.limit = "master"
    end

    master.vm.provision "shell", inline: <<-SHELL
      echo "Gerando token de join..."
      kubeadm token create --print-join-command > /vagrant/join-command
    SHELL
  end

  # =================================================================
  # CONFIGURAÇÃO DO WORKER 1
  # =================================================================
  config.vm.define "worker1" do |w1|
    w1.vm.hostname = "worker1"
    w1.vm.network "private_network", ip: "192.168.154.101"

    # Recursos específicos do Worker 1
    w1.vm.provider "vmware_workstation" do |v|
      v.cpus = 2
      v.memory = 2048
    end

    w1.vm.provision "shell", inline: $script_common

    w1.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "ansible/installdocker.yml"
      ansible.inventory_path = "ansible/hosts"
      ansible.raw_arguments = ["--connection=local"] 
    end

    w1.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "ansible/installkubernetesworker1.yml"
      ansible.inventory_path = "ansible/hosts"
      ansible.raw_arguments = ["--connection=local"]
    end

    w1.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "ansible/ingressarworker1.yml"
      ansible.inventory_path = "ansible/hosts"
      ansible.raw_arguments = ["--connection=local"]
    end
  end

  # =================================================================
  # CONFIGURAÇÃO DO WORKER 2
  # =================================================================
  config.vm.define "worker2" do |w2|
    w2.vm.hostname = "worker2"
    w2.vm.network "private_network", ip: "192.168.154.102"

    # Recursos específicos do Worker 2
    w2.vm.provider "vmware_workstation" do |v|
      v.cpus = 2
      v.memory = 2048
    end

    w2.vm.provision "shell", inline: $script_common

    w2.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "ansible/installdocker.yml"
      ansible.inventory_path = "ansible/hosts"
      ansible.raw_arguments = ["--connection=local"] 
    end

    w2.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "ansible/installkubernetesworker2.yml"
      ansible.inventory_path = "ansible/hosts"
      ansible.raw_arguments = ["--connection=local"]
    end

    w2.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "ansible/ingressarworker2.yml"
      ansible.inventory_path = "ansible/hosts"
      ansible.raw_arguments = ["--connection=local"]
    end
  end

end