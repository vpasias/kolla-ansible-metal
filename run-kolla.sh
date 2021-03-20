#! /bin/sh

export LC_ALL=C
export LC_CTYPE="UTF-8",
export LANG="en_US.UTF-8"

# ---- PART ONE ------
# Configure SSH connectivity from 'deployment' - server104 to Target Hosts 

echo 'run-kolla.sh: Cleaning directory /home/vagrant/.ssh/'
rm -f /home/vagrant/.ssh/known_hosts
rm -f /home/vagrant/.ssh/id_rsa
rm -f /home/vagrant/.ssh/id_rsa.pub

echo 'run-kolla.sh: Running ssh-keygen -t rsa'
ssh-keygen -q -t rsa -N "" -f /home/vagrant/.ssh/id_rsa

echo 'run-kolla.sh: Install sshpass'
sudo apt-get install sshpass -y

echo 'run-kolla.sh: Running ssh-copy-id vagrant@server101 - Controller 1'
sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no vagrant@server101
echo 'run-kolla.sh: Running ssh-copy-id vagrant@server301 - Controller 2'
sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no vagrant@server301
echo 'run-kolla.sh: Running ssh-copy-id vagrant@server501 - Controller 3'
sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no vagrant@server501

echo 'run-kolla.sh: Running ssh-copy-id vagrant@server102 - Compute 1'
sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no vagrant@server102
echo 'run-kolla.sh: Running ssh-copy-id vagrant@server103 - Compute 2'
sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no vagrant@server103
echo 'run-kolla.sh: Running ssh-copy-id vagrant@server302 - Compute 3'
sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no vagrant@server302
echo 'run-kolla.sh: Running ssh-copy-id vagrant@server303 - Compute 4'
sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no vagrant@server303
echo 'run-kolla.sh: Running ssh-copy-id vagrant@server502 - Compute 5'
sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no vagrant@server502
echo 'run-kolla.sh: Running ssh-copy-id vagrant@server503 - Compute 6'
sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no vagrant@server503

echo 'run-kolla.sh: Running scp controller_setup.sh vagrant@server101:/home/vagrant/controller_setup.sh'
scp -o StrictHostKeyChecking=no controller_setup.sh vagrant@server101:/home/vagrant/controller_setup.sh
echo 'run-kolla.sh: Running scp controller_setup.sh vagrant@server301:/home/vagrant/controller_setup.sh'
scp -o StrictHostKeyChecking=no controller_setup.sh vagrant@server301:/home/vagrant/controller_setup.sh
echo 'run-kolla.sh: Running scp controller_setup.sh vagrant@server501:/home/vagrant/controller_setup.sh'
scp -o StrictHostKeyChecking=no controller_setup.sh vagrant@server501:/home/vagrant/controller_setup.sh

echo 'run-kolla.sh: Running scp controller_setup.sh vagrant@server102:/home/vagrant/compute_setup.sh'
scp -o StrictHostKeyChecking=no compute_setup.sh vagrant@server102:/home/vagrant/compute_setup.sh
echo 'run-kolla.sh: Running scp controller_setup.sh vagrant@server103:/home/vagrant/compute_setup.sh'
scp -o StrictHostKeyChecking=no compute_setup.sh vagrant@server103:/home/vagrant/compute_setup.sh
echo 'run-kolla.sh: Running scp controller_setup.sh vagrant@server302:/home/vagrant/compute_setup.sh'
scp -o StrictHostKeyChecking=no compute_setup.sh vagrant@server302:/home/vagrant/compute_setup.sh
echo 'run-kolla.sh: Running scp controller_setup.sh vagrant@server303:/home/vagrant/compute_setup.sh'
scp -o StrictHostKeyChecking=no compute_setup.sh vagrant@server303:/home/vagrant/compute_setup.sh
echo 'run-kolla.sh: Running scp controller_setup.sh vagrant@server502:/home/vagrant/compute_setup.sh'
scp -o StrictHostKeyChecking=no compute_setup.sh vagrant@server502:/home/vagrant/compute_setup.sh
echo 'run-kolla.sh: Running scp controller_setup.sh vagrant@server503:/home/vagrant/compute_setup.sh'
scp -o StrictHostKeyChecking=no compute_setup.sh vagrant@server503:/home/vagrant/compute_setup.sh

echo 'run-kolla.sh: Running ssh vagrant@server101 "sudo bash /home/vagrant/controller_setup.sh"'
ssh -o StrictHostKeyChecking=no vagrant@server101 "sudo bash /home/vagrant/controller_setup.sh"
echo 'run-kolla.sh: Running ssh vagrant@server301 "sudo bash /home/vagrant/controller_setup.sh"'
ssh -o StrictHostKeyChecking=no vagrant@server301 "sudo bash /home/vagrant/controller_setup.sh"
echo 'run-kolla.sh: Running ssh vagrant@server501 "sudo bash /home/vagrant/controller_setup.sh"'
ssh -o StrictHostKeyChecking=no vagrant@server501 "sudo bash /home/vagrant/controller_setup.sh"

echo 'run-kolla.sh: Running ssh vagrant@server102 “sudo bash /home/vagrant/compute_setup.sh”'
ssh -o StrictHostKeyChecking=no vagrant@server102 "sudo bash /home/vagrant/compute_setup.sh"
echo 'run-kolla.sh: Running ssh vagrant@server103 “sudo bash /home/vagrant/compute_setup.sh”'
ssh -o StrictHostKeyChecking=no vagrant@server103 "sudo bash /home/vagrant/compute_setup.sh"
echo 'run-kolla.sh: Running ssh vagrant@server302 “sudo bash /home/vagrant/compute_setup.sh”'
ssh -o StrictHostKeyChecking=no vagrant@server302 "sudo bash /home/vagrant/compute_setup.sh"
echo 'run-kolla.sh: Running ssh vagrant@server303 “sudo bash /home/vagrant/compute_setup.sh”'
ssh -o StrictHostKeyChecking=no vagrant@server303 "sudo bash /home/vagrant/compute_setup.sh"
echo 'run-kolla.sh: Running ssh vagrant@server502 “sudo bash /home/vagrant/compute_setup.sh”'
ssh -o StrictHostKeyChecking=no vagrant@server502 "sudo bash /home/vagrant/compute_setup.sh"
echo 'run-kolla.sh: Running ssh vagrant@server503 “sudo bash /home/vagrant/compute_setup.sh”'
ssh -o StrictHostKeyChecking=no vagrant@server503 "sudo bash /home/vagrant/compute_setup.sh"

ssh -o StrictHostKeyChecking=no vagrant@server102 "sudo pvcreate /dev/sda && sudo vgcreate cinder-volumes /dev/sda"
#ssh -o StrictHostKeyChecking=no vagrant@server102 "sudo pvcreate /dev/sda && sudo pvcreate /dev/sdb && sudo vgcreate cinder-volumes /dev/sda /dev/sdb && lvcreate -L 100G -m1 -n lv_mirror cinder-volumes"
ssh -o StrictHostKeyChecking=no vagrant@server302 "sudo pvcreate /dev/sda && sudo vgcreate cinder-volumes /dev/sda"
ssh -o StrictHostKeyChecking=no vagrant@server502 "sudo pvcreate /dev/sda && sudo vgcreate cinder-volumes /dev/sda"
ssh -o StrictHostKeyChecking=no vagrant@server103 "sudo pvcreate /dev/sda && sudo vgcreate cinder-volumes /dev/sda"
ssh -o StrictHostKeyChecking=no vagrant@server303 "sudo pvcreate /dev/sda && sudo vgcreate cinder-volumes /dev/sda"
ssh -o StrictHostKeyChecking=no vagrant@server503 "sudo pvcreate /dev/sda && sudo vgcreate cinder-volumes /dev/sda"

ssh -o StrictHostKeyChecking=no vagrant@server102 "lsblk && sudo vgs"
ssh -o StrictHostKeyChecking=no vagrant@server302 "lsblk && sudo vgs"
ssh -o StrictHostKeyChecking=no vagrant@server502 "lsblk && sudo vgs"
ssh -o StrictHostKeyChecking=no vagrant@server103 "lsblk && sudo vgs"
ssh -o StrictHostKeyChecking=no vagrant@server303 "lsblk && sudo vgs"
ssh -o StrictHostKeyChecking=no vagrant@server503 "lsblk && sudo vgs"

# ---- PART TWO ----
# Install Ansible and Kolla-Ansible

sudo bash deployment_setup.sh
sudo bash controller_setup.sh

sudo apt update -y && sudo apt install python3-dev libffi-dev gcc libssl-dev python3-venv python3-pip -y

echo 'run-kolla.sh: Running sudo pip install ansible<2.10'
sudo pip3 install --upgrade pip
sudo pip install -U 'ansible<2.10'

if [ $? -ne 0 ]; then
  echo "Cannot install Ansible"
  exit $?
fi

echo 'run-kolla.sh: Running sudo pip install kolla-ansible'
sudo pip install kolla-ansible

if [ $? -ne 0 ]; then
  echo "Cannot install kolla-ansible"
  exit $?
fi

# ---- PART THREE ----
# Prepare Deployment Parameter Files
# See also: https://shreddedbacon.com/post/openstack-kolla/

echo 'run-kolla.sh: Running sudo cp -r /usr/local/share/kolla-ansible/etc_examples/kolla /etc/kolla'
sudo cp -r /usr/local/share/kolla-ansible/etc_examples/kolla /etc/kolla
echo 'run-kolla.sh: Running sudo cp globals.yml /etc/kolla'
sudo cp globals.yml /etc/kolla

cat << EOF | sudo tee /etc/kolla/config/nfs_shares
nfs:/sharedvol
EOF

# ---- PART FOUR ----
# Run Kolla-Ansible Playbooks

export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_LOG_PATH=ansible.log

echo 'run-kolla.sh: Running sudo kolla-genpwd'
sudo kolla-genpwd

echo 'run-kolla.sh: Running kolla-ansible -i multinode bootstrap-servers'
kolla-ansible -i multinode bootstrap-servers

if [ $? -ne 0 ]; then
  echo "Bootstrap servers failed"
  exit $?
fi

echo 'run-kolla.sh: Running kolla-ansible -i multinode prechecks'
kolla-ansible -i multinode prechecks

if [ $? -ne 0 ]; then
  echo "Prechecks failed"
  exit $?
fi

echo 'run-kolla.sh: Running kolla-ansible -i multinode deploy'
kolla-ansible -i multinode deploy

if [ $? -ne 0 ]; then
  echo "Deploy failed"
  exit $?
fi

echo 'run-kolla.sh: Running sudo kolla-ansible -i multinode post-deploy'
sudo kolla-ansible post-deploy

# ---- PART FIVE ----
# Install OpenStack Client and "populate" OpenStack Deployment with Image, Flavors & Networks

echo 'run-kolla.sh: Running sudo apt install python3-openstackclient'
sudo apt install python3-openstackclient -y

echo 'run-kolla.sh: Running sudo cp init-runonce /usr/local/share/kolla-ansible/init-runonce'
sudo cp init-runonce /usr/local/share/kolla-ansible/init-runonce
#echo 'run-kolla.sh: Running cd /usr/local/share/kolla-ansible'
#cd /usr/local/share/kolla-ansible
#echo 'run-kolla.sh: Running sudo ./init-runonce'
#cat <<-EOF | sudo su
#. /etc/kolla/admin-openrc.sh
#./init-runonce
#EOF
echo "Horizon available at 172.16.1.250, user 'admin', password below:"
grep keystone_admin_password /etc/kolla/passwords.yml
