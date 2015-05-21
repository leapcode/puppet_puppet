# This class sets up the necessary ActiveRecord bits
# so storeconfigs works.

class puppet::master::storeconfigs {
  if $::operatingsystem == 'Debian' {
    ensure_packages(['ruby-activerecord'])
    if $::operatingsystemmajrelease == 8 {
      ensure_packages(['ruby-activerecord-deprecated-finders'])
    }
  } else {
    include rails
  }
  include mysql::client::ruby
}
