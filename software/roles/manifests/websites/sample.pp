class roles::websites::sample (
    $storage_dir  = '/data',
    $deploy_user  = 'tikitalka',
    $deploy_group = 'deploy',
  ) {

  class { 'profiles::configurations::deployment_user':
    user_name   => $deploy_user,
    group_name  => $deploy_group,
  } ->

  class { 'profiles::configurations::website':
    deploy_user      => $deploy_user,
    deploy_group     => $deploy_group,
    storage_dir      => $storage_dir,
    website_hostname => ['tikiexample.westeurope.cloudapp.azure.com'],
  }

}
