# ClimaFlow ☀️

**Application météo moderne** développée avec **Flutter** + **FastAPI**.

Un projet portfolio complet pour démontrer mes compétences en développement mobile cross-platform et backend.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)

## ✨ Fonctionnalités

- 🌤️ Météo actuelle détaillée (température, ressenti, humidité, vent, pression)
- 🔍 Recherche de ville
- 🖼️ Icônes météo officielles OpenWeatherMap
- ♻️ Rafraîchissement manuel
- 📱 Design moderne et fluide (Mode sombre inclus)
- 🐳 Dockerisation complète

## 🛠 Stack Technique

**Frontend**  
- Flutter (Dart)
- Riverpod (State Management)
- Dio (HTTP Client)
- GoRouter
- Cached Network Image

**Backend**  
- FastAPI (Python)
- OpenWeatherMap API
- SQLAlchemy + AsyncPG
- Pydantic v2

**DevOps**  
- Docker + Docker Compose
- Git

## 📁 Structure du Projet

```bash
climaflow/
├── api/                 # Backend FastAPI
├── gui/                 # Application Flutter
├── docker-compose.yml
└── README.md
