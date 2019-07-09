IPADDR=`ifconfig enp0s8 | grep -i Mask | awk '{print $2}'| cut -f2 -d:`
NODENAME=$(hostname -s)
sudo kubeadm init --apiserver-cert-extra-sans=$IPADDR --apiserver-advertise-address=$IPADDR --node-name $NODENAME
sudo kubeadm token create --print-join-command > /vagrant/kubeadm_join.sh
sudo chown $(id -u):$(id -g) /vagrant/kubeadm_join_cmd.sh
sudo sysctl net.bridge.bridge-nf-call-iptables=1
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
kubectl version