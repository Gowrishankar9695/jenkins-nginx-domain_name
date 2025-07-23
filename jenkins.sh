#!/bin/bash

# Exit on any error
set -e

# Update and upgrade the system
echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y

# Install Java (Pre-requisite for Jenkins)
echo "☕ Installing Java (required by Jenkins)..."
sudo apt install fontconfig openjdk-21-jre -y

# Add Jenkins repository and key
echo "📦 Adding Jenkins repo and key..."
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
echo "📥 Installing Jenkins..."
sudo apt update -y
sudo apt install jenkins -y

# Start and Enable Jenkins
echo "🚀 Starting and enabling Jenkins..."
sudo systemctl start jenkins
sudo systemctl enable jenkins
