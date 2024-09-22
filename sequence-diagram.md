```mermaid
sequenceDiagram
    participant User
    participant Docker
    participant Jellyfin-Container
    participant ZeroTier

    User->>Docker: Deploy Jellyfin Container
    Docker->>Jellyfin-Container: Start
    Jellyfin-Container->>Jellyfin-Container: Install dependencies
    Jellyfin-Container->>ZeroTier: Install ZeroTier client
    Jellyfin-Container->>ZeroTier: Initialize ZeroTier
    Jellyfin-Container->>ZeroTier: Check authtoken.secret

    alt authtoken.secret exists
        Jellyfin-Container->>ZeroTier: Use existing authtoken.secret
    else authtoken.secret missing
        Jellyfin-Container->>ZeroTier: Generate new authtoken.secret
    end
    
    Jellyfin-Container->>ZeroTier: Check port setup
    ZeroTier-->>Jellyfin-Container: Ensure port 9993

    ZeroTier->>ZeroTier: Start service
    ZeroTier->>Jellyfin-Container: Service running
    
    Jellyfin-Container->>ZeroTier: Check network join status
    alt Network joined
        ZeroTier->>Jellyfin-Container: Network already joined
    else Network not joined
        Jellyfin-Container->>ZeroTier: Attempt joining ZeroTier network
    end
    
    User->>Jellyfin-Container: Access Jellyfin via ZeroTier network
    Jellyfin-Container->>User: Serve Jellyfin web interface
```

### Explanation:
1. **Participants**: The diagram identifies the main components involved: User, Docker, Jellyfin Container, and ZeroTier.
2. **Flow**: 
   - The process begins with the user deploying the Jellyfin container using Docker.
   - Inside the container, dependencies are installed, and ZeroTier is set up.
   - It checks for the existence of an `authtoken.secret` and generates one if necessary.
   - The setup ensures that the necessary port for ZeroTier is configured.
   - ZeroTier service starts and confirms its running state back to the Jellyfin container.
   - The container checks if it has joined the correct ZeroTier network and attempts to join if it hasn't already.
3. **User Interactivity**: Finally, the user accesses the Jellyfin web interface through the ZeroTier network.

