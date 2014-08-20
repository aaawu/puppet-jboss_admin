# == Defines jboss_admin::ssl
#
# The SSL configuration to client MCMP logic.
#
# === Parameters
#
# [*ca_certificate_file*]
#   Certificate authority.
#
# [*ca_revocation_url*]
#   Certificate authority revocation list.
#
# [*certificate_key_file*]
#   Key file for the certificate.
#
# [*cipher_suite*]
#   The allowed cipher suite.
#
# [*key_alias*]
#   The key alias.
#
# [*password*]
#   Password.
#
# [*protocol*]
#   The SSL protocols that are enabled.
#
#
define jboss_admin::resource::ssl (
  $server,
  $ca_certificate_file            = undef,
  $ca_revocation_url              = undef,
  $certificate_key_file           = undef,
  $cipher_suite                   = undef,
  $key_alias                      = undef,
  $password                       = undef,
  $protocol                       = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'ca-certificate-file'          => $ca_certificate_file,
      'ca-revocation-url'            => $ca_revocation_url,
      'certificate-key-file'         => $certificate_key_file,
      'cipher-suite'                 => $cipher_suite,
      'key-alias'                    => $key_alias,
      'password'                     => $password,
      'protocol'                     => $protocol,
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
