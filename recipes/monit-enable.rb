# this is here because of the "skip_service": true in the monit::service recipe
# ubuntu18.04 upgrade issue with chef 12 not having the update-rc.d -n option
# work around found at https://bugs.launchpad.net/ubuntu/+source/chef/+bug/1766786
service 'monit' do
  provider Chef::Provider::Service::Systemd
  action [:enable, :start]
  subscribes :restart, "template[#{node['monit']['conf_file']}]", :delayed
  subscribes :restart, 'template[/etc/default/monit]', :delayed
  supports status: true
end
