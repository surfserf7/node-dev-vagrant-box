# == Class: osconfig
#
# Performs initial configuration of the os itself.
#
class osconfig {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update';
  }

#  host { 'hostmachine':
#    ip => '192.168.0.1';
#  }

  file {
    '/home/vagrant/.bashrc':
      owner => 'vagrant',
      group => 'vagrant',
      mode  => '0644',
      source => 'puppet:///modules/osconfig/bashrc';
  }
}
