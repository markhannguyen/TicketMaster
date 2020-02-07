#
# Cookbook:: chrony
# Recipe:: install
#
# Copyright:: 2020, The Authors, All Rights Reserved.

# Install Chrony package.
package 'chrony'

# Config file
template '/etc/chrony.conf' do
  source 'chrony.conf.erb'
end

# Enable and start service.
service 'chronyd' do
  action [:enable, :start]
end
