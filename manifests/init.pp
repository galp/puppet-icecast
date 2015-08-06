class icecast (
  $source_pass = 'icecast',
  $admin_pass  = 'icecast',
  $relay_pass  = 'icecast',
  $location    = 'Wonderland',
  $port        = '8000',
  $hostname    = 'localhost',
  $admin_email = 'admin@example.com',
)
{
  package {'icecast2':
    ensure  => installed,
  }
  service {'icecast2':
    ensure  => running,
    status  => 'pgrep icecast',
    require => Package['icecast2'],
  }
  file {'/etc/icecast2/icecast.xml':
    ensure  => present,
    content => template("${module_name}/icecast_xml.erb"),
    notify  => Service['icecast2']
  }
  file {'/etc/default/icecast2':
    ensure  => present,
    content => "ENABLE=true",
    notify  => Service['icecast2']
  }
  firewall { '201 allow icecast ports':
    port   => [ $port ],
    proto  => tcp,
    action => accept,
  }

}
