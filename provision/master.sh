sudo apt-get update && apt-get install -y apt-transport-https curl
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
IPADDR=`ifconfig enp0s8 | grep -i Mask | awk '{print $2}'| cut -f2 -d:`
echo $IPADDR > /vagrant/ip-address.txt
NODENAME=$(hostname -s)
sudo sed -i '0,/ExecStart=/s//Environment="KUBELET_EXTRA_ARGS=--cgroup-driver=cgroupfs"\n&/' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
sudo kubeadm init --apiserver-cert-extra-sans=$IPADDR --apiserver-advertise-address=$IPADDR --node-name $NODENAME
sudo kubeadm token create --print-join-command > /vagrant/kubeadm_join_cmd.sh
sudo chown $(id -u):$(id -g) /vagrant/kubeadm_join_cmd.sh
sudo sysctl net.bridge.bridge-nf-call-iptables=1
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
kubectl version