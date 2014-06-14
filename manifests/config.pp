class hddtemp::config inherits hddtemp {
  file { hddtemp_config_file:
    ensure  => file,
    path    => $config,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($config_template),
  }
}
