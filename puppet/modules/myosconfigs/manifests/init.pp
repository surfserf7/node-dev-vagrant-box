# == Class: myosconfigs
#
# Performs initial configuration of the os itself.
#

class apt_update {
    exec { "aptGetUpdate":
        command => "sudo apt-get update",
        path => ["/bin", "/usr/bin"]
    }
}

class myosconfigs {
  notify {
    ">>>>> Puppet is running the myosconfigs class.":
  }

  include apt_update

  # Set up vagrant user. Vagrant itself already does this,
  # but we need to give Puppet a resource to make modifications:
  user { 'vagrant':
    ensure => present,
    comment => 'Vagrant,,,',
    home => '/home/vagrant',
    managehome => true,
    password => 'vagrant',
  }
  # Set our SSH public keys for the vagrant user
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
      source => 'puppet:///modules/myosconfigs/bashrc';
  }

  # Example creating a file with inline content
  file {
    '/home/vagrant/example.txt':
      owner => 'vagrant',
      group => 'vagrant',
      mode  => '0644',
      content =>
'Hello, node-dev!
How ya doing?';
  }

  exec { "git_user_name":
    command => 'git config --system user.name "surfserf7"',
    path => ["/bin", "/usr/bin"],
    require => Package["git"]
  }

    exec { "git_user_email":
    command => 'git config --system user.email "sngware@gmail.com"',
    path => ["/bin", "/usr/bin"],
    require => Package["git"]
  }

  exec { "git_alias_lgl":
    command => 'git config --system alias.lgl "log --oneline --abbrev-commit --all --graph --decorate --color"',
    path => ["/bin", "/usr/bin"],
    require => Package["git"]
  }

  exec { "git_alias_lg":
    command => 'git config --system alias.lg "log --graph --pretty=format:\'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\' --abbrev-commit --date=relative"',
    path => ["/bin", "/usr/bin"],
    require => Package["git"]
  }

}
