# == Defines jboss_admin::subsystem_ee
#
# The configuration of the EE subsystem.
#
# === Parameters
#
# [*ear_subdeployments_isolated*]
#   Flag indicating whether each of the subdeployments within a .ear can access classes belonging to another subdeployment within the same .ear. A value of false means the subdeployments can see classes belonging to other subdeployments within the .ear.
#
# [*global_modules*]
#   A list of modules that should be made available to all deployments.
#
#
define jboss_admin::resource::subsystem_ee (
  $server,
  $ear_subdeployments_isolated    = undef,
  $global_modules                 = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'ear-subdeployments-isolated'  => $ear_subdeployments_isolated,
      'global-modules'               => $global_modules,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $path:
      ensure  => $ensure,
      server  => $server,
      options => $options
    }


  }

  if $ensure == absent {
    jboss_resource { $path:
      ensure => $ensure,
      server => $server
    }
  }


}
