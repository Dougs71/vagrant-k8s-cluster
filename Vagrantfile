NODES = 3
BOX = "ubuntu/xenial64"    

Vagrant.configure("2") do |config|
  config.vbguest.auto_update = false
  config.vm.box_check_update = false
  config.vm.box = BOX
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  config.ssh.insert_key = false

  config.vm.define "master" do |master|
    master.vm.hostname = "master"
    master.vm.network "private_network", ip: "10.0.0.1", netmask: "255.255.255.0", auto_config: true

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
      node.vm.network "private_network", ip: "10.0.0.#{node_id+1}", netmask: "255.255.255.0", auto_config: true

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