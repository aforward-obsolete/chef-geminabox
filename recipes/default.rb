
[ "", "/data" ].each do |suffix|
directory "#{node[:geminabox][:dir]}#{suffix}" do
  owner  'root'
  group 'root'
  mode 0644
  action :create
  recursive true
end

template "#{node[:geminabox][:dir]}/config.ru" do
  owner "root"
  group "root"
  mode 0700
  source 'config.ru.erb'
end
