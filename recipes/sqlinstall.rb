#
# Cookbook Name:: OCPinstall
# Recipe:: sqlinstall
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# Install mysql2 Ruby gem.
mysql2_chef_gem 'default' do
  action :install
end

# Install MySQL client.
mysql_client 'default' do
  action :create
end

# Load the password for root - probably an encrypted bag later

# Configure the MySQL
mysql_service 'default' do
  initial_root_password node['OCPinstall']['database']['rootpass']
  action [:create, :start]
end

#Alternative to see if this works (please work)
cookbook_file '/tmp/setupSQL.sql' do
  source 'setupSQL.sql'
  owner 'root'
  group 'root'
  mode '0600'
end

execute 'initialize database' do
  command "mysql -h #{node['OCPinstall']['database']['localhost']} -u #{node['OCPinstall']['database']['rootname']} -p#{node['OCPinstall']['database']['rootpass']} < #{node['OCPinstall']['database']['setup_file']}"
end
