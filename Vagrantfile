# -*- mode: ruby -*-
# vi: set ft=ruby :

def install_plugin(plugin)
  system "vagrant plugin install vagrant-env vagrant-vbguest" unless Vagrant.has_plugin? plugin
end

install_plugin('vagrant-env')
install_plugin('vagrant-vbguest')

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.env.enable # enable the plugin
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/bionic64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 80, host: 80, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 8080, host: 8080, host_ip: "127.0.0.1"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false

    vb.cpus = ENV['CPUS']
    # Customize the amount of memory on the VM:
    vb.memory = ENV['MEMORY']
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
  
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo apt-key fingerprint 0EBFCD88
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    sudo groupadd docker
    sudo usermod -aG docker vagrant
    sudo /bin/systemctl restart docker.service
    sudo curl -L "https://github.com/docker/compose/releases/download/1.27.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y python3 python3-pip nodejs npm
    sudo apt-get install -y python3-venv
    pip3 install aws-mfa

    sudo npm install n -g
    sudo n stable
    sudo apt purge -y nodejs npm
    sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
    npm install -g aws-cdk

    echo "export PATH=/home/vagrant/.local/bin:\$PATH" >> /home/vagrant/.bashrc
    echo "alias aws='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'" >> /home/vagrant/.bashrc
    echo "export MFA_DEVICE=\"#{ENV['MFA_DEVICE']}\"" >> /home/vagrant/.bashrc
    source /home/vagrant/.bashrc

    docker pull amazon/aws-cli
    docker run --rm -v /home/vagrant/.aws:/root/.aws amazon/aws-cli configure set aws_access_key_id "#{ENV['AWS_ACCESS_KEY_ID']}" --profile default-long-term
    docker run --rm -v /home/vagrant/.aws:/root/.aws amazon/aws-cli configure set aws_secret_access_key "#{ENV['AWS_SECRET_ACCESS_KEY']}" --profile default-long-term
    docker run --rm -v /home/vagrant/.aws:/root/.aws amazon/aws-cli configure set region ap-northeast-1 --profile default-long-term
    docker run --rm -v /home/vagrant/.aws:/root/.aws amazon/aws-cli configure set format json --profile default-long-term
    sudo chown -R vagrant:vagrant /home/vagrant/.aws

    git config --system user.name "#{ENV['GIT_USER_NAME']}"
    git config --system user.email "#{ENV['GIT_USER_EMAIL']}"
  SHELL
end
