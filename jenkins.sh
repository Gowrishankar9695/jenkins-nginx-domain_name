#!/bin/bash

# Exit on any error
set -e

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install Java (required by Jenkins)
sudo apt install fontconfig openjdk-21-jre -y

# Add Jenkins repository and key
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
sudo apt update -y
sudo apt install jenkins -y

# Start and Enable Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins
