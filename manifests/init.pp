#
# puppet module
# manifests/init.pp - manage puppet stuff
# original by luke kanies
# http://github.com/lak
# adapted by puzzle itc
# merged with immerda project group's
# solution
#
# Copyright 2008, admin(at)immerda.ch
# Copyright 2008, Puzzle ITC GmbH
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

class puppet {
  $default_config_dir = $operatingsystem ? {
    freebsd => "/usr/local/etc/puppet",
    default => "/etc/puppet",
  }

  $puppet_default_config = "$default_config_dir/puppet.conf"

  if $puppet_config == '' { $puppet_config = $puppet_default_config }

  case $kernel {
    linux: {
      case $operatingsystem {
        gentoo: { include puppet::gentoo }
        centos: { include puppet::centos }
        debian,ubuntu: { include puppet::debian }
        default: { include puppet::linux}
      }
    }
    openbsd: { include puppet::openbsd }
    freebsd: { include puppet::freebsd }
    default: { include puppet::base }
  }

  if $use_shorewall {
    include shorewall::rules::out::puppet
  }
}
