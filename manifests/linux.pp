class puppet::linux inherits puppet::base {

  if !$puppet_ensure_version { $puppet_ensure_version = 'installed' }
  package { 'puppet':
    ensure => $puppet_ensure_version,
  }

  if !$facter_ensure_version { $facter_ensure_version = 'installed' }
  package { 'facter':
    ensure => $facter_ensure_version,
  }

  Service['puppet']{
    require => Package[puppet],
  }

  file { '/etc/cron.d/puppetd.cron':
    ensure => absent
  }
}
