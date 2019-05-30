define systemd::resources::unit (
        $type                               = 'mount',
        Stdlib::Absolutepath $path          = '/etc/systemd/system',
        $enable                             = 'true',
        $ensure                             = 'running',
        $template_basepath                  = 'systemd',
        $unit_params                        = undef,
        $owner                              = 'root',
        $group                              = 'root',
        $mode                               = '0644',
) {

    case $type {
        'service', 'slice', 'timer', 'path':  {
            # For debugging 
            notify {"[systemd] Serving content for service unit in ${name}": }
            # Generate the absolute path for unit file (this may be useful in future)
            $file_path = "${path}/${name}.${type}"
            # Serve unit file and reload systemd daemon if there is any change
            file { "${file_path}":
                owner   => "$owner",
                group   => "$group",
                mode    => "$mode",
                content => template("${template_basepath}/${type}.erb"),
                notify  => [
                            Class['systemd::systemctl::daemon_reload'],
                            Service["${name}.${type}"],
                            ],
            }
            # Manage the state of unit using puppet service resource
            service { "${name}.${type}":
                ensure      => "$ensure",
                enable      => "$enable",
                provider    => "systemd",
                require     => Class['systemd::systemctl::daemon_reload'],
            }
        }
        default:    {
            # For debugging
            notify {"[systemd] Unit type does not exists, or not supported by the module. Failed to create unit $name": } 
        }
    }

}
