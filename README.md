# brentschler-hddtemp

[![Build Status](
https://api.travis-ci.org/phoenixv/hddtemp.png?branch=master)](https://travis-ci.org/phoenixv/hddtemp)

#### Table of Contents

1. [Overview](#overview)
2. [Compatability](#Compatability)
3. [Dependencies](#dependencies)
4. [Examples](#examples)
5. [Parameters](#parameters)
6. [Limitations](#limitations)
7. [License](#license)
8. [Development](#development)


# Overview

This Puppet module is designed to facilitate the installation and configuration of [hddtemp](https://savannah.nongnu.org/projects/hddtemp/). The primary scope includes installing the package on the system and populating the init script with the appropriate devices.

At this time only sd* devices are correctly autoconfigured. IDE devices are **not supported** and
must be manually configured.

This module is best used with heira and the "virtual_%{::is_virtual}" directive in it hierarchy configuration so it may be applied to only physical machines. 

## Compatability

Facter 1.7 or greater is required for this module to function.

It has been tested to work with puppet versions 3.0.x and greater.

It will work with puppet 2.7 but fails if ruby is >=2.0.0.

* Centos 6.x
* SLES 11
* Fedora 18+
 
## Dependencies

- Facter 1.7 or greater (blockdevices is absent in older versions.)
- [puppetlabs/stdlib](https://github.com/puppetlabs/puppetlabs-stdlib)


# Examples

*With traditional puppet node configuration:*

```ruby
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

```yaml
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

|Variable | Default Value | Description |
|:--------|:-------------:|:------------|
| listen\_addr 		| localhost | IP Address to listen on for incoming connections. |
| listen\_port 		| 7634		| Port to listen on. |
| monitored\_drives | *none*	| This must be specified as a comma seperated string. 'sda,sdb,sdc' |
| use\_syslog 		| false 	| Log temps to syslog periodically | 
| syslog\_interval 	| 1800 | 1800 seconds (30 minutes) Time in seconds to log temps to syslog. |

# Limitations

The module only looks for /dev/sd* devices, IDE evices may be added manually, if any remain in
the wild I suggest an upgrade.

Due to the init script in use in SLES 11 and other distros multiple erb templates are required.

At this time automatic configuration makes no attempt to ignore USB devices and will add them as
well. Some do present S.M.A.R.T. data and so are valid, but they would still be best ignored.

# License

[GPL v2](http://www.gnu.org/licenses/gpl-2.0.html)

# Development

Please [report issues](https://github.com/phoenixv/hddtemp) or [submit a pull request](https://github.com/phoenixv/hddtemp/pulls).
