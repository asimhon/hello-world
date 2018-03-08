#
# Cookbook:: hello-world
# Recipe:: jdk-7
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Download Java
remote_file '/tmp/jdk-7.tar.gz' do
  source "#{node['hello-world']['java']['package']}"
end

# Create java directory
directory '/opt/java'

# Install Java
bash 'java-install' do
  user 'root'
  code 'tar -xvf /tmp/jdk-7.tar.gz -C /opt/java --strip 1 && chown -R root. /opt/java'
  not_if 'ls /opt/java/bin/java'
end

