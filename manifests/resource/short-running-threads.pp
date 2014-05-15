# == Defines jboss_admin::short-running-threads
#
# A thread pool executor with a bounded queue where threads submittings tasks may block. Such a thread pool has a core and maximum size and a specified queue length.  When a task is submitted, if the number of running threads is less than the core size, a new thread is created.  Otherwise, if there is room in the queue, the task is enqueued. Otherwise, if the number of running threads is less than the maximum size, a new thread is created. Otherwise, the caller blocks until room becomes available in the queue.
#
# === Parameters
#
# [*core_threads*]
#   The core thread pool size which is smaller than the maximum pool size. If undefined, the core thread pool size is the same as the maximum thread pool size.
#
# [*max_threads*]
#   The maximum thread pool size.
#
# [*allow_core_timeout*]
#   Whether core threads may time out.
#
# [*keepalive_time*]
#   Used to specify the amount of time that pool threads should be kept running when idle; if not specified, threads will run until the executor is shut down.
#
# [*thread_factory*]
#   Specifies the name of a specific thread factory to use to create worker threads. If not defined an appropriate default thread factory will be used.
#
# [*name*]
#   The name of the thread pool.
#
# [*queue_length*]
#   The queue length.
#
#
define jboss_admin::resource::short-running-threads (
  $server,
  $core_threads                   = undef,
  $max_threads                    = undef,
  $allow_core_timeout             = undef,
  $keepalive_time                 = undef,
  $thread_factory                 = undef,
  $name                           = undef,
  $queue_length                   = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $core_threads != undef and !is_integer($core_threads) { 
      fail('The attribute core_threads is not an integer') 
    }
    if $max_threads != undef and !is_integer($max_threads) { 
      fail('The attribute max_threads is not an integer') 
    }
    if $queue_length != undef and !is_integer($queue_length) { 
      fail('The attribute queue_length is not an integer') 
    }
  

    $raw_options = { 
      'core-threads'                 => $core_threads,
      'max-threads'                  => $max_threads,
      'allow-core-timeout'           => $allow_core_timeout,
      'keepalive-time'               => $keepalive_time,
      'thread-factory'               => $thread_factory,
      'name'                         => $name,
      'queue-length'                 => $queue_length,
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
