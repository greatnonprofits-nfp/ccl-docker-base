#!/bin/sh

set -e # fail on any error

cd /tmp
wget https://s3.amazonaws.com/hs.communityconnectlabs.com/ImageMagick.tar.gz
tar xzvf ImageMagick.tar.gz
cd ImageMagick-7.0.8-24; ./configure; make; make install
ldconfig

# Clean up
# ===================================================================
rm -rf /tmp/*
rm -rf /root/.cache