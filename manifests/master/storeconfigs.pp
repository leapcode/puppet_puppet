# This class sets up the necessary ActiveRecord bits
# so storeconfigs works.

class puppet::master::storeconfigs {
  include rails
  include mysql::client::ruby
}
