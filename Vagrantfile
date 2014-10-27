# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here
  config.vm.box = "hashicorp/precise32"
  config.vm.network "forwarded_port", guest: 8080, host: 3000
  config.vm.synced_folder "./app", "/home/vagrant/app"
  config.vm.hostname = "node-dev"
  config.vm.network "private_network", ip: "192.168.2.2"

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file site.pp in the manifests_path directory.
  #
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "site.pp"
    puppet.module_path = "puppet/modules"
  end

  config.vm.post_up_message = "PuppetBox: 192.168.2.2;  port 8080 --> 3000"

end
