# Jellyfin with ZeroTier Docker Setup

This project provides a Docker setup for running Jellyfin, a media server, with networking handled by ZeroTier for secure and seamless remote access. This setup ensures that you do not need to expose any ports directly to the internet.

## Prerequisites

- Docker and Docker Compose installed on your machine
- A ZeroTier account and network

## Setup Instructions

1. **Clone the Repository**

   Clone this repository to your local machine.

   ```bash
   git clone https://github.com/yourusername/jellyfin-zerotier-setup.git
   cd jellyfin-zerotier-setup
   ```

2. **Configure Environment**

   Replace placeholders in the `docker-compose.yml` file with your paths and network ID:
   
   - Replace `REPLACE_WITH_YOUR_CONFIG_PATH` with your Jellyfin config path.
   - Replace `REPLACE_WITH_YOUR_CACHE_PATH` with your Jellyfin cache path.
   - Replace `REPLACE_WITH_YOUR_MEDIA_PATH` with your media files path.
   - Replace `REPLACE_WITH_YOUR_ZEROTIER_PATH` with your ZeroTier data path.
   - Replace `REPLACE_WITH_NETWORK_ID` with your ZeroTier network ID.

3. **Build and Deploy the Container**

   Run the following command to build and start the container:

   ```bash
   docker-compose up --build -d
   ```

   The service will start automatically and join the configured ZeroTier network.

4. **Access Jellyfin**

   Use ZeroTier network to access Jellyfin:

   - Find the Jellyfin instance's IP in the ZeroTier network.
   - Open your web browser and go to `http://<Jellyfin_IP>:8096`.

## Customization

- **PUID and PGID**: Update these environment variables in the `docker-compose.yml` to match your local user and group IDs for proper file permissions.
  
- **Ports**: Ports are handled by ZeroTier. Ensure your client machine is also connected to the same ZeroTier network.

## ZeroTier Network

Ensure that your machine is also part of the ZeroTier network. Use the ZeroTier One client to join the same network with the ID specified in the `docker-compose.yml`.

## Troubleshooting

- **Container Logs**: Check the logs of the Jellyfin container using:

  ```bash
  docker logs jellyfin-other
  ```

- **ZeroTier Connection**: Verify that the container has successfully joined the ZeroTier network:

  ```bash
  docker exec jellyfin-other zerotier-cli listnetworks
  ```

## Contributing

Feel free to open an issue or submit a pull request with improvements or fixes. For major changes, please open an issue first to discuss what you'd like to change.

---

This setup is a starting point and may require further configuration based on your media setup and network needs.
```

### Explanation:
- **Introduction**: The README begins with a brief introduction to the project.
- **Prerequisites**: Lists the required software and accounts.
- **Setup Instructions**: Provides step-by-step instructions for setting up the environment, building, and deploying the container.
- **Customization**: Explains how to modify environment variables.
- **ZeroTier Network**: Highlights the significance of being part of the same ZeroTier network.
- **Troubleshooting**: Offers basic troubleshooting steps.
- **Contributing**: Details on how others can contribute to the project.

Make sure to adjust the repository URL and any specific instructions according to your actual setup and preferences.