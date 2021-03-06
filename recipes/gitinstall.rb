#
# Cookbook Name:: OCPinstall
# Recipe:: gitinstall
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package 'git' do
  action :install
end.run_action(:install)

git '/tmp/ndstore' do
  repository 'git://github.com/openconnectome/ndstore.git'
  revision 'ae-devel'
  action [:checkout, :sync]
end.run_action(:checkout)
