sudo ufw disable
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker vagrant
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg --output apt-key.gpg
sudo apt-key add apt-key.gpg
sudo rm -f apt-key.gpg
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo sh /vagrant/kubeadm_join_cmd.sh