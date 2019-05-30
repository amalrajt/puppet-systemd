define systemd::resources::linger (
        $enable                             = true,
) {

    if $enable == true {
        # Enabling linger for user
        notify {"[systemd] Enabling linger for ${name}":}
        exec { "Enabling linger for ${name}":
            command => "loginctl enable-linger ${name}",
            path    => "/usr/bin:/bin:",
            unless  => "/usr/bin/test -f /var/lib/systemd/linger/${name}",
        }
    }
    else {
        # Disabling linger for user
        notify {"[systemd] Disabling linger for ${name}":}
        exec { "Disabling linger for ${name}":
            command => "loginctl disable-linger ${name}",
            path    => "/usr/bin:/bin:",
            onlyif  => "/usr/bin/test -f /var/lib/systemd/linger/${name}",
        }
    }

}
