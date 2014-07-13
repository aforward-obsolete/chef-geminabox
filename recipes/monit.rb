
template "#{node[:monit][:confd_dir]}/geminabox.conf" do
  source "monit_process.conf.erb"
  owner "root"
  group "root"
  mode 0700
  variables(
    :name => "geminabox",
    :pidfile => "/var/run/geminabox_#{node[:geminabox][:port]}.pid",
    :start => "#{node[:geminabox][:dir]}/start",
    :stop => "#{node[:geminabox][:dir]}/stop"
  )
  notifies :reload, resources(:service => "monit")
  action :create
end