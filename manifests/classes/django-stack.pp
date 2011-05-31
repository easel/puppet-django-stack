class django-stack {
    if $pgversion == "" {
        $pgversion = "9.0"
    }
    include python2
    include postgres
    include varnish
    include nginx
    include apache
    varnish::instance { "django-stack-varnish":
        address    => ["127.0.0.1:80"],
                   admin_port => "6083",
                   #vcl_file   => "puppet:///barproject/varnish.vcl",
                   corelimit  => "unlimited",
    }
    #postgres::role { "django_stack":
    #    ensure => present,
    #    password => "django_stack",
    #}
    #postgres::database { "django_stack":
    #    ensure => present,
    #    owner => "django_stack",
    #    require => Postgres::Role["django_stack"]
    #}
}


# vim modeline - have 'set modeline' and 'syntax on' in your ~/.vimrc.
# vi:syntax=puppet:filetype=puppet:ts=8:sw=4:smarttab:et:
