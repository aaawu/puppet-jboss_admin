# == Defines jboss_admin::stateful_session_bean
#
# Stateful session bean component included in the deployment.
#
# === Parameters
#
# [*run_as_role*]
#   The run-as role (if any) for this EJB component.
#
# [*security_domain*]
#   The security domain for this EJB component.
#
# [*component_class_name*]
#   The component's class name.
#
# [*declared_roles*]
#   The roles declared (via @DeclareRoles) on this EJB component.
#
#
define jboss_admin::resource::stateful_session_bean (
  $server,
  $run_as_role                    = undef,
  $security_domain                = undef,
  $component_class_name           = undef,
  $declared_roles                 = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'run-as-role'                  => $run_as_role,
      'security-domain'              => $security_domain,
      'component-class-name'         => $component_class_name,
      'declared-roles'               => $declared_roles,
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
