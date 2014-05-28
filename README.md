# brentschler-hddtemp

#### Table of Contents

1. [Overview](#overview)
2. [Dependencies](#dependencies)
3. [Examples](#examples)
4. [Parameters](#parameters)
5. [Limitations](#limitations)
6. [License](#license)
7. [Development](#development)


# Overview

This Puppet module is designed to facilitate the installation and configuration of [hddtemp](https://savannah.nongnu.org/projects/hddtemp/). The primary scope includes installing the package on the system and populating the init script with the appropriate devices.

At this time only sd* devices are correctly autoconfigured. IDE devices are **not supported** and
must be manually configured.

This module is best used with heira and the "virtual_%{::is_virtual}" directive in it hierarchy configuration so it may be applied to only physical machines. 

## Compatability

This module has been tested to work on the following systems with Puppet v3 and facter 1.7

* Centos 6.x
* SLES 11
 
## Dependencies

- Facter 1.7 or greater (blockdevices is absent in older versions.)
- [puppetlabs/stdlib](https://github.com/puppetlabs/puppetlabs-stdlib)


# Examples

*With traditional puppet node configuration:*

```
class { 'hddtemp':
  service_manage      => true,
  service_enable      => true,
  service_ensue       => 'running'
  package_ensue       => 'latest'
  monitored_drives    => 'sda,sdb'
  listen_addr         => '127.0.0.1'
  listen_port         => '7634'
}
```

*With heira:*

```
---
classes:
  - hddtemp

hddtemp::service_manage: true
hddtemp::service_enable: true
hddtemp::service_ensure: 'running'
hddtemp::package_ensure: 'latest'
hddtemp::monitored_drives: 'sda,sdb'
hddtemp::listen_addr: '127.0.0.1'
hddtemp::listen_port: '7634'
```


# Parameters

All Parameters are optional, if no drives are specified the module will add all /dev/sd*
devices to the list to be monitored. 

- listen\_addr - Defaults to listening only on localhost.
- listen\_port - Defaults to 7634
- monitored\_drives - This must be specified as a comma seperated string. 'sda,sdb,sdc' 
- use\_syslog: Defaults to false
- syslog\_interval: Default 1800 (30 minutes) Time in seconds to log temps to syslog.

# Limitations

The module only looks for /dev/sd* devices, IDE evices may be added manually, if any remain in
the wild I suggest an upgrade.

Due to the init script in use in SLES 11 and other distros multiple erb templates are required.

# License

[GPL v2](http://www.gnu.org/licenses/gpl-2.0.html)

# Development

Please [report issues](https://github.com/phoenixv/hddtemp) or [submit a pull request](https://github.com/phoenixv/hddtemp/pulls).
