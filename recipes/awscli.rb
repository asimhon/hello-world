#
# Cookbook:: hello-world
# Recipe:: awscli
#
# Ariel Simhon

# Install AWS CLI
execute 'aws_cli_install' do
  command <<-EOF
    wget "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -O "/tmp/awscli-bundle.zip"
    unzip -d "/tmp/" "/tmp/awscli-bundle.zip"
    /tmp/awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
    rm -rf /tmp/awscli-bundle*
  EOF
  not_if  "ls /usr/local/bin/aws"
end
