#!/bin/bash

# Install Nginx, Start and Enable
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

# Configure Nginx as reverse proxy for jenkins
cat <<EOF | sudo tee /etc/nginx/sites-available/jenkins
server {
    listen 80;
    server_name myjenkins.jenkinstest.publicvm.com;

    location / {
        proxy_pass         http://localhost:8080;
        proxy_set_header   Host \$host;
        proxy_set_header   X-Real-IP \$remote_addr;
        proxy_set_header   X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header   X-Forwarded-Proto \$scheme;
    }
}
EOF

# Enabling the Jenkins Nginx config...
sudo ln -sf /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/jenkins
sudo rm -f /etc/nginx/sites-enabled/default

# Testing and reloading Nginx...
sudo nginx -t && sudo systemctl reload nginx

# Allowing HTTP traffic through firewall (if UFW is enabled)...
sudo ufw allow 80 || true
sudo ufw allow 8080 || true
