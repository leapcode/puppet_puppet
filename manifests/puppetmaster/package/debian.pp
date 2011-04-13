class puppet::puppetmaster::package::debian inherits puppet::puppetmaster::package::base {

  if !$puppetmaster_ensure_version { $puppetmaster_ensure_version = 'installed' }
  case $lsbdistcodename {
      wheezy,sid: {
        $puppetmaster_common_required = 'puppetmaster-common'
        $puppetmaster_common_ensure = $puppetmaster_ensure_version
      }
  }

  Package["puppetmaster"]{
        require => $puppetmaster_common_required ? {
        '' => undef,
        default => Package["$puppetmaster_common_required"]
        },
        ensure => $puppetmaster_ensure_version,
  }
  
  package { "puppetmaster-common": 
        ensure => $puppetmaster_common_ensure ? {
        '' => absent,
        default => $puppetmaster_common_ensure
        },
  }
}
