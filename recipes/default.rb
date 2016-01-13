#
# Cookbook Name:: OCPinstall
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'apt::default'
include_recipe 'OCPinstall::gitinstall'
include_recipe 'OCPinstall::aptinstall'
include_recipe 'OCPinstall::sqlinstall'
include_recipe 'OCPinstall::servicesConfig'
