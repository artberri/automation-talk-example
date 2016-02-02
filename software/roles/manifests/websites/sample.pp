class roles::websites::sample (
    $storage_dir  = '/data',
    $deploy_user  = 'deployuser',
    $deploy_group = 'deploy',
  ) {

  class { 'profiles::configurations::deployment_user':
    user_name   => $deploy_user,
    group_name  => $deploy_group,
    storage_dir => $storage_dir,
    ssh_key     => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQC/Acd1AZd27VU8K9TvbHZbIlKEYE6nbm0e4qthBonYZ2JZRNfHHxbSgETg/CMEd0DSPY8srC4hFvk4ti0JeXS9fOpe5QHWsgXjV8l7pzOZhHWGmYglNi9jpDdB5hEiFOt4HmWfttFznZyKmYeYA4T9X6HWT0us/Qp1HjGhkv7xptW470K+n9i1N49HckKIKhEnfmnEVYLjWMXG4A+42GJ1bQUAT7NEvd3M9/iQ//UvZ/FRouLU0YxSqVBY24aLEY4KLWULOSzEkkt3+AI3Cz/DIQyUbmWW5YcvIGqlC6aAhOrgK5gDmi5+yIEidsm9MQPvkWCIHVUNENK95lcjksXenVLu1Cnmm0FwoKZk69wpAxTdiy7Qh2mgS/C5J6XDTGdtyGNm6yymcGsDvk4DgWE7+GbRe6jK95L0b4Jt6Ym+cvUOyfG13SRQQxh/L55w1UGZaRiwk48IHJkoaKppQ0B1+lci6Vqj7StYFuxNNHsKUPIqvX080vO+ACMvJlW7kypfNRBtTc0+YNjvf4+D0+YWQ4z9qmQ+v2kn7CQUq/akEKoBk7p66Pf6OTtFOT1uN9xjzidkm8Ms2MifIZA/irietkh95Aen/Bfl19+IxuWATvRSz9fA5iXUiAgy3LIN+vtPBFBbLWByRxZQQhhLn3NxiIBDpQsl+2C2+w6XxqYUMQ==',
  } ->

  class { 'profiles::configurations::website':
    deploy_user      => $deploy_user,
    deploy_group     => $deploy_group,
    storage_dir      => $storage_dir,
    website_hostname => ['sample.berriart.com'],
  }

}
