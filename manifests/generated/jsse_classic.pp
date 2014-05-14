# == Defines jboss_admin::jsse_classic
#
# JSSE configuration. Configures attributes for keystores that can be used for setting up SSL.
#
# === Parameters
#
# [*cipher_suites*]
#   Comma separated list of cipher suites to enable on SSLSockets.
#
# [*service_auth_token*]
#   Token to retrieve PrivateKeys from the KeyStore.
#
# [*protocols*]
#   Comma separated list of protocols to enable on SSLSockets.
#
# [*additional_properties*]
#   Additional properties that may be necessary to configure JSSE.
#
# [*trust_manager*]
#   JSEE Trust Manager factory
#
# [*keystore*]
#   Configures a JSSE key store
#
# [*server_alias*]
#   Preferred alias to use when the KeyManager chooses the server alias.
#
# [*truststore*]
#   Configures a JSSE trust store
#
# [*client_auth*]
#   Boolean attribute to indicate if client's certificates should also be authenticated on the server side.
#
# [*client_alias*]
#   Preferred alias to use when the KeyManager chooses the client alias.
#
# [*key_manager*]
#   JSEE Key Manager factory
#
#
define jboss_admin::jsse_classic (
  $server,
  $cipher_suites                  = undef,
  $service_auth_token             = undef,
  $protocols                      = undef,
  $additional_properties          = undef,
  $trust_manager                  = undef,
  $keystore                       = undef,
  $server_alias                   = undef,
  $truststore                     = undef,
  $client_auth                    = undef,
  $client_alias                   = undef,
  $key_manager                    = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'cipher-suites'                => $cipher_suites,
      'service-auth-token'           => $service_auth_token,
      'protocols'                    => $protocols,
      'additional-properties'        => $additional_properties,
      'trust-manager'                => $trust_manager,
      'keystore'                     => $keystore,
      'server-alias'                 => $server_alias,
      'truststore'                   => $truststore,
      'client-auth'                  => $client_auth,
      'client-alias'                 => $client_alias,
      'key-manager'                  => $key_manager,
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
