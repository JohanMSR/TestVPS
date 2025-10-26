# Installation Guide

## Prerequisites

Before setting up the Minecraft Forge server, ensure you have:

1. **Docker** (version 20.10 or later)
   - Install from: https://docs.docker.com/get-docker/
   
2. **Docker Compose** (version 2.0 or later)
   - Usually included with Docker Desktop
   - Or install separately: https://docs.docker.com/compose/install/

3. **VPS/Dedicated Server** with:
   - Minimum 2GB RAM (4GB+ recommended)
   - 10GB+ free disk space
   - Ubuntu/Debian/CentOS Linux

## Installation Steps

### 1. Prepare Your VPS

Connect to your VPS via SSH:

```bash
ssh user@your-vps-ip
```

### 2. Install Docker (if not already installed)

```bash
# Update system
sudo apt update
sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add your user to docker group (optional)
sudo usermod -aG docker $USER
```

### 3. Upload Server Files

Transfer the server files to your VPS:

```bash
# From your local machine
scp -r * user@your-vps-ip:/home/user/minecraft-server/
```

Or clone the repository on your VPS:

```bash
git clone <repository-url>
cd minecraft-server
```

### 4. Configure Firewall

Open the Minecraft port (25565):

```bash
# UFW (Ubuntu)
sudo ufw allow 25565/tcp
sudo ufw allow 25565/udp
sudo ufw reload

# firewalld (CentOS/RHEL)
sudo firewall-cmd --permanent --add-port=25565/tcp
sudo firewall-cmd --permanent --add-port=25565/udp
sudo firewall-cmd --reload
```

### 5. Build and Start the Server

```bash
# Build the Docker image
docker-compose build

# Start the server
docker-compose up -d

# View logs to verify it's running
docker-compose logs -f
```

### 6. Verify Installation

Check if the container is running:

```bash
docker-compose ps
```

You should see the `minecraft-forge-server` container running.

## First Run

On the first run, the server will:

1. Download Forge 47.4.0 automatically
2. Extract and install it
3. Generate world files
4. Configure default settings
5. Set up operator permissions for all players

This process may take 5-10 minutes. Monitor progress with:

```bash
docker-compose logs -f
```

## Connecting to the Server

Once the server is running:

1. Open Minecraft Launcher
2. Create a new profile or edit existing
3. Set version to "Forge 1.21.1" or "release 1.21.1"
4. Add server with IP: `your-vps-ip:25565`
5. Connect and join!

## Post-Installation

### Change Memory Allocation

Edit `docker-compose.yml`:

```yaml
environment:
  - MAX_MEMORY=8G  # Change to your preference
  - MIN_MEMORY=4G
```

Then restart:

```bash
docker-compose down
docker-compose up -d
```

### Change Server Port

Edit `docker-compose.yml` ports section:

```yaml
ports:
  - "YOUR_PORT:25565"
```

Then restart the server.

### Add Mods

1. Stop the server: `docker-compose down`
2. Copy `.jar` files to `./server-data/mods/`
3. Start the server: `docker-compose up -d`

## Troubleshooting

### Port Already in Use

If you get a port conflict error:

```bash
# Find what's using the port
sudo lsof -i :25565

# Kill the process or change port in docker-compose.yml
```

### Out of Disk Space

```bash
# Check disk usage
df -h

# Clean Docker unused resources
docker system prune -a
```

### Server Won't Start

```bash
# Check logs
docker-compose logs -f

# Rebuild from scratch
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

### Can't Connect to Server

1. Verify firewall rules are applied
2. Check VPS security groups (if using cloud provider)
3. Ensure server is running: `docker-compose ps`
4. Check logs for errors: `docker-compose logs`

## Updating the Server

```bash
# Pull latest changes
git pull

# Rebuild and restart
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

## Backup

Create a backup before major changes:

```bash
# Manual backup
tar -czf backup-$(date +%Y%m%d).tar.gz server-data/

# Or use the Makefile
make backup
```

## Uninstall

To completely remove the server:

```bash
# Stop and remove containers
docker-compose down

# Remove volumes (WARNING: This deletes world data)
docker-compose down -v

# Remove the directory
cd ..
rm -rf minecraft-server
```

## Support

If you encounter issues:

1. Check logs: `docker-compose logs -f`
2. Review `README.md` and `QUICKSTART.md`
3. Check the official Minecraft/Forge documentation
