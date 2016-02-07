#
# Cookbook Name:: OCPinstall
# Recipe:: aptinstall
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package 'unzip' do
  action :install
end


#Install packages
package 'python-setuptools' do
  action :install
  options '--force-yes'
end

bash 'makefile in ocplib' do
  user 'root'
  cwd '/tmp/'
  code <<-EOH
sudo python -m pip uninstall pip -y
mkdir pip
cd pip/
wget https://github.com/pypa/pip/archive/7.1.2.zip
unzip 7.1.2.zip
cd pip-7.1.2
sudo mkdir /usr/local/lib/python2.7/dist-packages/
sudo python setup.py build
sudo python setup.py install
  EOH
end
"""
python_runtime '2' do

end
"""
#Dependency for cffi/Cython
package 'make' do
  action :install
end

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

package 'uwsgi-plugin-python' do
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
  cwd '/tmp/ndstore/setup/'
  code <<-EOH
sudo mkdir /tmp/ez_setup
cd /tmp/ez_setup
sudo wget https://pypi.python.org/packages/source/e/ez_setup/ez_setup-0.9.tar.gz#md5=1ac53445a67bf68eb2676a72cc3f87f8
sudo tar -xzf ez_setup-0.9.tar.gz
cd ez_setup-0.9
sudo python setup.py build
sudo python setup.py install
  EOH
end

python_package 'numpy' do
  user 'root'
end

python_package 'scipy' do
  user 'root'
end

python_package 'fipy' do
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
pip_requirements '/tmp/ndstore/setup/requirements.txt' do
  action :install
end

python_package 'django-registration' do
  user 'root'
  action :upgrade
end

python_package 'django-registration-redux' do
  user 'root'
end

user 'neurodata' do
  password "#{node['OCPinstall']['database']['userpass']}"
end

group 'neurodata' do
  action :create
  members 'neurodata'
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

directory '/var/log/celery' do
  owner 'www-data'
  group 'www-data'
  action :create
end.run_action(:create)

file '/var/log/ocp/ocp.log' do
  mode '0777'
end

git '/var/www/ndstore' do
  repository 'git://github.com/openconnectome/ndstore.git'
  revision 'ndio'
  action [:checkout, :sync]
end.run_action(:checkout)

#Remove upon change to microns
bash 'makefile in ocplib' do
  user 'root'
  cwd '/var/www/ndstore/ocplib'
  code <<-EOH
sudo make -f makefile_LINUX
  EOH
end
