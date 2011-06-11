class django-stack {
    if $pgversion == "" {
        $pgversion = "9.0"
    }
    include python2
    include postgres
    include varnish
    #include nginx
    include apache
    include solr
    varnish::instance { "django-stack-varnish":
        address    => ["127.0.0.1:80"],
                   admin_port => "6083",
                   #vcl_file   => "puppet:///barproject/varnish.vcl",
                   corelimit  => "unlimited",
    }
}


# vim modeline - have 'set modeline' and 'syntax on' in your ~/.vimrc.
# vi:syntax=puppet:filetype=puppet:ts=8:sw=4:smarttab:et:
