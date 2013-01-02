# manifests/cron.pp

class puppet::cron inherits puppet {
  case $operatingsystem {
    linux,debian,ubuntu: { include puppet::cron::linux }
    openbsd: { include puppet::cron::openbsd }
    freebsd: { include puppet::cron::freebsd }
    default: { include puppet::cron::base }
  }
}
