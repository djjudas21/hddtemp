class hddtemp::config inherits hddtemp {
  file { hddtemp_config_file:
    ensure  => file,
    path    => $config
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template($config_template),
  }
}
