create user 'brain'@'localhost' identified by 'password_here';
grant all privileges on *.* to 'brain'@'localhost' with grant option;

create user 'brain'@'%' identified by 'password_here';
grant all privileges on *.* to 'brain'@'%' with grant option;

create database ocpdjango;
