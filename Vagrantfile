Vagrant.configure("2") do |config|
    NODES = 1
    BOX = "ubuntu/xenial64"    
    config.vbguest.auto_update = false
    config.vm.box_check_update = false
    config.vm.box = BOX
    config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
    config.ssh.insert_key = false
  
    config.vm.define "master" do |master|
      master.vm.hostname = "master"
  
      config.vm.provider "virtualbox" do |vb|
        vb.name = "master"
        vb.memory = "2048"
        vb.cpus = "2"
      end
  
      master.vm.network "private_network", ip: "10.69.0.1"
      master.vm.provision "shell", path: "provision/master.sh", privileged: false
    end
  
    (1..NODES).each do |node_id|
      config.vm.define "node#{node_id}" do |node|
        node.vm.box = BOX
        node.vm.hostname = "node#{node_id}"
        node.vm.network "private_network", ip: "10.69.0.#{1+node_id}"
  
        node.vm.provider "virtualbox" do |vb|
          vb.memory = "2048"
          vb.cpus = "2"
          vb.name = "node#{node_id}"
        end
        node.vm.provision "shell", path: "provision/node.sh", privileged: false
    end

    #config.vm.provision "shell", path: "provision/common.sh", privileged: true
  end
end