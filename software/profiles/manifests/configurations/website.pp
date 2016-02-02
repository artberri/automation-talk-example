class profiles::configurations::website (
    $deploy_user,
    $deploy_group,
    $storage_dir,
    $website_hostname,
  ) {

  $base_directory      = "${storage_dir}/www"
  $website_directory   = "${base_directory}/sample"

  include profiles::configurations::deployment_user

  ensure_resource('File', $base_directory, {
    ensure  => directory,
    require => User[$deploy_user],
  })

  ensure_resource('File', $website_directory, {
    ensure  => directory,
    owner   => $deploy_user,
    mode    => '0755',
    group   => $deploy_group,
    require => File[$base_directory],
  })

  class { 'profiles::applications::nginx':
    require => File[$website_directory]
  }

  nginx::resource::vhost { 'sample-vhost':
    ensure      => present,
    index_files => ['index.html'],
    www_root    => $website_directory,
    server_name => $website_hostname,
    access_log  => '/var/log/nginx/puppet_access.log',
    error_log   => '/var/log/nginx/puppet_error.log',
  }

}
