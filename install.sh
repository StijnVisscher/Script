#Toevoegen van Zabbix, Salt en Kubernetes
wget https://repo.zabbix.com/zabbix/4.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.2-1+bionic_all.deb
dpkg -i zabbix-release_4.2-1+bionic_all.deb
sudo add-apt-repository -y ppa:saltstack/salt
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-add-repository -y "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt update
sudo apt upgrade -y
# Installatie van Applicaties
sudo apt install -y salt-minion
sudo sed -i -e 's/#master: salt/master: 10.2.3.25/g' /etc/salt/minion
sudo apt install -y zabbix-agent
sudo apt install -y python3-pip
sudo pip3 install docker
sudo apt install -y kubeadm kubelet kubectl
#Activeren van salt
sudo systemctl enable salt-minion
sudo systemctl start salt-minion

if [ "$HOSTNAME" = UB-372933 ] | [ "$HOSTNAME" = master ];then
	echo "Master installatie wordt uitgevoert"
	sudo apt install -y docker.io
	sudo apt install -y syslog-ng
	sudo apt install -y salt-master salt-ssh salt-cloud salt-doc
	#sudo echo '10.2.3.25 k8s-master /n10.2.3.27 worker01' >>/etc/hosts
	#sudo systemctl enable docker.service
	#sudo echo "source net { udp(); };" >> /etc/syslog-ng/syslog-ng.conf
	#sudo echo "destination remote { file("/var/log/remote/${FULLHOST}"); };" >> /etc/syslog-ng/syslog-ng.conf
	#sudo echo "log { source(net); destination(remote); };" >> /etc/syslog-ng/syslog-ng.conf
	sudo service syslog-ng restart
	#sudo mkdir =p /srv/{salt, pillar}
	#sudo cp /states/* /srv/salt/
	#sudo cp /pillar/* /srv/pillar/
	#sudo sed -i -e 's/# file_roots:/file_roots:/g' /etc/salt/minion
	#sudo sed -i -e 's/#   base:/  base:/g' /etc/salt/minion
	#sudo sed -i -e 's/#     - /srv/salt//    - /srv/salt/g' /etc/salt/minion
	#sudo sed -i -e 's/# pillar_roots:/pillar_roots:/g' /etc/salt/minion
	#sudo sed -i -e 's/#   base:/  base:/g' /etc/salt/minion
	#sudo sed -i -e 's/#     - /srv/pillar//    - /srv/pillar/g' /etc/salt/minion
	#sudo rm -R states
	#sudo rm -R pillar
	sudo service salt-master restart
	sudo service salt-minion restart
	#sudo salt '*' state.highstate
	#sudo swapoff -a
	#sudo kubeadm init
	#mkdir -p $HOME/.kube
	#sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
	#sudo chown $(id -u):$(id -g) $HOME/.kube/config
	#sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
	#sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
else
	echo "Minion installatie wordt uitgevoert"	
	sudo apt install -y syslog-ng
	#sudo echo "destination remote { network("10.2.3.25" transport("udp") port(514)); };" >> /etc/syslog-ng/syslog-ng.conf
	sudo service syslog-ng restart
	#sudo rm -R states
	#sudo rm -R pillar
	#sudo rm /etc/apt/sources.list.d/saltstack-ubuntu-salt-bionic.list
	#sudo swapoff -a
	#sudo kubeadm join 10.2.3.25:6443 --token huvqet.9fz2uzk8dh587kr0 --discovery-token-ca-cert-hash sha256:c7d6ee14b1180569ea85e02965ef318e9a5bbe1d55149a51002d757063313dd4

fi