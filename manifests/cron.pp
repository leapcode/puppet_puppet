class puppet::cron inherits puppet {
  case $operatingsystem {
    debian,ubuntu: { include puppet::cron::linux }
    openbsd: { include puppet::cron::openbsd }
    freebsd: { include puppet::cron::freebsd }
    default: {
      case $kernel {
        linux: { include puppet::cron::linux }
        default: { include puppet::cron::base }
      }
    }
  }
}
