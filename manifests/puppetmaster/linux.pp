class puppet::puppetmaster::linux inherits puppet::linux {
  
  if $puppetmaster_mode == 'passenger' {
    exec { 'notify_passenger_puppetmaster':
      refreshonly => true,
      command => '/usr/bin/touch /etc/puppet/rack/tmp/restart.txt && sleep 1 && /bin/rm /etc/puppet/rack/tmp/restart.txt',
    }
  } else {
    service { 'puppetmaster':
      ensure => running,
      enable => true,
      require => [ Package[puppet] ],
    }
    Service[puppet]{
      require +> Service[puppetmaster],
    }
  }
}
