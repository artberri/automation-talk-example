class profiles::configurations::deployment_user (
    $shell      = '/bin/bash',
    $user_name,
    $group_name,
    $storage_dir,
    $ssh_key
  ) {

  $home = "${storage_dir}/${$user_name}"

  $user = {
    "${user_name}" => {
      'home'   => $home,
      'groups' => {
        "${group_name}" => {}
      },
      'shell'  => $shell,
    }
  }

  ensure_resource('Group', $group_name, {
    ensure => present
  })

  homes { $user_name:
    ensure  => $ensure,
    ssh_key => $ssh_key,
    user    => $user,
    require => Group[$group_name],
  }

}
