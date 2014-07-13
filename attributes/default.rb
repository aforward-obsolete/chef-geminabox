# include_attribute "runas"

default[:geminabox][:dir] = "/var/apps/geminabox"

default[:geminabox][:user] = node[:runas][:user]
default[:geminabox][:group] = node[:runas][:group]
default[:geminabox][:port] = 4009
default[:geminabox][:host] = "127.0.0.1"

default[:geminabox][:include_monit] = true
