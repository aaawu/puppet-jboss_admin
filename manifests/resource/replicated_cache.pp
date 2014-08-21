# == Defines jboss_admin::replicated_cache
#
# A replicated cache
#
# === Parameters
#
# [*async_marshalling*]
#   If enabled, this will cause marshalling of entries to be performed asynchronously.
#
# [*batching*]
#   If enabled, the invocation batching API will be made available for this cache.
#
# [*indexing*]
#   If enabled, entries will be indexed when they are added to the cache. Indexes will be updated as entries change or are removed.
#
# [*indexing_properties*]
#   Properties to control indexing behaviour
#
# [*jndi_name*]
#   The jndi-name to which to bind this cache instance.
#
# [*mode*]
#   Sets the clustered cache mode, ASYNC for asynchronous operation, or SYNC for synchronous operation.
#
# [*module*]
#   The module whose class loader should be used when building this cache's configuration.
#
# [*queue_flush_interval*]
#   In ASYNC mode, this attribute controls how often the asynchronous thread used to flush the replication queue runs. This should be a positive integer which represents thread wakeup time in milliseconds.
#
# [*queue_size*]
#   In ASYNC mode, this attribute can be used to trigger flushing of the queue when it reaches a specific threshold.
#
# [*remote_timeout*]
#   In SYNC mode, the timeout (in ms) used to wait for an acknowledgment when making a remote call, after which the call is aborted and an exception is thrown.
#
# [*start*]
#   The cache start mode, which can be EAGER (immediate start) or LAZY (on-demand start).
#
# [*statistics_enabled*]
#   If enabled, statistics will be collected for this cache
#
#
define jboss_admin::resource::replicated_cache (
  $server,
  $async_marshalling              = undef,
  $batching                       = undef,
  $indexing                       = undef,
  $indexing_properties            = undef,
  $jndi_name                      = undef,
  $mode                           = undef,
  $module                         = undef,
  $queue_flush_interval           = undef,
  $queue_size                     = undef,
  $remote_timeout                 = undef,
  $start                          = undef,
  $statistics_enabled             = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $async_marshalling != undef and !is_bool($async_marshalling) { 
      fail('The attribute async_marshalling is not a boolean') 
    }
    if $batching != undef and !is_bool($batching) { 
      fail('The attribute batching is not a boolean') 
    }
    if $indexing != undef and !is_string($indexing) { 
      fail('The attribute indexing is not a string') 
    }
    if $indexing != undef and !($indexing in ['NONE','LOCAL','ALL']) {
      fail("The attribute indexing is not an allowed value: 'NONE','LOCAL','ALL'")
    }
    if $jndi_name != undef and !is_string($jndi_name) { 
      fail('The attribute jndi_name is not a string') 
    }
    if $mode != undef and !is_string($mode) { 
      fail('The attribute mode is not a string') 
    }
    if $mode != undef and !($mode in ['SYNC','ASYNC']) {
      fail("The attribute mode is not an allowed value: 'SYNC','ASYNC'")
    }
    if $module != undef and !is_string($module) { 
      fail('The attribute module is not a string') 
    }
    if $queue_flush_interval != undef and !is_integer($queue_flush_interval) { 
      fail('The attribute queue_flush_interval is not an integer') 
    }
    if $queue_size != undef and !is_integer($queue_size) { 
      fail('The attribute queue_size is not an integer') 
    }
    if $remote_timeout != undef and !is_integer($remote_timeout) { 
      fail('The attribute remote_timeout is not an integer') 
    }
    if $start != undef and !is_string($start) { 
      fail('The attribute start is not a string') 
    }
    if $start != undef and !($start in ['EAGER','LAZY']) {
      fail("The attribute start is not an allowed value: 'EAGER','LAZY'")
    }
    if $statistics_enabled != undef and !is_bool($statistics_enabled) { 
      fail('The attribute statistics_enabled is not a boolean') 
    }
  

    $raw_options = { 
      'async-marshalling'            => $async_marshalling,
      'batching'                     => $batching,
      'indexing'                     => $indexing,
      'indexing-properties'          => $indexing_properties,
      'jndi-name'                    => $jndi_name,
      'mode'                         => $mode,
      'module'                       => $module,
      'queue-flush-interval'         => $queue_flush_interval,
      'queue-size'                   => $queue_size,
      'remote-timeout'               => $remote_timeout,
      'start'                        => $start,
      'statistics-enabled'           => $statistics_enabled,
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
