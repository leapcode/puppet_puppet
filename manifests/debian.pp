class puppet::debian inherits puppet::linux {

  file { '/etc/default/puppet':
    source => [ "puppet:///modules/site_puppet/client/debian/${fqdn}/puppet",
                "puppet:///modules/site_puppet/client/debian/${domain}/puppet",
                "puppet:///modules/site_puppet/client/debian/puppet",
                "puppet:///modules/puppet/client/debian/puppet" ],
    notify => Service[puppet],
    owner => root, group => 0, mode => 0644;
  }  

  if versioncmp($puppetversion,'2.6') >= 0 {
    $real_puppet_hasstatus = true
  }
  else {
    $real_puppet_hasstatus = false
  }
    
  Service[puppet]{
    hasstatus => $real_puppet_hasstatus,
  }

  if !$puppet_ensure_version { $puppet_ensure_version = 'installed' }
  package{ 'puppet-common':
    ensure => $puppet_ensure_version,
  }

  Package['puppet']{
    require => Package['puppet-common']
  }       
}


