class nfs::client::ubuntu::service {
  Service {
    require => Class['nfs::client::ubuntu::configure']
  }

  service { 'rpcbind':
    ensure    => running,
    enable    => true,
    hasstatus => false,
  }

  if $nfs::client::ubuntu::nfs_v4 {
    service { 'idmapd':
      ensure    => running,
      subscribe => Augeas['/etc/idmapd.conf', '/etc/default/nfs-common'],
    }
  } else {
    service { 'idmapd': ensure => stopped, }
  }
}