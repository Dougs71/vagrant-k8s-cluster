NODES = 1
BOX = "ubuntu/xenial64"    
ROLE = ""

Vagrant.configure("2") do |config|
  config.vbguest.auto_update = false
  config.vm.box_check_update = false
  config.vm.box = BOX
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  config.ssh.insert_key = false

  config.vm.define "master" do |master|
    master.vm.hostname = "master"
    master.vm.network "public_network"

    config.vm.provider "virtualbox" do |vb|
      vb.name = "master"
      vb.memory = "2048"
      vb.cpus = "2"
    end

    master.vm.provision "shell", path: "provision/master.sh", privileged: false
  end

  (1..NODES).each do |node_id|
    config.vm.define "node#{node_id}" do |node|
      node.vm.hostname = "node#{node_id}"
      node.vm.network "public_network"

      node.vm.provider "virtualbox" do |vb|
        vb.name = "node#{node_id}"
        vb.memory = "2048"
        vb.cpus = "2"
      end

      node.vm.provision "shell", path: "provision/node.sh", privileged: false
    end  
  end

  config.vm.provision "shell", path: "provision/common.sh", privileged: false
end