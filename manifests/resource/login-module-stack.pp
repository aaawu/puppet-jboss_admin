# == Defines jboss_admin::login-module-stack
#
# List of "named" login modules that are used by jaspi authentication modules.
#
# === Parameters
#
# [*login_modules*]
#   List of authentication modules
#
#
define jboss_admin::resource::login-module-stack (
  $server,
  $login_modules                  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'login-modules'                => $login_modules,
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
