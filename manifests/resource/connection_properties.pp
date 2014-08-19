# == Defines jboss_admin::connection_properties
#
# value
#
# === Parameters
#
# [*value*]
#   Each connection-property specifies a string name/value pair with the property name coming from the name attribute and the value coming from the element content
#
#
define jboss_admin::resource::connection_properties (
  $server,
  $value                          = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'value'                        => $value,
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
