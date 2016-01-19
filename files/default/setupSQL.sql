flush privileges;
create user 'brain'@'localhost' identified by 'neur0data';
grant all privileges on *.* to 'neurodata'@'localhost' with grant option;

create user 'neurodata'@'%' identified by 'neur0data';
grant all privileges on *.* to 'neurodata'@'%' with grant option;
