#!/bin/bash

set -e

# Ensure correct ZeroTier setup: Create authtoken only if it doesn't exist
if [ ! -f /var/lib/zerotier-one/authtoken.secret ]; then
  openssl rand -base64 32 > /var/lib/zerotier-one/authtoken.secret
  chmod 600 /var/lib/zerotier-one/authtoken.secret
  chown root:root /var/lib/zerotier-one/authtoken.secret
fi

# Ensure ZeroTier port is set
echo "9993" > /var/lib/zerotier-one/zerotier-one.port

# Start the ZeroTier service in the background
if ( ! pgrep -x "zerotier-one" ); then
  echo "Starting ZeroTier service..."
  /usr/sbin/zerotier-one &

  # Wait for ZeroTier service initialization
  sleep 5
fi

# check zerotier-cli networklist join REPLACE_WITH_NETWORK_ID
if zerotier-cli listnetworks | grep -q REPLACE_WITH_NETWORK_ID; then
  exit 0
else
  echo "ZeroTier network not joined."
  # Attempt to join the ZeroTier network
  zerotier-cli join REPLACE_WITH_NETWORK_ID
  sleep 5  
fi
