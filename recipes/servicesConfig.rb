#
# Cookbook Name:: OCPinstall
# Recipe:: servicesConfig
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

file "/var/www/open-connectome/django/OCP/settings.py" do
  owner 'www-data'
  group 'www-data'
  mode 0755
  content ::File.open("/tmp/open-connectome/django/OCP/settings.py.example").read
  action :create
end

file "/var/www/open-connectome/django/OCP/settings_secret.py" do
  owner 'www-data'
  group 'www-data'
  mode 0755
  content "USER = '#{node['OCPinstall']['database']['username']}'
PASSWORD = '#{node['OCPinstall']['database']['userpass']}'
HOST = '#{node['OCPinstall']['database']['localhost']}'
SECRET_KEY = '#{node['OCPinstall']['database']['secret_key']}'"
  action :create
end

#Nginx setup
file "/etc/nginx/sites-available/default" do
  owner 'www-data'
  group 'www-data'
  mode 0755
  content ::File.open("/tmp/open-connectome/setup/ubuntu_config/nginx/default.nginx").read
  action :create
end

link '/etc/nginx/sites-enabled/default' do
  to '/etc/nginx/sites-available/default'
end

#uWSGI setup
file "/etc/uwsgi/apps-available/ocp.ini" do
  owner 'www-data'
  group 'www-data'
  mode 0755
  content ::File.open("/tmp/open-connectome/setup/ubuntu_config/uwsgi/ocp.ini").read
  action :create
end

link '/etc/uwsgi/apps-enabled/ocp.ini' do
  to '/etc/uwsgi/apps-available/ocp.ini'
end

directory '/var/run/uwsgi' do
  owner 'www-data'
  group 'www-data'
end


#Celery/Supervisor Setup
file "/etc/supervisor/conf.d/ingest.conf" do
  owner 'www-data'
  group 'www-data'
  mode 0755
  content ::File.open("/tmp/open-connectome/setup/ubuntu_config/celery/ingest.conf").read
  action :create
end

file "/etc/supervisor/conf.d/propagate.conf" do
  owner 'www-data'
  group 'www-data'
  mode 0755
  content ::File.open("/tmp/open-connectome/setup/ubuntu_config/celery/propagate.conf").read
  action :create
end

file "/etc/supervisor/conf.d/stats.conf" do
  owner 'www-data'
  group 'www-data'
  mode 0755
  content ::File.open("/tmp/open-connectome/setup/ubuntu_config/celery/stats.conf").read
  action :create
end

bash 'Migrate server' do
  user 'root'
  cwd '/var/www/open-connectome/django'
  code <<-EOH
python manage.py migrate;
echo "from django.contrib.auth.models import User; User.objects.create_superuser('#{node['OCPinstall']['database']['username']}', 'brain@brain.brain', '#{node['OCPinstall']['database']['userpass']}')" | python manage.py shell;
  EOH
end

reboot 'app_requires_reboot' do
  action :reboot_now
  reason 'Need to reboot when the run completes successfully.'
end
