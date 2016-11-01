class hddtemp::install inherits hddtemp {
  package { $package_name:
    ensure => $package_ensure,
    name   => $package_name,
  }

}
