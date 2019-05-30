# @summary 
#   This module manages systemd configuration and unit files.
# 
# @example Basic usage
#   include systemd
#
# @param template 
#   Specifies a custom template. A template takes precedence over `content`. Valid options:  '/mymodule/mytemplate.erb'.
#
class systemd::logind {

    assert_private()
    # Start Hiera Lookups
    $logind_conf       = $systemd::logind_conf 
    # Generate ini file
    if $logind_conf != undef {
        notify {"[systemd] serving logind.conf file":}
        $logind_conf.each |$option, $value| {
            ini_setting{$option:
                path    => '/etc/systemd/logind.conf',
                section => 'Login',
                setting => $option,
                value   => $value
            }
        }
    }
}
