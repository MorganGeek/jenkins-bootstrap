#!/usr/bin/env bash

JENKINS_VERSION=2.73.3

if ! yum list installed "jenkins" >/dev/null 2>&1; then
   sudo wget --output-document /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo --no-check-certificate
   sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
   sudo yum install jenkins-${JENKINS_VERSION} --assumeyes --nogpgcheck
   sudo systemctl enable jenkins
else
   JENKINS_VERSION=$(yum info jenkins | grep Version | awk '{print $3}')
   echo "Jenkins ${JENKINS_VERSION} is already installed"
fi
