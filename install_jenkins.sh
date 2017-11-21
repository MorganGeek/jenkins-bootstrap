sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo --no-check-certificate
sudo rpm --import --nogpgcheck https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install jenkins-2.73.3 -y
