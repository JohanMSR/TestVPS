FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /minecraft

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create minecraft user
RUN useradd -m -s /bin/bash minecraft

# Set environment variables
ENV MINECRAFT_VERSION=1.20.1
ENV FORGE_VERSION=47.4.0
ENV SERVER_PORT=25565
ENV EULA=true

# Create server directory
RUN mkdir -p /minecraft/server
WORKDIR /minecraft/server

# Download and install Forge server
RUN wget -O forge-installer.jar "https://maven.minecraftforge.net/net/minecraftforge/forge/${MINECRAFT_VERSION}-${FORGE_VERSION}/forge-${MINECRAFT_VERSION}-${FORGE_VERSION}-installer.jar" && \
    java -jar forge-installer.jar --installServer && \
    rm forge-installer.jar

# Copy server files
COPY server-files/ ./

# Set ownership
RUN chown -R minecraft:minecraft /minecraft

# Switch to minecraft user
USER minecraft

# Expose port
EXPOSE 25565

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:25565 || exit 1

# Start server
CMD ["java", "-Xmx2G", "-Xms1G", "-jar", "forge-1.20.1-47.4.0.jar", "nogui"]
