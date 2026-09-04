#!/bin/bash
# ============================================
# verificar-permisos.sh — Auditoría de usuario
# TP02 — Operaciones1
# ============================================
set -euo pipefail
USUARIO="devops-deploy"
GRUPO="deploy-team"
APP_DIR="/opt/deploy-app"
REPORTE="$HOME/devops-TP02/reporte-permisos.txt"
log() { echo "$1" | tee -a "$REPORTE"; }
ok()  { echo "  [OK]  $1" | tee -a "$REPORTE"; }
fail(){ echo "  [FAIL] $1" | tee -a "$REPORTE"; }
> "$REPORTE"
log "============================================"
log "  AUDITORÍA DE PERMISOS — $(date)"
log "============================================"
log ""
# --- Verificar usuario y grupo ---
log "--- Usuario y grupo ---"
if id "$USUARIO" &>/dev/null; then
    ok "Usuario '$USUARIO' existe"
    ok "$(id $USUARIO)"
else
    fail "Usuario '$USUARIO' no encontrado"
fi
if getent group "$GRUPO" &>/dev/null; then
    ok "Grupo '$GRUPO' existe"
else
    fail "Grupo '$GRUPO' no encontrado"
fi
log ""
log "--- Permisos de directorios ---"
check_perm() {
    local ruta="$1"
    local esperado="$2"
    local actual
    actual=$(stat -c "%a" "$ruta" 2>/dev/null || echo "no encontrado")
    if [ "$actual" = "$esperado" ]; then
        ok "$ruta → $actual (esperado: $esperado)"
    else
        fail "$ruta → $actual (esperado: $esperado)"
    fi
}
check_perm "$APP_DIR/scripts" "750"
check_perm "$APP_DIR/logs"    "770"
check_perm "$APP_DIR/config"  "750"
log ""
log "--- Pruebas funcionales ---"
# Puede leer config
if sudo -u "$USUARIO" cat "$APP_DIR/config/app.conf" &>/dev/null; then
    ok "Puede LEER config"
else
    fail "No puede leer config"
fi
# No puede escribir config
if sudo -u "$USUARIO" bash -c "echo test >> $APP_DIR/config/app.conf" 2>/dev/null; then
    fail "PUEDE escribir config (vulnerabilidad!)"
else
    ok "No puede ESCRIBIR config (correcto)"
fi
# Puede escribir logs
if sudo -u "$USUARIO" bash -c "echo auditoria >> $APP_DIR/logs/audit.log" 2>/dev/null; then
    ok "Puede ESCRIBIR logs"
else
    fail "No puede escribir logs"
fi


log ""

log "============================================"

log "Auditoría completada: $REPORTE"

log "============================================"


EOF
