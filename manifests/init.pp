class ff_base () {

  class { 'apt': }

  # update packages before we install any
  exec { 'apt-update':
    command => '/usr/bin/apt-get update'
  }
  Exec['apt-update'] -> Package <| |>

  # do not install recommended packages
  Package {
    install_options => ['--no-install-recommends'],
  }

  # list of base packages we deploy on every node
  package { [
    'byobu',
    'dstat',
    'git',
    'htop',
    'iputils-tracepath',
    'man-db',
    'mailutils',
    'mtr',
    'screen',
    'tcpdump',
    'tmux',
    'vim'
  ]:
    ensure => installed,
  }

  # install security updates
  class { 'unattended_upgrades': }

  class { 'ntp': }

  # sysctl configuration
  # disable ipv6 auto-configuration
  sysctl { 'net.ipv6.conf.all.autoconf': value => '0' }
  sysctl { 'net.ipv6.conf.all.accept_ra': value => '0' }
  sysctl { 'net.ipv6.conf.all.use_tempaddr': value => '0' }

}
