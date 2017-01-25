# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "xenial-lxc"

  config.vm.synced_folder ".", "/app"

  config.vm.provision :shell, inline: %[
    # Set up Docker repository
    apt-get install apt-transport-https ca-certificates
    curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -
    apt-key fingerprint 58118E89F3A912897C070ADBF76221572C52609D
    sudo add-apt-repository "deb https://apt.dockerproject.org/repo/ ubuntu-$(lsb_release -cs) main"
    apt-get update

    # Install Docker
    apt -y install docker-engine
  ]

  config.vm.provision :shell, privileged: false, inline: %[
    # Include $HOME/.local/bin in the PATH
    echo "export PATH=\$HOME/.local/bin:\$PATH" >> .profile

    # Install Haskell Stack
    sudo curl -sSL https://get.haskellstack.org/ | sh

    # Download GHC for the app
    cd /app
    stack setup

    # Build and install the app into $HOME/.local/bin
    stack install
  ]
end
