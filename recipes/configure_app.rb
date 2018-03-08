#
# Cookbook:: hello-world
# Recipe:: configure_app
#
# Ariel Simhon

# Install prerequisites
include_recipe 'hello-world::jdk-7'
include_recipe 'hello-world::tomcat-7'
include_recipe 'hello-world::nginx'

# Download app artifact
remote_file '/opt/tomcat/webapps/ROOT.war' do
  source "#{node['hello-world']['website']['app']}"
  owner 'tomcat'
  notifies :restart, 'service[tomcat]', :immediate
end

# Add SSL
%w[ web.key web.crt ].each do |myFile|
  cookbook_file "/etc/ssl/private/#{myFile}" do
    source "#{myFile}"
    owner 'root'
    group 'root'
    mode '0600'
  end
end

# Remove default nginx configuration file
cookbook_file "/etc/nginx/sites-enabled/default" do
  action :delete
  notifies :reload, 'service[nginx]', :immediate
end

# Add nginx site configuration file
template "/etc/nginx/sites-available/#{node['hello-world']['website']['fqdn']}" do
  source 'main-site-config.erb'
  mode   '644'
end

# Enable site
link "/etc/nginx/sites-enabled/#{node['hello-world']['website']['fqdn']}.conf" do
  to "/etc/nginx/sites-available/#{node['hello-world']['website']['fqdn']}"
  notifies :reload, 'service[nginx]', :immediate
end
