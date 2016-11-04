# Manage hddtemp service
class hddtemp::service inherits hddtemp {
  if !($::hddtemp::service_ensure in ['running', 'stopped']) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $::hddtemp::service_manage == true {
    service { $::hddtemp::service_name:
      ensure     => $::hddtemp::service_ensure,
      enable     => $::hddtemp::service_enable,
      name       => $::hddtemp::service_name,
      hasstatus  => true,
      hasrestart => true,
    }
  }

}
