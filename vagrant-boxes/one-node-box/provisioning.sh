#!/bin/bash
# Provisioning script for hadoop

echo "======================================"
echo "Running provisioning as user: `whoami`"
echo "======================================"

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

# Install Java
echo "======================================"
echo "Installink Java"
echo "======================================"
yum install -y java-1.7.0-openjdk-devel

# Download and set up Hadoop
echo "======================================"
echo "Installink Hadoop"
echo "======================================"
cd /opt
wget http://it.apache.contactlab.it/hadoop/common/hadoop-2.2.0/hadoop-2.2.0.tar.gz
tar xvf hadoop-2.2.0.tar.gz 
ln -s hadoop-2.2.0 hadoop

# Updates .bashrc
echo "======================================"
echo "Setting Up Environment Variables"
echo "======================================"
echo "export HADOOP_HOME=/opt/hadoop" >> /home/vagrant/.bashrc 
echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.51/" >> /home/vagrant/.bashrc 
echo 'export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin' >> /home/vagrant/.bashrc 

echo "======================================"
echo "Provisioning Terminated"
echo "======================================"

date > /etc/vagrant_provisioned_at

