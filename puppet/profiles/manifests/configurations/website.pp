class profiles::configurations::website {

  $deploy_user   = hiera('deployment::username')
  $deploy_group  = hiera('deployment::group')

  $storage_dir   = hiera('website::storage_directory')
  $website_hostname  = hiera('website::hostname')

  $base_directory    = "${storage_dir}/www"
  $website_directory = "${base_directory}/sample"
  $current_directory = "${website_directory}/current"

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

  ensure_resource('File', $current_directory, {
    ensure  => directory,
    owner   => $deploy_user,
    mode    => '0755',
    group   => $deploy_group,
    require => File[$website_directory],
  })

  class { 'profiles::applications::nginx':
    require => File[$current_directory]
  }

  nginx::resource::vhost { 'sample-vhost':
    ensure      => present,
    index_files => ['index.html'],
    www_root    => $current_directory,
    server_name => $website_hostname,
    access_log  => '/var/log/nginx/puppet_access.log',
    error_log   => '/var/log/nginx/puppet_error.log',
  }

}
