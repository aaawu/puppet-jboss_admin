# == Defines jboss_admin::server_pop3
#
# Mail session server
#
# === Parameters
#
# [*password*]
#   Password to authenticate on server
#
# [*outbound_socket_binding_ref*]
#   Outbound Socket binding to POP3 server
#
# [*ssl*]
#   Does server requires SSL?
#
# [*username*]
#   Username to authenticate on server
#
#
define jboss_admin::resource::server_pop3 (
  $server,
  $password                       = undef,
  $outbound_socket_binding_ref    = undef,
  $ssl                            = undef,
  $username                       = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'password'                     => $password,
      'outbound-socket-binding-ref'  => $outbound_socket_binding_ref,
      'ssl'                          => $ssl,
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
