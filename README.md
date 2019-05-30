# Systemd

Puppet module to generate systemd unit files and manage services

## Creating Unit Files

*systemd::resources::init* resource will create the unit files and manage service using puppet resource.

For common unit directives refer to man(5) systemd.unit, man(7) systemd.directives

### Service unit

man(5) systemd.service

```
systemd::units:
  'hello_service':
    type: 'service'
    ensure: 'running'
    enable: 'true'
    unit_params:
      'Unit':
        Description: "program to print $MESSAGE"
      'Service':
        ExecStart: "/bin/echo $MESSAGE"
        Environment: "MESSAGE=HELLOWORLD"
        Slice: "hello.slice"
      'Install':
        WantedBy: 'multi-user.target'

```

### Slice unit

man(5) systemd.slice

```
systemd::units:
  'hello_slice':
    type: 'slice'
    ensure: 'running'
    enable: 'true'
    unit_params:
      'Unit':
        Description: "Slice for hello service"
      'Slice':
        CPUQuota: "300%"
        MemoryMax: "5G"
      'Install':
        WantedBy: 'multi-user.target'
  'hello_timer':
    type: 'slice'
    ensure: 'running'
    enable: 'true'
```

### Timer unit

man(5) systemd.timer

```
systemd::units:
  'hello_timer':
    type: 'slice'
    ensure: 'running'
    enable: 'true'
    unit_params:
      'Unit':
        Description: "Run hello service periodically"
      'Timer':
        Unit: 'hello.service'
        OnCalendar: '*-*-* 0/8:00:00'
      'Install':
        WantedBy: 'timers.target'
```


## Managing Journald config

man(5) journald.conf

```
systemd::journald_conf:
  Compress: 'yes'
  SyncIntervalSec: '5m'
```

## Managing Logind config

man(5) logind.conf

```
systemd::logind_conf:
  NAutoVTs: 6
  KillUserProcesses: 'yes'
```


## Enabling/Disabling Linger for user

man loginctl

```
systemd::linger:
  'unprivileged_user': {}    # enable
  'deploy_user':
    enable: false # disable
```
