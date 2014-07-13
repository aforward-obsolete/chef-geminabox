
[ "", "/data", "/log" ].each do |suffix|
  directory "#{node[:geminabox][:dir]}#{suffix}" do
    owner node[:geminabox][:user]
    group node[:geminabox][:group]
    action :create
    recursive true
  end
end

template "#{node[:geminabox][:dir]}/Gemfile" do
  owner node[:geminabox][:user]
  group node[:geminabox][:group]
  mode 0644
  source "Gemfile.erb"
  notifies :run, "execute[geminbox_update_gems]"
end

template "#{node[:geminabox][:dir]}/config.ru" do
  owner node[:geminabox][:user]
  group node[:geminabox][:group]
  mode 0644
  source "config.ru.erb"
  # notifies :run, "execute[geminabox_restart]"
end

template "#{node[:geminabox][:dir]}/start" do
  owner node[:geminabox][:user]
  group node[:geminabox][:group]
  mode 0755
  source "start.erb"
end

template "#{node[:geminabox][:dir]}/stop" do
  owner node[:geminabox][:user]
  group node[:geminabox][:group]
  mode 0755
  source "stop.erb"
end

execute "install bundler" do
  cwd "#{node[:geminabox][:dir]}"
  command "gem install bundler"
  user "root"
  group "root"
  only_if { `which bundle`.strip == "" }
end

execute "geminbox_update_gems" do
  cwd "#{node[:geminabox][:dir]}"
  command "bundle install"
  user "root"
  group "root"
  action :nothing
  only_if { File.exists?("#{node[:geminabox][:dir]}/Gemfile") }
  notifies :run, "execute[geminabox_restart]"
end

execute "geminabox_restart" do
  user node[:geminabox][:user]
  group node[:geminabox][:group]
  cwd "#{node[:geminabox][:dir]}"
  command "ls -la"
  action :nothing
end

if node[:geminabox][:include_monit]
  include_recipe("geminabox::monit")
end
