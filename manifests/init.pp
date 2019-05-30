# @summary 
#   This module manages systemd configuration and unit files.
# 
# @example Basic usage
#   include systemd
#
# @param template 
#   Specifies a custom template. A template takes precedence over `content`. Valid options:  '/mymodule/mytemplate.erb'.
#
class systemd(
    # Start Hiera Lookups
    Hash $units         = {},
    Hash $linger        = {},
    Hash $logind_conf   = {},
    Hash $journald_conf = {},
) {

    include ::systemd::systemctl::daemon_reload
    if !empty($logind_conf) {
        contain 'systemd::logind'
    }
    if !empty($journald_conf) {
        contain 'systemd::journald'
    }

    if $facts['os']['name'] != 'Debian' {
        notify {"[systemd] systemd module is not tested on non debian systems":}
    }
    else{
        notify {"[systemd] On Debian system. Applying unit configurations":}
        create_resources('systemd::resources::unit', $units)
        create_resources('systemd::resources::linger', $linger)
    }

}
