# Set up the holberton user
user { 'holberton':
  ensure     => present,
  managehome => true,
}

# Allow SSH login for the holberton user
ssh_authorized_key { 'holberton':
  user  => 'holberton',
  type  => 'ssh-rsa',
  key   => '<holberton_public_key>',
  ensure => present,
}

# Update SSH configuration to allow password authentication
file { '/etc/ssh/sshd_config':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content => template('ssh/sshd_config.erb'),
  notify  => Service['ssh'],
}

# Create custom SSH configuration template
file { '/etc/ssh/sshd_config.erb':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content => "<%-|
    # This file is managed by Puppet
    PasswordAuthentication yes
  |-%>\n",
  notify  => Service['ssh'],
}

# Restart SSH service
service { 'ssh':
  ensure  => running,
  enable  => true,
  require => File['/etc/ssh/sshd_config'],
}
