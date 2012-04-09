class puppet::freebsd inherits puppet::base {

  case $puppet_ensure_version {
    '': { $puppet_ensure_version = 'installed' }
    'removed','absent','installed', 'present': {}  # those values are OK
    default: { fail('Package providers for FreeBSD cannot ensure that a specific version is installed.') }
  }
  case $facter_ensure_version {
    '': { $facter_ensure_version = 'installed' }
    'removed','absent','installed', 'present': {}  # those values are OK
    default: { fail('Package providers for FreeBSD cannot ensure that a specific version is installed.') }
  }

  package { 'puppet':
    ensure => $puppet_ensure_version,
  }

  package { 'facter':
    ensure => $facter_ensure_version,
  }

  Service['puppet'] {
    path => '/usr/local/etc/rc.d',
    require => Package[puppet],
  }

}
