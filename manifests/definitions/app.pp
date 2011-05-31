define django-stack::app($app_name="default-django-app",
                         $wsgi_file=None, 
	                 $server_name="localhost",
                         $server_aliases=[],
                         $processes=2,
                         $threads=15) 
{
    #TODO: nginx frontend layer
    #TODO: varnish cache rpc layer
    #TODO: mod_wsgi app layer

    # postgres database layer
    postgres::role { $app_name:
        ensure => present,
        password => $app_name,
    }
    postgres::database { $app_name:
        ensure => present,
        owner => $app_name,
        require => Postgres::Role[$app_name]
    }
}
