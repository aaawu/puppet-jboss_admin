# == Defines jboss_admin::server_smtp
#
# Mail session server
#
# === Parameters
#
# [*outbound_socket_binding_ref*]
#   Outbound Socket binding to POP3 server
#
# [*ssl*]
#   Does server requires SSL?
#
# [*password*]
#   Password to authenticate on server
#
# [*username*]
#   Username to authenticate on server
#
#
define jboss_admin::server_smtp (
  $server,
  $outbound_socket_binding_ref    = undef,
  $ssl                            = undef,
  $password                       = undef,
  $username                       = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'outbound-socket-binding-ref'  => $outbound_socket_binding_ref,
      'ssl'                          => $ssl,
      'password'                     => $password,
      'username'                     => $username,
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
