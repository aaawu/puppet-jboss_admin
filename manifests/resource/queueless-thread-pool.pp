# == Defines jboss_admin::queueless-thread-pool
#
# A thread pool executor with no queue where threads submittings tasks will not block.  When a task is submitted, if the number of running threads is less than the maximum size, a new thread is created.  Otherwise, the task is handed off to the designated handoff executor, if one is specified.  Otherwise, the task is discarded.
#
# === Parameters
#
# [*max_threads*]
#   The maximum thread pool size.
#
# [*handoff_executor*]
#   An executor to delegate tasks to in the event that a task cannot be accepted. If not specified, tasks that cannot be accepted will be silently discarded.
#
# [*_name*]
#   The name of the thread pool.
#
# [*keepalive_time*]
#   Used to specify the amount of time that pool threads should be kept running when idle; if not specified, threads will run until the executor is shut down.
#
# [*thread_factory*]
#   Specifies the name of a specific thread factory to use to create worker threads. If not defined an appropriate default thread factory will be used.
#
#
define jboss_admin::resource::queueless-thread-pool (
  $server,
  $max_threads                    = undef,
  $handoff_executor               = undef,
  $_name                          = undef,
  $keepalive_time                 = undef,
  $thread_factory                 = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $max_threads != undef and !is_integer($max_threads) { 
      fail('The attribute max_threads is not an integer') 
    }
  

    $raw_options = { 
      'max-threads'                  => $max_threads,
      'handoff-executor'             => $handoff_executor,
      'name'                         => $_name,
      'keepalive-time'               => $keepalive_time,
      'thread-factory'               => $thread_factory,
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
