class puppet::puppetmaster::debian inherits puppet::puppetmaster::linux {

  include puppet::puppetmaster::package

  if $puppetmaster_mode != 'passenger' {
    if $puppet::base::puppet_majorversion >= '2.6' {
      Service['puppetmaster'] { hasstatus => true, hasrestart => true }
    }
  }

  if $puppetmaster_mode == 'passenger' {
    $puppetmaster_default_notify = 'Exec[notify_passenger_puppetmaster]'
  }
  
  file { '/etc/default/puppetmaster':
    source => [ "puppet:///modules/site_puppet/master/debian/${fqdn}/puppetmaster",
                "puppet:///modules/site_puppet/master/debian/${domain}/puppetmaster",
                "puppet:///modules/site_puppet/master/debian/puppetmaster",
                "puppet:///modules/puppet/master/debian/puppetmaster" ],
    notify => $puppetmaster_default_notify ? {
    '' => Service[puppetmaster],
    default => Exec['notify_passenger_puppetmaster']
    },
    owner => root, group => 0, mode => 0644;
  }
}
