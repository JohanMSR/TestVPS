FROM eclipse-temurin:21-jre

LABEL maintainer="Minecraft Server"

ENV VERSION=47.4.0
ENV FORGE_URL=https://files.minecraftforge.net/maven/net/minecraftforge/forge/${MINECRAFT_VERSION}-${VERSION}/forge-${MINECRAFT_VERSION}-${VERSION}-installer.jar
ENV MINECRAFT_VERSION=1.21.1

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Create minecraft user and directories
RUN useradd -m -u 1000 -s /bin/bash minecraft && \
    mkdir -p /minecraft /app/server-files && \
    chown -R minecraft:minecraft /minecraft /app

# Copy server files to /app (persistent location)
COPY --chown=minecraft:minecraft ./server-files/ /app/server-files/

# Download and install Forge in /app
WORKDIR /app
RUN wget -O forge-installer.jar https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.21.1-47.4.0/forge-1.21.1-47.4.0-installer.jar && \
    java -jar forge-installer.jar --installServer --acceptLicense || true && \
    rm -f forge-installer.jar installer.jar.log

# Copy start script to /app
COPY --chown=minecraft:minecraft ./server-files/start-server.sh /app/start-server.sh
COPY --chown=minecraft:minecraft ./server-files/enable-all-ops.sh /app/enable-all-ops.sh

# Set permissions on scripts
RUN chmod +x /app/start-server.sh /app/enable-all-ops.sh

WORKDIR /minecraft

# Keep running as root for permission fixes
USER root

EXPOSE 25565

# Start the server
CMD ["/bin/bash", "/app/start-server.sh"]
