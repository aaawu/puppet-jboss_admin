# == Defines jboss_admin::authentication_plug_in
#
# Configuration of a user store plug-in for use by the realm.
#
# === Parameters
#
# [*mechanism*]
#   Allow the mechanism this plug-in is compatible with to be overridden from DIGEST.
#
# [*resource_name*]
#   The short name of the plug-in (as registered) to use.
#
#
define jboss_admin::resource::authentication_plug_in (
  $server,
  $mechanism                      = undef,
  $resource_name                  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $mechanism != undef and !is_string($mechanism) { 
      fail('The attribute mechanism is not a string') 
    }
    if $mechanism != undef and !($mechanism in ['DIGEST','PLAIN']) {
      fail("The attribute mechanism is not an allowed value: 'DIGEST','PLAIN'")
    }
    if $resource_name != undef and !is_string($resource_name) { 
      fail('The attribute resource_name is not a string') 
    }
  

    $raw_options = { 
      'mechanism'                    => $mechanism,
      'name'                         => $resource_name,
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
