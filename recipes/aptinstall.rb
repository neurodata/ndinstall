#
# Cookbook Name:: OCPinstall
# Recipe:: aptinstall
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

python_runtime '2' do
  pip_version '7.1.2'
  setuptools_version '19.2'
  wheel_version '0.26.0'
end

#Install packages
package 'python-setuptools' do
  action :install
  options '--force-yes'
end
#Dependency for cffi/Cython
package 'libffi-dev' do
  action :install
end

package 'libssl-dev' do
  action :install
end

package 'python-mysqldb' do
  action :install
end

package 'libmysqld-dev' do
  action :install
end

package 'python-dev' do
  action :install
end

package 'liblapack-dev' do
  action :install
end

package 'gfortran' do
  action :install
end

package 'libmemcached-dev' do
  action :install
end

package 'Libhdf5-dev' do
  action :install
end

package 'python-pytest' do
  action :install
end

package 'libtiff-tools' do
  action :install
end

package 'python-pylibmc' do
  action :install
end

package 'memcached' do
  action :install
end

package 'rabbitmq-server' do
  action :install
end

package 'nginx' do
  action :install
end

package 'uwsgi' do
  action :install
end

package 'supervisor' do
  action :install
end

#Dependency for scipy
package 'libatlas-base-dev' do
  action :install
end

#Since pip has real issue with these being installed due to wheels
package 'python-numpy' do
  action :install
end

package 'python-scipy' do
  action :install
end

package 'python-peak.rules' do
  action :install
end

package 'python-imaging' do
  action :install
end

package 'libxml2-dev' do
  action :install
end

package 'libxslt-dev' do
  action :install
end

package 'python-lxml' do
  action :install
end

#Restart Services

service 'nginx' do
  action [:enable, :start]
end

service 'uwsgi' do
  action [:enable, :start]
end

service 'supervisor' do
  action [:enable, :start]
end

service 'rabbitmq-server' do
  action [:enable, :start]
end


#Use this - NOTE: Need to pull and configure the git repo before this
#For now assume repo lives in user ubuntu - AWS, will redo later

bash 'Pip ez_setup' do
  user 'root'
  cwd '/tmp/open-connectome/setup/'
  code <<-EOH
  pip install ez_setup
  EOH
end

python_package 'numpy' do
  user 'root'
end

python_package 'scipy' do
  user 'root'
end

python_package 'Fipy' do
  user 'root'
end

python_package 'turbogears' do
  user 'root'
end

python_package 'cffi' do
  user 'root'
end

python_package 'cryptography' do
  user 'root'
end

python_package 'h5py' do
  user 'root'
end

python_package 'pillow' do
  user 'root'
end

python_package 'cython' do
  user 'root'
end

python_package 'lxml' do
  user 'root'
end

#Install any remaining
pip_requirements '/tmp/open-connectome/setup/requirements.txt' do
  action :install
end

#Directory operations
directory '/var/log/ocp' do
  owner 'www-data'
  group 'www-data'
  action :create
end

directory '/var/www' do
  owner 'www-data'
  group 'www-data'
  action :create
end.run_action(:create)

file '/var/log/ocp/ocp.log' do
  mode '0777'
end

git '/var/www/open-connectome' do
  repository 'git://github.com/openconnectome/open-connectome.git'
  revision 'ndio'
  action [:checkout, :sync]
end.run_action(:checkout)
