#!/bin/bash

# Script to configure all players as operators
# This will be executed on server startup

echo "[Operator Setup] Configuring all players as operators..."

# Set default permission level to 4 (full operator)
cat > config/defaultpermissions.json << 'EOF'
{
  "defaults": {
    "minOpLevel": 0,
    "opPermissionLevel": 4,
    "defaultPlayerPermissionLevel": 4
  },
  "players": []
}
EOF

echo "[Operator Setup] All players will have operator privileges!"
