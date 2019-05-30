class systemd::journald {

    assert_private()
    # Start Hiera Lookups
    $journald_conf      = $systemd::journald_conf 
    # Generate ini file
    if $journald_conf != undef {
        notify {"[systemd] serving jornald.conf file":}
        $journald_conf.each |$option, $value| {
            ini_setting{$option:
                path    => '/etc/systemd/journald.conf',
                section => 'Journal',
                setting => $option,
                value   => $value,
            }
        }
    }
}
