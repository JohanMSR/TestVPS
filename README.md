# Minecraft Forge Server (1.21.1 - Forge 47.4.0)

Docker setup for running a Minecraft Forge server on a VPS.

## Features

- ✅ Minecraft 1.21.1 with Forge 47.4.0
- ✅ Automatic Forge download and installation
- ✅ All players have operator privileges by default
- ✅ Persistent data storage
- ✅ Easy mod installation
- ✅ Auto-restart on crash

## Prerequisites

- Docker
- Docker Compose
- 4GB+ RAM recommended
- VPS or dedicated server

## Quick Start

1. **Clone or download this repository**

2. **Build and start the server:**
```bash
docker-compose up -d
```

3. **View logs:**
```bash
docker-compose logs -f
```

4. **Connect to your server:**
- Server IP: Your VPS IP
- Port: 25565 (default)

## Configuration

### Server Properties

Edit `server-data/server.properties` after first run to customize:
- Max players
- Difficulty
- Game mode
- PvP settings
- etc.

### Memory Settings

Edit `docker-compose.yml` to adjust memory:
```yaml
environment:
  - MAX_MEMORY=4G  # Maximum RAM
  - MIN_MEMORY=2G  # Minimum RAM
```

### Server Port

Change the port in `docker-compose.yml`:
```yaml
ports:
  - "25565:25565"  # Change left side for different host port
```

## Directory Structure

```
.
├── docker-compose.yml       # Docker Compose configuration
├── Dockerfile              # Docker image definition
├── server-files/           # Initial server configuration
│   ├── start-server.sh     # Server startup script
│   ├── ops.json           # Operators list
│   └── config/            # Forge config
├── server-data/           # Server runtime data (created on first run)
│   ├── world/            # World files
│   ├── mods/             # Mod files
│   ├── config/           # Mod configurations
│   └── logs/             # Server logs
└── README.md
```

## Adding Mods

1. Stop the server:
```bash
docker-compose down
```

2. Place mod files in `./server-data/mods/` directory

3. Start the server:
```bash
docker-compose up -d
```

## Managing the Server

### View Logs
```bash
docker-compose logs -f minecraft-server
```

### Execute Console Commands
```bash
docker-compose exec minecraft-server rcon-cli <command>
```

### Stop Server
```bash
docker-compose down
```

### Start Server
```bash
docker-compose up -d
```

### Restart Server
```bash
docker-compose restart
```

### Access Server Console
```bash
docker-compose exec minecraft-server bash
```

## Operator Configuration

By default, all players joining the server will have operator privileges. This is configured through the Forge permission system.

To disable this and use traditional whitelist/ops.json:
- Edit `config/defaultpermissions.json`
- Or configure through the Forge permission system in-game

## Troubleshooting

### Server won't start
```bash
# Check logs
docker-compose logs -f

# Check disk space
df -h
```

### Can't connect to server
- Check firewall settings on your VPS
- Verify port 25565 is open
- Check server.properties for correct IP

### Out of memory
- Increase MAX_MEMORY in docker-compose.yml
- Allocate more RAM to Docker

### Forge installation issues
```bash
# Rebuild the container
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

## Security Notes

⚠️ **Important:** The default configuration grants all players operator access. For production use:
- Set `defaultPlayerPermissionLevel: 0` in `config/defaultpermissions.json`
- Use whitelist by setting `white-list=true` in server.properties
- Manage operators through ops.json or in-game commands

## License

This setup is provided as-is for running a Minecraft server.

## Support

For issues related to:
- **Minecraft/Forge**: Visit [Minecraft Forge Forums](https://forums.minecraftforge.net/)
- **Docker**: Visit [Docker Documentation](https://docs.docker.com/)
- **This setup**: Check the logs and configuration files 