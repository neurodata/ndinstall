#
# Cookbook Name:: OCPinstall
# Recipe:: servicesConfig
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

file "/var/www/open-connectome/django/OCP/settings.py" do
  owner 'root'
  group 'root'
  mode 0755
  content ::File.open("/tmp/open-connectome/django/OCP/settings.py.example").read
  action :create
  ignore_failure true
end

file "/var/www/open-connectome/django/OCP/settings_secret.py" do
  owner 'root'
  group 'root'
  mode 0755
  content ::File.open("/tmp/open-connectome/django/OCP/settings_secret.py.example").read
  action :create
  ignore_failure true
end

#Nginx setup
file "/etc/nginx/sites-available/default" do
  owner 'www-data'
  group 'www-data'
  mode 0755
  content ::File.open("/tmp/open-connectome/setup/ubuntu_config/nginx/default.nginx").read
  action :create
end

link '/etc/nginx/sites-available/default' do
  to '/etc/nginx/sites-enabled/default'
end

#uWSGI setup

#Celery/Supervisor Setup
file "/etc/supervisor/conf.d/ingest.conf" do
  owner 'root'
  group 'root'
  mode 0755
  content ::File.open("/tmp/open-connectome/setup/ubuntu_config/celery/ingest.conf").read
  action :create
end

file "/etc/supervisor/conf.d/propagate.conf" do
  owner 'root'
  group 'root'
  mode 0755
  content ::File.open("/tmp/open-connectome/setup/ubuntu_config/celery/propagate.conf").read
  action :create
end

file "/etc/supervisor/conf.d/stats.conf" do
  owner 'root'
  group 'root'
  mode 0755
  content ::File.open("/tmp/open-connectome/setup/ubuntu_config/celery/stats.conf").read
  action :create
end

reboot 'app_requires_reboot' do
  action :reboot_now
  reason 'Need to reboot when the run completes successfully.'
end
