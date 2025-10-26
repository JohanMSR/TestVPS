# Minecraft Forge Server 47.4.0

A complete Minecraft Forge server setup with Docker, Git support, and automatic OP permissions for all players.

## Features

- **Minecraft Forge 47.4.0** (Minecraft 1.20.1)
- **Docker containerization** for easy deployment
- **Git version control** with proper .gitignore
- **Automatic OP permissions** for all players
- **Easy backup and restore** functionality
- **Health monitoring** and logging

## Quick Start

### Prerequisites

- Docker and Docker Compose
- Git
- Java 17+ (for local development)

### Installation

1. **Clone the repository:**
```bash
git clone <your-repo-url>
cd minecraft-forge-server
```

2. **Start the server:**
```bash
docker-compose up -d
```

3. **Check server status:**
```bash
docker-compose logs -f
```

### Server Management

#### Start Server
```bash
npm start
# or
docker-compose up -d
```

#### Stop Server
```bash
npm stop
# or
docker-compose down
```

#### View Logs
```bash
npm run logs
# or
docker-compose logs -f
```

#### Backup Server
```bash
npm run backup
```

#### Restore Server
```bash
npm run restore
```

## Configuration

### Server Properties

The server is configured in `server-files/server.properties` with the following key settings:

- **Port:** 25565 (default Minecraft port)
- **Max Players:** 20
- **Gamemode:** Survival
- **PvP:** Enabled
- **Command Blocks:** Enabled
- **OP Permission Level:** 4 (highest)

### OP Permissions

All players automatically receive OP permissions (Level 4) when they join the server. This is configured through:

- `server-files/ops.json` - OP player list
- `server-files/forge-config/forge-server.toml` - Forge-specific settings
- `server-files/auto-op-mod.js` - Auto-OP script

### Docker Configuration

The server runs in a Docker container with:

- **Base Image:** OpenJDK 17
- **Memory:** 2GB max, 1GB initial
- **Port:** 25565 exposed
- **Volumes:** Persistent data storage
- **Health Check:** Built-in monitoring

## File Structure

```
minecraft-forge-server/
├── Dockerfile                 # Docker configuration
├── docker-compose.yml         # Docker Compose setup
├── package.json              # NPM scripts and dependencies
├── .gitignore               # Git ignore rules
├── README.md                # This file
└── server-files/            # Server configuration
    ├── server.properties    # Minecraft server settings
    ├── eula.txt            # EULA agreement
    ├── ops.json            # OP players list
    ├── whitelist.json      # Whitelist (empty by default)
    ├── start.sh            # Server startup script
    ├── auto-op-mod.js      # Auto-OP functionality
    └── forge-config/       # Forge-specific configuration
        └── forge-server.toml
```

## Advanced Configuration

### Memory Settings

To adjust server memory, edit the `Dockerfile`:

```dockerfile
CMD ["java", "-Xmx4G", "-Xms2G", "-jar", "forge-1.20.1-47.4.0.jar", "nogui"]
```

### Port Configuration

To change the server port, update:

1. `docker-compose.yml` - port mapping
2. `server-files/server.properties` - server-port
3. `server-files/forge-config/forge-server.toml` - server-port

### OP Permission Levels

- **Level 0:** No permissions
- **Level 1:** Can bypass spawn protection
- **Level 2:** Can use cheats and command blocks
- **Level 3:** Can use most commands
- **Level 4:** Full OP permissions (default for all players)

## Troubleshooting

### Server Won't Start

1. Check Docker is running: `docker --version`
2. Check logs: `docker-compose logs`
3. Verify Java version in container
4. Check port availability: `netstat -an | grep 25565`

### Players Can't Connect

1. Verify server is running: `docker-compose ps`
2. Check firewall settings
3. Verify port forwarding (if needed)
4. Check server logs for errors

### Performance Issues

1. Increase memory allocation in `Dockerfile`
2. Optimize server properties
3. Monitor resource usage: `docker stats`

## Backup and Restore

### Automatic Backup

```bash
npm run backup
```

This creates a timestamped backup in the `backups/` directory.

### Manual Backup

```bash
docker run --rm -v minecraft-forge_minecraft_data:/data -v $(pwd)/backups:/backup alpine tar czf /backup/manual-backup.tar.gz -C /data .
```

### Restore from Backup

```bash
docker run --rm -v minecraft-forge_minecraft_data:/data -v $(pwd)/backups:/backup alpine tar xzf /backup/backup-file.tar.gz -C /data
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

MIT License - see LICENSE file for details.

## Support

For issues and questions:

1. Check the troubleshooting section
2. Review Docker and Minecraft logs
3. Create an issue in the repository
4. Check Minecraft Forge documentation

---

**Note:** This server setup automatically grants OP permissions to all players. Adjust the configuration if you need different permission levels.
