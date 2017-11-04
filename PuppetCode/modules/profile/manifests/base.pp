# Class: profile
# ===========================
#
# Full description of class profile here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'profile':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class profile::base {
$lblisten_port=hiera_array('lbservers::listen_port')
$lb_mode=hiera_array('lbservers::mode')
$lbbalance=hiera_array('lbservers::balance_algorithm')
$mesg = [ $lblisten_port, $lb_mode, $lbbalance ]
				package { 'haproxy':
                                        ensure => installed,
                                }
notify { 'PPrinting...':
    message => "${mesg}",
  }
					file { "/etc/haproxy/haproxy.cfg":
                                        owner => 'root',
                                        group => 'root',
                                        mode => '0644',
                                        content => template("$module_name/haproxy.cfg.erb"),
                                        notify => Service[hiera('lbservers::lbservicename')],
                                        }
				service { hiera('lbservers::lbservicename'):
					ensure => running,
					enable => true,
				}

}
