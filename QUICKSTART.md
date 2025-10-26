# Guía Rápida - Servidor Minecraft Forge

## Inicio Rápido

### 1. Construir y ejecutar el servidor

```bash
docker-compose up -d
```

### 2. Ver los logs del servidor

```bash
docker-compose logs -f
```

### 3. Conectar al servidor

- **IP del servidor**: IP de tu VPS
- **Puerto**: 25565
- **Versión**: Minecraft 1.21.1 con Forge 47.4.0

## Comandos Útiles

### Usando Make (recomendado)

```bash
make start      # Iniciar servidor
make stop       # Detener servidor
make restart    # Reiniciar servidor
make logs       # Ver logs
make shell      # Acceder a la consola
make backup     # Hacer backup
```

### Usando Docker Compose

```bash
# Iniciar
docker-compose up -d

# Detener
docker-compose down

# Ver logs
docker-compose logs -f

# Reiniciar
docker-compose restart

# Acceder a la consola
docker-compose exec minecraft-server bash
```

## Agregar Mods

1. Detener el servidor: `docker-compose down`
2. Copiar archivos `.jar` a la carpeta `./server-data/mods/`
3. Iniciar el servidor: `docker-compose up -d`

## Configuración de Operadores

**IMPORTANTE**: Por defecto, todos los jugadores tienen permisos de operador.

Esto significa que cualquier jugador que se conecte podrá ejecutar comandos de administrador.

### Para desactivar esto:

1. Editar `server-data/config/defaultpermissions.json`
2. Cambiar `"defaultPlayerPermissionLevel": 4` a `"defaultPlayerPermissionLevel": 0`
3. Reiniciar el servidor

## Troubleshooting

### El servidor no inicia

```bash
docker-compose logs -f
```

### Problemas de memoria

Editar `docker-compose.yml` y cambiar:
```yaml
MAX_MEMORY=4G  # Aumentar si tienes más RAM
MIN_MEMORY=2G  # Aumentar si tienes más RAM
```

### Forge no se descarga

El servidor descargará Forge automáticamente la primera vez que se ejecute. Si hay problemas:

```bash
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

## Seguridad

**ADVERTENCIA**: La configuración por defecto otorga permisos de operador a todos los jugadores.

Para un servidor público, considera:
1. Desactivar los permisos de operador por defecto
2. Usar whitelist (`white-list=true` en server.properties)
3. Configurar protección contra griefing

## Estructura de Directorios

```
├── docker-compose.yml       # Configuración de Docker
├── Dockerfile              # Imagen Docker
├── server-files/           # Configuración inicial
│   ├── start-server.sh
│   ├── enable-all-ops.sh   # Script para operadores
│   └── config/
├── server-data/            # Datos del servidor (se crea automáticamente)
│   ├── world/             # Mundo del servidor
│   ├── mods/              # Mods instalados
│   └── logs/              # Logs del servidor
└── README.md
```

## Más Información

Ver `README.md` para documentación completa.
