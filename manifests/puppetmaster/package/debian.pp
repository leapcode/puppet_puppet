class puppet::puppetmaster::package::debian {

  include puppet::puppetmaster::package::base
    
  apt::preferences_snippet {
    'puppet_passenger':
      package => 'puppet*',
      pin => "version $puppetmaster_ensure_version",
      priority => 2000,
      notify => Exec['refresh_apt'],
      before => Package['puppetmaster'];
  }
}
