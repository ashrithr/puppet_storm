# Class: storm::install
#
#
class storm::install inherits storm::params {

  file { ["${storm::params::packages_base}", "${storm::params::packages_home}"]:
    ensure => directory,
  }

  file { "${storm::params::packages_home}/${storm::params::storm_package}":
    ensure  => present,
    source  => "puppet:///modules/${module_name}/${storm::params::storm_package}",
    require => File["${storm::params::packages_home}"]
  }

  package { "storm":
    ensure    => installed,
    source    => "${storm::params::packages_home}/${storm::params::storm_package}",
    provider  => $storm::params::pkg_provider,
    require   => File["${storm::params::packages_home}/${storm::params::storm_package}"]
  }

  file { "${storm::params::packages_home}/${storm::params::zmq_package}":
    ensure => present,
    source  => "puppet:///modules/${module_name}/${storm::params::zmq_package}",
    require => File["${storm::params::packages_home}"]
  }

  package { "libzmq1":
    ensure    => installed,
    source    => "${storm::params::packages_home}/${storm::params::zmq_package}",
    provider  => $storm::params::pkg_provider,
    require   => File["${storm::params::packages_home}/${storm::params::zmq_package}"]
  }

  file { "${storm::params::packages_home}/${storm::params::jzmq_package}":
    ensure => present,
    source  => "puppet:///modules/${module_name}/${storm::params::jzmq_package}",
    require => File["${storm::params::packages_home}"]
  }

  package { "libjzmq":
    ensure    => installed,
    source    => "${storm::params::packages_home}/${storm::params::jzmq_package}",
    provider  => $storm::params::pkg_provider,
    require   => [File["${storm::params::packages_home}/${storm::params::jzmq_package}"], Package["libzmq1"]]
  }
}