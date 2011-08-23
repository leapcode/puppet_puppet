class puppet::freebsd inherits puppet::base {

  if !$puppet_ensure_version { $puppet_ensure_version = 'installed' }
  package { 'puppet':
    ensure => $puppet_ensure_version,
  }

  if !$facter_ensure_version { $facter_ensure_version = 'installed' }
  package { 'facter':
    ensure => $facter_ensure_version,
  }

  Service['puppet'] {
    path => '/usr/local/etc/rc.d',
    require => Package[puppet],
  }

}
