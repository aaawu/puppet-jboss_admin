# == Defines jboss_admin::authentication_jaspi
#
# JASPI authentication configuration.
#
# === Parameters
#
# [*auth_modules*]
#   List of authentication modules to be used.
#
#
define jboss_admin::resource::authentication_jaspi (
  $server,
  $auth_modules                   = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'auth-modules'                 => $auth_modules,
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
