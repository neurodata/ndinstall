default['OCPinstall']['database']['localhost'] = '127.0.0.1'
default['OCPinstall']['database']['startfile'] = 'setupSQL.sql'
default['OCPinstall']['database']['socket'] = '/run/mysql-default/mysqld.sock'
default['OCPinstall']['database']['setup_file'] = '/tmp/setupSQL.sql'
set['apt']['compile_time_update'] = 'TRUE'

set['poise-python']['options']['pip_version'] = false
set['poise-python']['options']['setuptools_version'] = '19.2'
set['poise-python']['options']['wheel_version'] = true
set['poise-python']['options']['virtualenv_version'] = false

default['OCPinstall']['database']['username'] = 'brain'
default['OCPinstall']['database']['userpass'] = 'neur0data'
default['OCPinstall']['database']['secret_key'] = 'Imasecretkey123456'
