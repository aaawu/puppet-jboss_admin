# == Defines jboss_admin::pre_handler_chain
#
# Endpoint configuration PRE handler chain
#
# === Parameters
#
# [*protocol_bindings*]
#   Protocol binding
#
#
define jboss_admin::resource::pre_handler_chain (
  $server,
  $protocol_bindings              = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $protocol_bindings != undef and !is_string($protocol_bindings) { 
      fail('The attribute protocol_bindings is not a string') 
    }
  

    $raw_options = { 
      'protocol-bindings'            => $protocol_bindings,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $cli_path:
      ensure  => $ensure,
      server  => $server,
      options => $options
    }


  }

  if $ensure == absent {
    jboss_resource { $cli_path:
      ensure => $ensure,
      server => $server
    }
  }


}
