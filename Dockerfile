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

# Create minecraft user and directory
RUN useradd -m -s /bin/bash minecraft && \
    mkdir -p /minecraft && \
    chown -R minecraft:minecraft /minecraft

WORKDIR /minecraft

# Copy server files first
COPY --chown=minecraft:minecraft ./server-files/ /minecraft/

# Download and install Forge
RUN wget -O forge-installer.jar https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.21.1-47.4.0/forge-1.21.1-47.4.0-installer.jar && \
    java -jar forge-installer.jar --installServer --acceptLicense || true && \
    rm -f forge-installer.jar installer.jar.log

# Set permissions on scripts
RUN chmod +x /minecraft/start-server.sh /minecraft/enable-all-ops.sh

USER minecraft

EXPOSE 25565

# Start the server
CMD ["/bin/bash", "/minecraft/start-server.sh"]
