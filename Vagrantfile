# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.7.4"

Vagrant.configure(2) do |config|
    config.vm.define "pj5.machine" do |pj5_config|
        # basic configuration
        # Custom prepared box file - /env/box/pj5.puppetlabs--centos-7.0-64-puppet.box
        # Based on (puppetlabs/centos-7.0-64-puppet) from atlas.hashicorp.com with some provision done
        # Before first "vagrant up" you must register this box via command "vagrant box add pj5 env/box/pj5.puppetlabs--centos-7.0-64-puppet.box"
#         pj5_config.vm.box = 'pj5'
        pj5_config.vm.box = 'puppetlabs/centos-7.0-64-puppet'
        pj5_config.vm.hostname = 'pj5'
        pj5_config.vm.network :private_network, ip: '192.168.54.100'
        
        # virtual machine configuration
        pj5_config.vm.provider "virtualbox" do |v|
            v.gui = false
            v.name = 'pj5.machine'
            v.memory = 1024
            v.cpus = 2
            v.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
        end
    
        # synced folders configuration
        # VirtualBox default sharing - through vboxsf filesystem. Unfortunately, it is not supporting harlinks and have problems with taring symlinks.
        # So, folders sharing is implemented with rsync (which is less convinient... but it is far more fast, which is nice)
#         pj5_config.vm.synced_folder ".", "/home/vagrant/public_html",
#            owner: "vagrant", 
#            group: "vagrant",
#            mount_options: [ "dmode=775,fmode=764" ]
        pj5_config.vm.synced_folder ".", "/home/vagrant/public_html", type: "rsync", rsync__exclude: [ ".git/", ".gitignore", "Vagrantfile", "env/box" ], rsync__args: ["--verbose", "--archive", "-z"]
    end
    
    # provisioning configuration
#     config.vm.provision "puppet", run: "always" do |puppet|
#         puppet.manifests_path = "env/puppet/manifests"
#         puppet.module_path = "env/puppet/modules"
#         puppet.manifest_file = "singlenode.pp"
#         puppet.hiera_config_path = "env/puppet/extra/hiera.yaml"
#     end
    
    $shell_provision = <<SCRIPT
# TODO: composer install -n
# TODO: delete symfony cache

SCRIPT
    config.vm.provision "shell", privileged: false, run: "always", inline: $shell_provision
end
