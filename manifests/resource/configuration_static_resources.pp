# == Defines jboss_admin::configuration_static_resources
#
# Static files serving configuration.
#
# === Parameters
#
# [*disabled*]
#   Disables the default Servlet mapping.
#
# [*file_encoding*]
#   Force a file encoding.
#
# [*listings*]
#   Enable folder listings.
#
# [*max_depth*]
#   Maximum recursion for PROPFIND.
#
# [*read_only*]
#   Allow write HTTP methods (PUT, DELETE).
#
# [*secret*]
#   Secret for WebDAV locking operations.
#
# [*sendfile*]
#   Enable sendfile if possible, for files bigger than the specified byte size.
#
# [*webdav*]
#   Enable WebDAV functionality.
#
#
define jboss_admin::resource::configuration_static_resources (
  $server,
  $disabled                       = undef,
  $file_encoding                  = undef,
  $listings                       = undef,
  $max_depth                      = undef,
  $read_only                      = undef,
  $secret                         = undef,
  $sendfile                       = undef,
  $webdav                         = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $disabled != undef and !is_bool($disabled) { 
      fail('The attribute disabled is not a boolean') 
    }
    if $file_encoding != undef and !is_string($file_encoding) { 
      fail('The attribute file_encoding is not a string') 
    }
    if $listings != undef and !is_bool($listings) { 
      fail('The attribute listings is not a boolean') 
    }
    if $max_depth != undef and !is_integer($max_depth) { 
      fail('The attribute max_depth is not an integer') 
    }
    if $read_only != undef and !is_bool($read_only) { 
      fail('The attribute read_only is not a boolean') 
    }
    if $secret != undef and !is_string($secret) { 
      fail('The attribute secret is not a string') 
    }
    if $sendfile != undef and !is_integer($sendfile) { 
      fail('The attribute sendfile is not an integer') 
    }
    if $webdav != undef and !is_bool($webdav) { 
      fail('The attribute webdav is not a boolean') 
    }
  

    $raw_options = { 
      'disabled'                     => $disabled,
      'file-encoding'                => $file_encoding,
      'listings'                     => $listings,
      'max-depth'                    => $max_depth,
      'read-only'                    => $read_only,
      'secret'                       => $secret,
      'sendfile'                     => $sendfile,
      'webdav'                       => $webdav,
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
