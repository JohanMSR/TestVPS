#!/bin/bash

echo "Starting Minecraft Forge Server..."

# Enable all players as operators
if [ -f "enable-all-ops.sh" ]; then
    chmod +x enable-all-ops.sh
    ./enable-all-ops.sh
fi

# Set memory settings
export JAVA_OPTS="-Xmx${MAX_MEMORY:-4G} -Xms${MIN_MEMORY:-2G} -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch"

# Check if Forge server files exist
if [ ! -f "run.sh" ] && [ ! -f "server.jar" ] && [ ! -f "forge-*.jar" ]; then
    echo "First time setup detected. Installing Forge..."
    wget -O forge-installer.jar https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.21.1-47.4.0/forge-1.21.1-47.4.0-installer.jar
    java -jar forge-installer.jar --installServer --acceptLicense
    
    # Run the install script if it exists
    if [ -f "run.sh" ]; then
        chmod +x run.sh
        ./run.sh || true
    fi
    
    rm -f forge-installer.jar installer.jar.log
fi

# Accept EULA if not already accepted
if [ ! -f "eula.txt" ]; then
    echo "eula=true" > eula.txt
fi

# Configure server properties
if [ ! -f "server.properties" ]; then
    echo "Creating default server.properties..."
    cat > server.properties <<EOF
#Minecraft server properties
motd=Minecraft Forge Server
force-gamemode=false
generate-structures=true
difficulty=normal
pvp=true
online-mode=true
spawn-monsters=true
spawn-animals=true
spawn-npcs=true
max-players=20
view-distance=10
server-port=25565
max-world-size=29999984
network-compression-threshold=256
max-tick-time=60000
enable-rcon=false
snooper-enabled=true
enable-command-block=false
max-build-height=320
resource-pack=
resource-pack-prompt=
resource-pack-sha1=
sync-chunk-writes=true
function-permission-level=2
level-type=minecraft\\:normal
enable-jmx-monitoring=false
server-ip=
broadcast-rcon-to-ops=true
enable-query=false
op-permission-level=4
prevent-proxy-connections=false
hide-online-players=false
resource-pack-id=
entity-broadcast-range-percentage=100
simulation-distance=10
player-idle-timeout=0
max-chained-neighbor-updates=1000000
enforce-secure-profile=true
log-ips=true
gamemode=survival
broadcast-console-to-ops=true
enforce-whitelist=false
spawn-protection=16
max-players=20
rate-limit=0
hardcore=false
white-list=false
EOF
fi

# Find the forge jar file
if [ -f "run.sh" ]; then
    exec ./run.sh
elif [ -f "forge-1.21.1-47.4.0-universal.jar" ]; then
    exec java ${JAVA_OPTS} -jar forge-1.21.1-47.4.0-universal.jar nogui
elif [ -f "forge-*.jar" ]; then
    exec java ${JAVA_OPTS} -jar forge-*.jar nogui
else
    echo "ERROR: Could not find Forge server jar file!"
    exit 1
fi
