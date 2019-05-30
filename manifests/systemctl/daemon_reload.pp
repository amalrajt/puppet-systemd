# Summary
#   Reload systemd daemon
#
class systemd::systemctl::daemon_reload {

  exec { 'systemctl daemon-reload':
    refreshonly => true,
    path		=> '/usr/bin:/bin',
  }

}
