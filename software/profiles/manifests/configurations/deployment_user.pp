class profiles::configurations::deployment_user (
    $user_name,
    $group_name,
  ) {

  ensure_resource('Group', $group_name, {
    ensure => present
  })

  ensure_resource('User', $user_name, {
    ensure  => present,
    groups  => [$group_name],
    require => Group[$group_name],
  })

}
