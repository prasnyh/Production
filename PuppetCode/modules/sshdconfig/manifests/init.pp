class sshdconfig {
if $::operatingsystem == 'Debian' {
        file { "/etc/ssh/sshd_config":
                owner => 'root',
                group => 'root',
                mode => '0644',
                content => template("$module_name/Debian_sshd_config.erb"),
                notify => Service[hiera('sshdconfig::sshservicename')],
                		}
	service { hiera('sshdconfig::sshservicename'): 
                        ensure => 'running',
                        enable => 'true',
                }
		}
if $::operatingsystem == 'CentOS' {
	file { "/etc/ssh/sshd_config":
                owner => 'root',
                group => 'root',
                mode => '0644',
		content => template("$module_name/RedHat_sshd_config.erb"),
		notify => Service[hiera('sshdconfig::sshservicename')],
				}
	service { hiera('sshdconfig::sshservicename'): 
                        ensure => 'running',
                        enable => 'true',
                }
		}
}
