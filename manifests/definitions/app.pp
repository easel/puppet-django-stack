define django-stack::app($server_name="localhost",
                         $server_aliases=[],
                         $vhost_name=$server_name,
                         $processes=2,
                         $threads=15) 
{
    #TODO: nginx frontend layer
    #TODO: varnish cache rpc layer
    #TODO: mod_wsgi app layer
#    nginx::site { $server_name:
#	conf_source => "django-stack/nginx-default.cfg.erb",
    #}

    apache::vhost { $vhost_name:
        #ports => ['127.0.0.1:80',],
        enable_default => true,
        aliases => [$server_name, $server_aliases],
    }

    #apache::wsgialias { '03_core':
    #    vhost => $vhost_name,
    #    location => '/',
    #	filename=>"/home/stg/mywiserhealth/bin/project.wsgi",
    #}
        
    file { "${apache::params::root}/${vhost_name}/conf/django.conf":
        ensure => present,
        #owner  => $wwwuser,
        #group  => $group,
        #mode   => $mode,
        seltype => $operatingsystem ? {
          redhat => "httpd_sys_content_t",
          CentOS => "httpd_sys_content_t",
          default => undef,
        },
	content => template("django-stack/apache-django.conf.erb"),
	require => [File["${apache::params::root}/${vhost_name}/conf"]],
    }

   # config_file => "django_stack/apache-default.conf.erb",

    # postgres database layer
    postgres::role { $name:
        ensure => present,
        password => $name,
    }
    postgres::database { $name:
        ensure => present,
        owner => $name,
        require => Postgres::Role[$name]
    }
}
