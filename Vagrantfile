# -*- mode: ruby -*-
# vi: set ft=ruby :

if ENV.has_key?("WINDIR")
    # for rsync to work
    ENV["VAGRANT_DETECTED_OS"] = ENV["VAGRANT_DETECTED_OS"].to_s + " cygwin"
end

Vagrant.require_version ">= 1.7.4"

Vagrant.configure(2) do |config|
    config.vm.define "pj5.machine" do |pj5_config|
        # basic configuration
        # Custom prepared box file - /env/box/pj5.puppetlabs-ubuntu-14.04-64-puppet.box
        # Based on (puppetlabs/ubuntu-14.04-64-puppet) from atlas.hashicorp.com with some provision done
        # Before first "vagrant up" you must register this box via command "vagrant box add pj5 env/box/pj5.puppetlabs--centos-7.0-64-puppet.box"
        pj5_config.vm.box = 'puppetlabs/ubuntu-14.04-64-puppet'
#         pj5_config.vm.box = 'pj5'
        pj5_config.vm.hostname = 'pj5'
        pj5_config.vm.network :private_network, ip: '192.168.54.100'

        # virtual machine configuration
        pj5_config.vm.provider "virtualbox" do |v|
            v.gui = false
            v.name = 'pj5.machine'
            v.memory = 4096
            v.cpus = 2
            v.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
            v.customize ["setextradata", :id, "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled", 1]
        end

        # disable ssh key regeneration for development
        pj5_config.ssh.insert_key = false

        # synced folders configuration
        # VirtualBox default sharing - through vboxsf filesystem. Unfortunately, it is not supporting harlinks and have problems with taring symlinks.
        # So, folders sharing is implemented with rsync (which is less convinient... but it is far more fast, which is nice)
#         pj5_config.vm.synced_folder ".", "/var/www/vagrant",
#            owner: "vagrant", 
#            group: "vagrant",
#            mount_options: [ "dmode=775,fmode=764" ]
        pj5_config.vm.synced_folder ".", "/var/www/vagrant", type: "rsync", rsync__exclude: [ ".git/", "env/box", ".idea" ], rsync__args: ["--verbose", "--archive", "-z"]
    end

    # provisioning configuration
    config.vm.provision "bootstrap", type: "shell" do |s1|
       s1.path = "env/bootstrap.sh"
       s1.args = [ Time.new.strftime('%-d %^b %Y %H:%M:%S') ]
    end
    config.vm.provision "startup", type: "shell", run: "always" do |s2|
        s2.path = "env/startup.sh"
    end
#     date_now = Time.new
#     config.vm.provision "shell", name: "Shell_SetTimezone", inline: "sudo timedatectl set-timezone Europe/Moscow"
#     config.vm.provision "shell", name: "Shell_SetDateTime", inline: "sudo date --set=\"" + date_now.strftime('%-d %^b %Y %H:%M:%S') + "\""
    

#     config.vm.provision "puppet", run: "always" do |puppet|
#         puppet.facter = {
#             "facter_system_user"  => "vagrant",
#             "facter_project_path" => "/var/www/vagrant",
#             "facter_machine_ip"   => "192.168.54.100"
#         }
#         puppet.options = "--verbose --debug"
#         puppet.environment_path = "env/puppet/environments"
#         puppet.environment = "dev"
#         puppet.working_directory = "/var/www/vagrant"
#         puppet.hiera_config_path = "env/puppet/hiera.yaml"
#     end

end
