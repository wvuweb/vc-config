service 'monit' do
  provider Chef::Provider::Service::Systemd
  action [:enable, :start]
end
