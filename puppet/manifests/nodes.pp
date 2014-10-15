node 'node-dev' {
  # My system customizations not included in 'main.pp'
  include osconfig
  # Set up node.js; From a github repo I found. See notes.
  import 'main.pp'
}
