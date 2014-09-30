# = Class jboss_admin::dependecnies
#
# Optional define to include all of the required outside dependencies of the
# jboss_admin module
#
class jboss_admin::dependencies(
) {
  # install required packages and required gems
  package { ['ruby-devel', 'gcc']: } ->
  package { ['treetop', 'json']:
    provider => gem
  }

  Package['treetop'] -> Jboss_admin::Server<||>
  Package['json']    -> Jboss_admin::Server<||>
}
