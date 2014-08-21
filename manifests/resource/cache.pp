# == Defines jboss_admin::cache
#
# A SFSB cache
#
# === Parameters
#
# [*aliases*]
#   The aliases by which this cache may also be referenced
#
# [*passivation_store*]
#   The passivation store used by this cache
#
#
define jboss_admin::resource::cache (
  $server,
  $aliases                        = undef,
  $passivation_store              = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $aliases != undef and !is_array($aliases) { 
      fail('The attribute aliases is not an array') 
    }
    if $passivation_store != undef and !is_string($passivation_store) { 
      fail('The attribute passivation_store is not a string') 
    }
  

    $raw_options = { 
      'aliases'                      => $aliases,
      'passivation-store'            => $passivation_store,
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
