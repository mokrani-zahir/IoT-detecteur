# Projet IoT

Système de monitoring et contrôle d'humidité et tempirateur avec Node-RED, PostgreSQL et Mosquitto (MQTT).

## Architecture

- **Node-RED** : Interface de workflow et dashboard (port 1880)
- **PostgreSQL** : Base de données persistante (port 5432)
- **Mosquitto** : Broker MQTT pour communication IoT (port 1883)

## Prérequis

- Docker & Docker Compose
- Git

## Installation rapide

```bash
# 1. Cloner le repository
git clone https://github.com/votre-username/humidateur.git
cd humidateur
```

## Renommer le fichier :

.env.example vers .env

## Lance docker compose :

```bash
# 3. Démarrer les services
docker-compose up -d
```
# 4 . Accéder aux services
Node-RED : http://localhost:1880 \
PostgreSQL : http://localhost:5432 \
Mosquitto MQTT : http://localhost:1883