class profile::webservers {
case $::operatingsystem {
'Debian': {
					package { 'apache2':
                                        ensure => installed,
                               		 }
        file { "/etc/apache2/sites-enabled/www.webexample.com.conf":
                owner => 'root',
                group => 'root',
                mode => '0644',
                content => template("$module_name/Debian_apachevhost_config.erb"),
                notify => Service[hiera('webservers::webservicename')],
                                }
        service { hiera('webservers::webservicename'):
                        ensure => 'running',
                        enable => 'true',
                }
                }
'CentOS': {

					package { 'httpd24':
                                        ensure => installed,
                               		 }
        file { "/opt/rh/httpd24/root/etc/httpd/conf.d/www.webexample.com.conf":
                owner => 'root',
                group => 'root',
                mode => '0644',
                content => template("$module_name/CentOS_apachevhost_config.erb"),
                notify => Service[hiera('webservers::webservicename')],
                                }
        service { hiera('webservers::webservicename'):
                        ensure => 'running',
                        enable => 'true',
                }
                }
'default': {
}
}
}
