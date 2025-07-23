#!/bin/bash

# Read Public IP to a variable
Public_IP=$(curl -s http://checkip.amazonaws.com)

# Assign name to Public IP
echo "$Public_IP myjenkins.jenkinstest.publicvm.com" | sudo tee -a /etc/hosts
