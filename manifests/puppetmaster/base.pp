class puppet::puppetmaster::base inherits puppet::base {

  File[puppet_config]{
    source => [
                "puppet:///modules/site_puppet/master/${fqdn}/puppet.conf",
                "puppet:///modules/site_puppet/master/puppet.conf",
                "puppet:///modules/puppet/master/puppet.conf",
    ],
  }

  if !$puppet_fileserverconfig { $puppet_fileserverconfig  = "${puppet::default_config_dir}/fileserver.conf" }

  file { "$puppet_fileserverconfig":
    source => [ "puppet:///modules/site_puppet/master/${fqdn}/fileserver.conf",
                "puppet:///modules/site_puppet/master/fileserver.conf",
                "puppet:///modules/puppet/master/fileserver.conf" ],
    owner => root, group => puppet, mode => 640;
  }

  if $puppetmaster_storeconfigs {
    include puppet::puppetmaster::storeconfigs
  }


  if $puppetmaster_mode == 'passenger' {
    include puppet::puppetmaster::passenger
    File[$puppet_fileserverconfig]{
      notify => Exec['notify_passenger_puppetmaster'],
    }
    File[puppet_config]{
      notify => Exec['notify_passenger_puppetmaster'],
    }
  } else {
    File[$puppet_fileserverconfig]{
      notify => Service[puppetmaster],
    }
    File[puppet_config]{
      notify => Service[puppetmaster],
    }
  }
}
