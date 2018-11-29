#
# Cookbook Name::
# Recipe:: lb_config
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

def apache_service_name
  node['platform_family'] == 'debian' ? 'apache2' : 'httpd'
end

def conf_dir
  File.join('/', 'etc', apache_service_name)
end

def enable_conf
  service_name = apache_service_name
  conf_path = conf_dir

  # Delete the default 000-default.conf
  file "#{conf_path}/sites-available/000-default.conf" do
    action :delete
  end

  # Write new 000-default.conf
  template "#{conf_path}/sites-available/000-default.conf" do
    owner 'root'
    group 'root'
    mode '0644'
    source '000-default.vhost.conf.erb'
  end

  link "#{conf_path}/sites-enabled/000-default.conf" do
    to "#{conf_path}/sites-available/000-default.conf"
  end


  service "#{service_name}" do
    action :restart
  end

  logrotate_app 'loadbalancer' do
    path      ["/var/log/#{service_name}/loadbalancer-access.log", "/var/log/#{service_name}/loadbalancer-error.log"]
    options   ['missingok', 'compress', 'delaycompress', ',notifempty', 'copytruncate', 'sharedscripts']
    frequency 'daily'
    create    '644 root adm'
    rotate    7
  end

end


enable_conf
