#
# Cookbook:: hello-world
# Recipe:: tomcat-7
#
# Ariel Simhon

# Add tomcat user
user 'tomcat' do
  shell '/bin/false'
  home '/opt/tomcat'
end

# Add tomcat dir
directory '/opt/tomcat' do
  owner 'tomcat'
  group 'tomcat'
end

# Download Tomcat
remote_file '/tmp/tomcat.tar.gz' do
  source "#{node['hello-world']['tomcat']['package']}"
end

# Install Tomcat
bash 'tomcat-install' do
  user 'tomcat'
    code 'tar -xvf /tmp/tomcat.tar.gz -C /opt/tomcat --strip 1'
end

#Listen tomcat on localhost only
bash 'tomcat-localhost' do
  code <<-EOF
    sed -i 's/Connector port="8080"/Connector address="127.0.0.1" port="8080"/g' /opt/tomcat/conf/server.xml
  EOF
  not_if 'grep \'Connector address="127.0.0.1" port="8080"\' /opt/tomcat/conf/server.xml'
end

# Clean webapps
bash 'clean-webapps' do
  code 'rm -rf /opt/tomcat/webapps/*'
end

# Add tomcat.service
template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

# Add tomcat service
service 'tomcat' do
  action [ :enable, :start ]
end
