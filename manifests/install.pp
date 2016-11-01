# Manage hddtemp package
class hddtemp::install inherits hddtemp {
  package { $::hddtemp::package_name:
    ensure => $::hddtemp::package_ensure,
    name   => $::hddtemp::package_name,
  }

}
