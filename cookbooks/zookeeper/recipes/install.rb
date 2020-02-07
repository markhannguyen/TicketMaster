# Install Java.
package 'java-1.8.0-openjdk'

# Create a directory.
directory '/opt/zookeeper' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Download Zookeeper.
remote_file '/opt/zookeeper/apache-zookeeper-3.5.6-bin.tar.gz' do
  source 'http://apache.claz.org/zookeeper/stable/apache-zookeeper-3.5.6-bin.tar.gz'
  action :create
end

# Untar download file.
bash 'untar_tar_file' do
  cwd '/opt/zookeeper'
  code <<-EOH
  tar -zxf apache-zookeeper-3.5.6-bin.tar.gz 
  EOH
end

# Config file Zookeeper.
template '/opt/zookeeper/apache-zookeeper-3.5.6-bin/conf/zoo.cfg' do
  source 'zoo.cfg.erb'
end

# Service for Zookeeper.
template '/usr/lib/systemd/system/zookeeper.service' do
  source 'zookeeper.service.erb'
  end

# Enable and start service.
service 'zookeeper' do
  action [:enable, :start]
end
