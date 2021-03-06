# == Defines jboss_admin::protocol
#
# The configuration of a protocol within a protocol stack.
#
# === Parameters
#
# [*socket_binding*]
#   The socket binding specification for this protocol layer, used to specify IP interfaces and ports for communication.
#
# [*type*]
#   The implementation class for a protocol, which determines protocol functionality.
#
#
define jboss_admin::resource::protocol (
  $server,
  $socket_binding                 = undef,
  $type                           = undef,
  $ensure                         = present,
  $path                           = $name
) {
  $stack = regsubst($path, '/protocol.*$', '')
  $check_command = "(outcome == success) of ${path}:read-resource()"

  if $type == undef {
    fail('type is required')
  }
  if $type != undef and !is_string($type) { 
    fail('The attribute type is not a string') 
  }

  $add_command    = "${stack}:add-protocol(type=${type})"
  $remove_command = "${stack}:remove-protocol(type=${type})"

  if $ensure == present {

    if $socket_binding != undef and !is_string($socket_binding) { 
      fail('The attribute socket_binding is not a string') 
    }

    $raw_options = { 
      'socket-binding'               => $socket_binding,
      'type'                         => $type,
    }
    $options = delete_undef_values($raw_options)

    jboss_exec { $add_command:
      unless  => $check_command, 
      server  => $server
    }
    -> jboss_resource { $path:
      ensure  => $ensure,
      server  => $server,
      options => $options
    }

  }

  if $ensure == absent {
    jboss_exec { $remove_command:
      onlyif => $check_command,
      server => $server
    }
  }


}
