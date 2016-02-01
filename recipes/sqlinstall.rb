#
# Cookbook Name:: OCPinstall
# Recipe:: sqlinstall
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# Install mysql2 Ruby gem.
mysql2_chef_gem 'default' do
  action :install
end

package 'mysql-server' do
  action :install
end

mysql_connection_info = {
  :host     => node['OCPinstall']['database']['localhost'],
  :username => node['OCPinstall']['database']['username'],
  :password => node['OCPinstall']['database']['userpass']
}

cookbook_file '/tmp/setupSQL.sql' do
  source 'setupSQL.sql'
  owner 'root'
  group 'root'
  mode '0600'
end

service "mysql" do
  action :start
end

execute 'initialize neurodata user and flush root' do
  command "mysql -u root -e \"flush privileges; \
  create user '#{node['OCPinstall']['database']['username']}'@'localhost' identified by '#{node['OCPinstall']['database']['userpass']}'; \
  grant all privileges on *.* to '#{node['OCPinstall']['database']['username']}'@'localhost' with grant option;
  create user '#{node['OCPinstall']['database']['username']}'@'%' identified by '#{node['OCPinstall']['database']['userpass']}'; \
  grant all privileges on *.* to '#{node['OCPinstall']['database']['username']}'@'%' with grant option;\""
end

mysql_database 'ocpdjango' do
  connection mysql_connection_info
  action :create
end
