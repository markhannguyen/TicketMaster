#
# Cookbook:: node_exporter
# Recipe:: install
#
# Copyright:: 2020, The Authors, All Rights Reserved.

# Create a directory.
directory '/opt/node_exporter' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Download Zookeeper.
remote_file '/opt/node_exporter/node_exporter-0.18.1.linux-amd64.tar.gz' do
  source 'https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz'
  action :create
end

# 
bash 'untar_tar_file' do
  cwd '/opt/node_exporter'
  code <<-EOH
  tar -zxf node_exporter-0.18.1.linux-amd64.tar.gz
  cp -f /opt/node_exporter/node_exporter-0.18.1.linux-amd64/node_exporter /usr/local/bin/node_exporter
  EOH
end

# Config file
template '/usr/lib/systemd/system/node_exporter.service' do
  source 'node_exporter.service.erb'
end

# Enable and start service.
service 'node_exporter' do
  action [:enable, :start]
end
