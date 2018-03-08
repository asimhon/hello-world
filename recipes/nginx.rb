#
# Cookbook:: hello-world
# Recipe:: nginx
#
# Ariel Simhon

# Add nginx repo
apt_repository "nginx" do
  uri "ppa:nginx/stable"
  distribution node['lsb']['codename']
  not_if 'ls /etc/apt/sources.list.d/nginx.list'
end

# Update repositories
execute 'apt-update' do
  command 'apt update'
end

# Install nginx
package 'nginx'

# Enable service startup at boot
service 'nginx' do
  supports :status => true, :restart => true
  action [:enable, :start]
end
