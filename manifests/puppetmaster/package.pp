# manifests/puppetmaster/package.pp

class puppet::puppetmaster::package {
  case $operatingsystem {
    centos: {
      if $puppetmaster_ensure_version {
        warn('$puppetmaster_ensure_version is not supported for this operatingsystem')
      }
    include puppet::puppetmaster::package::centos }
    debian: { include puppet::puppetmaster::package::debian }
    default: {
      if $puppetmaster_ensure_version {
        warn('$puppetmaster_ensure_version is not supported for this operatingsystem')
      }
      include puppet::puppetmaster::package::base }
  }
}
