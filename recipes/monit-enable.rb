service 'monit' do
  provider Chef::Provider::Service::Systemd
  action [:enable, :start]
  subscribes :restart, "template[#{node['monit']['conf_file']}]", :delayed
  subscribes :restart, 'template[/etc/default/monit]', :delayed
  supports status: true
end
