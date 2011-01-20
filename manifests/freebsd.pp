class puppet::freebsd inherits puppet::base {

    Service['puppet'] {
        path => '/usr/local/etc/rc.d',
    }

}
