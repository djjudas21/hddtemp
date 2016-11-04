# Manage hddtemp config file
class hddtemp::config inherits hddtemp {
  file { 'hddtemp_config_file':
    ensure  => file,
    path    => $::hddtemp::config,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($::hddtemp::config_template),
  }
}
