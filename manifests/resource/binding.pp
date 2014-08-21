# == Defines jboss_admin::binding
#
# JNDI bindings for primitive types
#
# === Parameters
#
# [*binding_type*]
#   The type of binding to create, may be simple, lookup, external-context or object-factory
#
# [*cache*]
#   If the external context should be cached
#
# [*class*]
#   The object factory class name for object factory bindings
#
# [*environment*]
#   The environment to use on object factory instance retrieval
#
# [*lookup*]
#   The entry to lookup in JNDI for lookup bindings
#
# [*module*]
#   The module to load the object factory from for object factory bindings
#
# [*type*]
#   The type of the value to bind for simple bindings, this must be a primitive type
#
# [*value*]
#   The value to bind for simple bindings
#
#
define jboss_admin::resource::binding (
  $server,
  $binding_type                   = undef,
  $cache                          = undef,
  $class                          = undef,
  $environment                    = undef,
  $lookup                         = undef,
  $module                         = undef,
  $type                           = undef,
  $value                          = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $binding_type != undef and !is_string($binding_type) { 
      fail('The attribute binding_type is not a string') 
    }
    if $binding_type != undef and !($binding_type in ['simple','object-factory','lookup','external-context']) {
      fail("The attribute binding_type is not an allowed value: 'simple','object-factory','lookup','external-context'")
    }
    if $cache != undef and !is_bool($cache) { 
      fail('The attribute cache is not a boolean') 
    }
    if $class != undef and !is_string($class) { 
      fail('The attribute class is not a string') 
    }
    if $lookup != undef and !is_string($lookup) { 
      fail('The attribute lookup is not a string') 
    }
    if $module != undef and !is_string($module) { 
      fail('The attribute module is not a string') 
    }
    if $type != undef and !is_string($type) { 
      fail('The attribute type is not a string') 
    }
    if $value != undef and !is_string($value) { 
      fail('The attribute value is not a string') 
    }
  

    $raw_options = { 
      'binding-type'                 => $binding_type,
      'cache'                        => $cache,
      'class'                        => $class,
      'environment'                  => $environment,
      'lookup'                       => $lookup,
      'module'                       => $module,
      'type'                         => $type,
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
