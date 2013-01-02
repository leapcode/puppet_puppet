class puppet::puppetmaster::package::base inherits puppet::puppetmaster::linux {

  include puppet::puppetmaster::package

  package { 'puppetmaster':
    ensure => present,
  }

  if $puppetmaster_mode != 'passenger' {
    Service['puppetmaster']{
      require +> Package['puppetmaster'],
    }
  }
}
