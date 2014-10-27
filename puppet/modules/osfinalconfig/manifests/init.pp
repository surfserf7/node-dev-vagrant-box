# == Class: osfinalconfig
#
# Performs final configuration of the os itself.
#

class osfinalconfig {
  notify {
    ">>>>> Puppet is running the osfinalconfig class.":
  }

  # Example creating a file with inline content
  file {
    '/home/vagrant/example.txt':
      owner => 'vagrant',
      group => 'vagrant',
      mode  => '0644',
      content =>
'Hello, node-dev!
How are you doing?
';
  }

}
