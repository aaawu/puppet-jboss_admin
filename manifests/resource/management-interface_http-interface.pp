# == Defines jboss_admin::management-interface_http-interface
#
# Configuration of the server's HTTP management interface
#
# === Parameters
#
# [*port*]
#   Deprecated -- use 'socket-binding'. The port on which the server's socket for HTTP management communication should be opened. Must be 'undefined' if the 'socket-binding' attribute is set.
#
# [*socket_binding*]
#   The name of the socket binding configuration to use for the HTTP management interface's socket.
#
# [*interface*]
#   Deprecated -- use 'socket-binding'. The network interface on which the server's socket for HTTP management communication should be opened. Must be 'undefined' if the 'socket-binding' or 'secure-socket-binding' attribute is set.
#
# [*console_enabled*]
#   Flag that indicates admin console is enabled
#
# [*secure_port*]
#   Deprecated -- use 'secure-socket-binding'. The port on which the server's socket for HTTPS management communication should be opened. Must be 'undefined' if the 'socket-binding' or 'secure-socket-binding' attribute is set.
#
# [*secure_socket_binding*]
#   The name of the socket binding configuration to use for the HTTPS management interface's socket.
#
# [*security_realm*]
#   The security realm to use for the HTTP management interface.
#
#
define jboss_admin::resource::management-interface_http-interface (
  $server,
  $port                           = undef,
  $socket_binding                 = undef,
  $interface                      = undef,
  $console_enabled                = undef,
  $secure_port                    = undef,
  $secure_socket_binding          = undef,
  $security_realm                 = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $port != undef and !is_integer($port) { 
      fail('The attribute port is not an integer') 
    }
    if $secure_port != undef and !is_integer($secure_port) { 
      fail('The attribute secure_port is not an integer') 
    }
  

    $raw_options = { 
      'port'                         => $port,
      'socket-binding'               => $socket_binding,
      'interface'                    => $interface,
      'console-enabled'              => $console_enabled,
      'secure-port'                  => $secure_port,
      'secure-socket-binding'        => $secure_socket_binding,
      'security-realm'               => $security_realm,
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
