# DevOps Portfolio —  Path

Repo de práctica del plan DevOps.

## Ramas
- `main` — código estable, solo merge via PR
- `develop` — integración continua
- `feature/*` — funcionalidades nuevas
- `hotfix/*` — correcciones urgentes en producción
EOF
# Develop branch activa
# devops-gitflow-TP03
# devops-gitflow-TP03

# DevOps Portfolio —  Path

Demostración del flujo Gitflow aplicado a scripts de administración Linux.

## Flujo de trabajo

| Rama | Propósito | Se crea desde | Merge hacia |
|---|---|---|---|
| `main` | Código en producción | — | — |
| `develop` | Integración continua | `main` | `main` (via release) |
| `feature/*` | Nuevas funcionalidades | `develop` | `develop` (via PR) |
| `release/*` | Preparación de versión | `develop` | `main` + `develop` |
| `hotfix/*` | Correcciones urgentes | `main` | `main` + `develop` |

## Comandos esenciales

```bash
# Nueva feature
git checkout develop && git checkout -b feature/nombre

# Merge con historial (no fast-forward)
git merge --no-ff feature/nombre

# Ver historial gráfico
git log --oneline --graph --all
Scripts incluidos
•	scripts/sistema.sh — backup, limpieza y reporte del sistema
•	scripts/verificar-permisos.sh — auditoría de usuario devops-deploy
•	scripts/fix-log-perms.sh — hotfix de permisos (v1.1)
Versiones
•	v1.0 — release inicial con scripts de TP 1 y 2
•	v1.1 — hotfix permisos de logs EOF
