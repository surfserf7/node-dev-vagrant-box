node 'node-dev' {
  # My system customizations not included in 'main.pp'
  include osbeginconfig
  # Set up node.js; From a github repo I found. See notes.
  import 'main.pp'
  # Final customizations that may rely on previous setups.
  include osfinalconfig
}
