# == Class: osconfig
#
# Performs initial configuration of the os itself.
#
class osconfig {
  notify {
    ">>>>> This is a message from Puppet's osconfig module!":
  }

  exec { 'apt-get update':
    command => '/usr/bin/apt-get update';
  }

  # Set up vagrant user. Vagrant itself already does this,
  # but we need to give Puppet a resource to make modifications:
  user { 'vagrant':
    ensure => present,
    comment => 'Vagrant,,,',
    home => '/home/vagrant',
    managehome => true,
    password => 'vagrant',
  }
  # Set our SSH public key for the vagrant user
  ssh_authorized_key { 'vagrant-ssh':
    user => 'vagrant',
    type => 'rsa',
    key => 'AAAAB3NzaC1yc2EAAAABJQAAAIBpFV/LLEbj3JEu277cA1zEwdGdTfPATitYyl6Vvy4zOtyLbFXM6opfVvaTYwsp1fn+mO56RvA7YKNK4tkPr3s4b8EFWKw1ViXVK38ViQNcTa6oF8Y/bKtPZ7NHviGKfQ9XiiUhjsJjSYa7cLF9KZAZS3t6ZSHF+vFhBKOahjGuAQ==',
  }
  ssh_authorized_key { 'vagrant-ssh-lake':
    user => 'vagrant',
    type => 'rsa',
    key => 'AAAAB3NzaC1yc2EAAAABJQAAAIBezytodhxJD0cQMot7qQKq+IJzj+g+lPVOwiWJHMRUEsonU5Lbe8iUoeQPj8tqJGLCSO5l6xRqtR2m6htTIoeAj73Bex8ZzXodtSPiOY5rmxeGzaWV+Q2qHB/obdY+rCY1vnhya48a9VrC41BucvKaboySN3yseF2t5aakRkTZJw==',
  }

  # Set customized .bashrc for vagrant user
  file {
    '/home/vagrant/.bashrc':
      owner => 'vagrant',
      group => 'vagrant',
      mode  => '0644',
      source => 'puppet:///modules/osconfig/bashrc';
  }

  # Example creating a file with inline content
  file {
    '/home/vagrant/example.txt':
      owner => 'vagrant',
      group => 'vagrant',
      mode  => '0644',
      content =>
'Hello, node-dev!
How ya doing?
';
  }

}
