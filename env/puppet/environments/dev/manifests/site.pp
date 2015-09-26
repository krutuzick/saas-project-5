#System software
#####################################################################################################

node default {
  package { 'mc': ensure => 'present' }

#  service { 'iptables': ensure => 'stopped' }
  
  include ::php
}

