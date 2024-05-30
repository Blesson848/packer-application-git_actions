#!/bin/bash

# Store the repository URL provided as the first argument
my_url="$1"

# Increase SSH ClientAliveInterval and restart SSH service
echo "ClientAliveInterval 60" >> /etc/ssh/sshd_config
systemctl restart sshd.service

# Install Apache HTTP server and Git
yum install -y httpd php git

# Clone the repository
git clone "${my_url}" /var/website/

# Copy the application files to the web server directory
cp -r /var/website/application/* /var/www/html/

# Set appropriate permissions
chown -R apache:apache /var/www/html/

# Restart Apache and enable it to start on boot
systemctl restart httpd.service php-fpm.service
systemctl enable httpd.service php-fpm.service
