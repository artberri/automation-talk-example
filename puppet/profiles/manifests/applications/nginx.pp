class profiles::applications::nginx {

  class { '::nginx':
    service_ensure => running
  }

}
