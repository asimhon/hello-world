# Packages
default['hello-world']['tomcat']['package'] = 'https://archive.apache.org/dist/tomcat/tomcat-7/v7.0.67/bin/apache-tomcat-7.0.67.tar.gz'
default['hello-world']['java']['package'] = 'https://s3-eu-west-1.amazonaws.com/TBD-installs/jdk-7u79-linux-x64.tar.gz'
default['hello-world']['website']['app'] = 'https://s3-eu-west-1.amazonaws.com/TBD-installs/hello-world.war'

default['hello-world']['java']['jre'] = '/opt/java/jre'
default['hello-world']['tomcat']['version'] = '7.0.67'

default['hello-world']['website']['fqdn'] = 'test.mylab.com'
