# Base class to manage hddtemp
class hddtemp (
  $service_enable   = $hddtemp::params::service_enable,
  $service_ensure   = $hddtemp::params::service_ensure,
  $service_manage   = $hddtemp::params::service_manage,
  $package_ensure   = $hddtemp::params::package_ensure,
  $monitored_drives = $hddtemp::params::monitored_drives,
  $listen_addr      = $hddtemp::params::listen_addr,
  $listen_port      = $hddtemp::params::listen_port,
  $config           = $hddtemp::params::config,
  $binname          = $hddtemp::params::binname,
  $config_template  = $hddtemp::params::config_template,
  $drive_db         = $hddtemp::params::drive_db,
  $use_syslog       = $hddtemp::params::use_syslog,
  $syslog_interval  = $hddtemp::params::syslog_interval,
  $hasrestart       = $hddtemp::params::hasrestart,
  $hasstatus        = $hddtemp::params::hasstatus) inherits hddtemp::params {
  validate_bool($service_enable, $service_manage, $use_syslog, $hasstatus, $hasrestart)
  validate_absolute_path($config, $drive_db)
  validate_string($service_ensure, $package_ensure, $binname, $monitored_drives)

  anchor { 'hddtemp::begin': } ->
  class { '::hddtemp::install': } ->
  class { '::hddtemp::config': } ~>
  class { '::hddtemp::service': } ->
  anchor { 'hddtemp::end': }
}
