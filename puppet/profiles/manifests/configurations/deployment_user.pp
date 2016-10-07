class profiles::configurations::deployment_user {

  # Deploy user
  $username      = hiera('deployment::username')
  $ssh_key       = hiera('deployment::ssh_key')
  $group_name    = hiera('deployment::group')

  ensure_resource('Group', $group_name, {
    ensure => present
  })

  $user = {
    "${username}" => {
      'groups' => {
        "${group_name}" => ''
      },
      'shell'  => '/bin/bash'
    }
  }

  homes { $username:
    ensure  => 'present',
    ssh_key => $ssh_key,
    user    => $user,
    require => Group[$group_name]
  }

}
