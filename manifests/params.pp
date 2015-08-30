class hddtemp::params {
  include 'stdlib'
  $service_enable = true
  $service_ensure = 'running'
  $service_manage = true
  $package_ensure = 'present'
  $listen_addr = '127.0.0.1'
  $listen_port = '7634'
  $monitored_drives = $::blockdevices
  $use_syslog = false
  $syslog_interval = '1800'

  case $::osfamily {
    'RedHat' : {
      $package_name = 'hddtemp'
      $service_name = 'hddtemp'
      $config = '/etc/sysconfig/hddtemp'
      $config_template = 'hddtemp/hddtemp.erb'
      $binname = 'hddtemp'
      $drive_db = '/usr/share/misc/hddtemp.db'
      $hasstatus = true
      $hasrestart = true
    }
    'SuSE'   : {
      $package_name = 'hddtemp'
      $service_name = 'hddtemp'
      $config = '/etc/sysconfig/hddtemp'
      $config_template = 'hddtemp/hddtemp-suse.erb'
      $binname = 'hddtemp'
      $drive_db = '/etc/hddtemp.db'
      $hasstatus = true
      $hasrestart = true
    }
    default  : {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
