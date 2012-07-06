class puppet::puppetmaster::linux inherits puppet::linux {
  
  if $puppetmaster_mode == 'passenger' {
    exec { 'notify_passenger_puppetmaster':
      refreshonly => true,
      #command => 'touch /etc/puppet/rack/tmp/restart.txt && sleep 1 && rm /etc/puppet/rack/tmp/restart.txt',
      command => '/etc/init.d/apache2 reload',
    }

    service { 'puppetmaster':
      ensure     => running,
      pattern    => 'apache2',
      hasstatus  => true,
      hasrestart => true,
      require    => [ Package[puppet] ],
    }

  } else {
    service { 'puppetmaster':
      ensure => running,
      enable => true,
      require => [ Package[puppet] ],
    }
  }
  Service[puppet]{
    require +> Service[puppetmaster],
  }
}
