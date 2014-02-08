#!/bin/bash
# Provisioning script for hadoop
echo "======================================"
echo "Running provisioning as user: `whoami`"
echo "======================================"

#Disabling IPv6
#Given the fact that Apache Hadoop is not currently supported on IPv6 networks we will disable IPv6
echo "======================================"
echo "Disabling IPv6"
echo "======================================"
echo "# IPv6 configuration" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
sudo sysctl -p
disabled=`cat /proc/sys/net/ipv6/conf/all/disable_ipv6`
echo "Is IPv6 disabled (1=Yes, 0=No) ? ${disabled}"

# Install some useful software
# jdk - to run hadoop
# telnet, lynx - to troubleshoot http issues from within the vagrant box
echo "======================================"
echo "Installing software"
echo "======================================"
yum install -y java-1.7.0-openjdk-devel lynx telnet

# Makes vagrant user able to connect via ssh to the guest machine without issuing pwd
echo "======================================"
echo "Enabling passwordless SSH login"
echo "======================================"
su - vagrant
cd ~
echo -e 'y\n'|ssh-keygen -t rsa -N "" -P "" -f ~/.ssh/id_rsa
cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
logout
cd ~



# Download and set up Hadoop
echo "======================================"
echo "Installing Hadoop"
echo "======================================"
cd /opt
wget http://it.apache.contactlab.it/hadoop/common/hadoop-2.2.0/hadoop-2.2.0.tar.gz
tar xvf hadoop-2.2.0.tar.gz 
ln -s hadoop-2.2.0 hadoop
chown -R vagrant:vagrant hadoop-2.2.0
chown vagrant:vagrant hadoop
cd ~

# Updates .bashrc
echo "======================================"
echo "Setting Up Environment Variables"
echo "======================================"
echo "export HADOOP_HOME=/opt/hadoop" >> /home/vagrant/.bashrc 
echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.51/" >> /home/vagrant/.bashrc 
echo 'export HADOOP_COMMON_HOME=$HADOOP_HOME' >> /home/vagrant/.bashrc 
echo 'export HADOOP_HDFS_HOME=$HADOOP_HOME/share/hadoop/hdfs' >> /home/vagrant/.bashrc 
echo 'export HADOOP_YARN_HOME=$HADOOP_HOME/share/hadoop/yarn' >> /home/vagrant/.bashrc 
echo 'export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin' >> /home/vagrant/.bashrc 

echo "======================================"
echo "Provisioning Terminated"
echo "======================================"

date > /etc/vagrant_provisioned_at

