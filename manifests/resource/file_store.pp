# == Defines jboss_admin::file_store
#
# The cache file store configuration.
#
# === Parameters
#
# [*fetch_state*]
#   If true, fetch persistent state when joining a cluster. If multiple cache stores are chained, only one of them can have this property enabled.
#
# [*passivation*]
#   If true, data is only written to the cache store when it is evicted from memory, a phenomenon known as 'passivation'. Next time the data is requested, it will be 'activated' which means that data will be brought back to memory and removed from the persistent store. f false, the cache store contains a copy of the contents in memory, so writes to cache result in cache store writes. This essentially gives you a 'write-through' configuration.
#
# [*path*]
#   Description
#
# [*preload*]
#   If true, when the cache starts, data stored in the cache store will be pre-loaded into memory. This is particularly useful when data in the cache store will be needed immediately after startup and you want to avoid cache operations being delayed as a result of loading this data lazily. Can be used to provide a 'warm-cache' on startup, however there is a performance penalty as startup time is affected by this process.
#
# [*purge*]
#   If true, purges this cache store when it starts up.
#
# [*relative_to*]
#   Description
#
# [*shared*]
#   This setting should be set to true when multiple cache instances share the same cache store (e.g., multiple nodes in a cluster using a JDBC-based CacheStore pointing to the same, shared database.) Setting this to true avoids multiple cache instances writing the same modification multiple times. If enabled, only the node where the modification originated will write to the cache store. If disabled, each individual cache reacts to a potential remote update by storing the data to the cache store.
#
# [*singleton*]
#   If true, the singleton store cache store is enabled. SingletonStore is a delegating cache store used for situations when only one instance in a cluster should interact with the underlying store.
#
#
define jboss_admin::resource::file_store (
  $server,
  $fetch_state                    = undef,
  $passivation                    = undef,
  $path                           = undef,
  $preload                        = undef,
  $purge                          = undef,
  $relative_to                    = undef,
  $shared                         = undef,
  $singleton                      = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $fetch_state != undef and !is_bool($fetch_state) { 
      fail('The attribute fetch_state is not a boolean') 
    }
    if $passivation != undef and !is_bool($passivation) { 
      fail('The attribute passivation is not a boolean') 
    }
    if $path != undef and !is_string($path) { 
      fail('The attribute path is not a string') 
    }
    if $preload != undef and !is_bool($preload) { 
      fail('The attribute preload is not a boolean') 
    }
    if $purge != undef and !is_bool($purge) { 
      fail('The attribute purge is not a boolean') 
    }
    if $relative_to != undef and !is_string($relative_to) { 
      fail('The attribute relative_to is not a string') 
    }
    if $shared != undef and !is_bool($shared) { 
      fail('The attribute shared is not a boolean') 
    }
    if $singleton != undef and !is_bool($singleton) { 
      fail('The attribute singleton is not a boolean') 
    }
  

    $raw_options = { 
      'fetch-state'                  => $fetch_state,
      'passivation'                  => $passivation,
      'path'                         => $path,
      'preload'                      => $preload,
      'purge'                        => $purge,
      'relative-to'                  => $relative_to,
      'shared'                       => $shared,
      'singleton'                    => $singleton,
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
