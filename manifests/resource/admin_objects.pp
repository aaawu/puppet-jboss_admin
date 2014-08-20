# == Defines jboss_admin::admin_objects
#
# admin-objects
#
# === Parameters
#
# [*class_name*]
#   Specifies the fully qualified class name of a managed connection factory or admin object
#
# [*enabled*]
#   Specifies if the resource adapter should be enabled
#
# [*jndi_name*]
#   Specifies the JNDI name for the connection factory or admin object
#
# [*use_java_context*]
#   Setting this to false will bind the object into global JNDI
#
#
define jboss_admin::resource::admin_objects (
  $server,
  $class_name                     = undef,
  $enabled                        = undef,
  $jndi_name                      = undef,
  $use_java_context               = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'class-name'                   => $class_name,
      'enabled'                      => $enabled,
      'jndi-name'                    => $jndi_name,
      'use-java-context'             => $use_java_context,
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
