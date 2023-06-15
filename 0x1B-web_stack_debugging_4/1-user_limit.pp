# Create the "holberton" user
user { 'holberton':
  ensure => present,
  managehome => true,
}

# Grant necessary permissions to the "holberton" user
user { 'holberton':
  groups => ['sudo'],
}

# Change the ownership and permissions of the directory where the file is located
file { '/path/to/directory':
  ensure => directory,
  owner  => 'holberton',
  group  => 'holberton',
  mode   => '0755',
}

# Change the ownership and permissions of the file
file { '/path/to/file':
  ensure => file,
  owner  => 'holberton',
  group  => 'holberton',
  mode   => '0644',
}

# Update the SSH configuration to allow login with the "holberton" user
file { '/etc/ssh/sshd_config':
  ensure  => present,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content => template('your_module/sshd_config.erb'),
  notify  => Service['ssh'],
}

# Restart the SSH service
service { 'ssh':
  ensure => running,
  enable => true,
  require => File['/etc/ssh/sshd_config'],
}
