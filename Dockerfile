FROM jellyfin/jellyfin:latest

# Install dependencies and ZeroTier
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget gnupg openssl curl supervisor && \
    curl -s https://install.zerotier.com | bash && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Ensure the `zerotier-one` data directory exists
RUN mkdir -p /var/lib/zerotier-one && \
    chown root:root /var/lib/zerotier-one && \
    echo "9993" > /var/lib/zerotier-one/zerotier-one.port

# Create a random authtoken.secret if it doesn't exist
RUN openssl rand -base64 32 > /var/lib/zerotier-one/authtoken.secret && \
    chmod 600 /var/lib/zerotier-one/authtoken.secret && \
    chown root:root /var/lib/zerotier-one/authtoken.secret

# # Expose required ports
# we don't need to expose ports here, as we will use the zeroTier network
# EXPOSE 8096 8920

# Copy the zerotier-init script and make it executable
COPY zerotier-init.sh /zerotier-init.sh
RUN chmod +x /zerotier-init.sh
