#
# Cookbook Name:: newrelic
# Recipe:: python-agent
#
# Copyright 2012, Escape Studios
#
rightscale_marker :begin
include_recipe "python::pip"

# install latest python agent
python_pip "newrelic" do
  action :install
  if node[:newrelic][:python_version] != "latest"
    version "#{node[:newrelic][:python_version]}"
  end
end

#configure your New Relic license key
template "/etc/newrelic/newrelic.ini" do
	source "newrelic.ini.python.erb"
	owner "root"
	group "root"
	mode "0644"
	variables(
		:license_key => node[:newrelic][:license_key],
		:app_name => node[:newrelic][:app_name],
		:auto_instrument => node[:newrelic][:auto_instrumentation]
	)
	action :create
end
rightscale_marker :end
