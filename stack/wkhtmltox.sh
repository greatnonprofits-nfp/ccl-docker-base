#!/bin/sh

set -e # fail on any error

dpkg -i wkhtmltox-0.12.2.1_linux-trusty-amd64.deb

# Clean up
# ===================================================================
rm -rf /tmp/*
rm -rf /root/.cache