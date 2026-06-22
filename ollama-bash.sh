#!/bin/bash
# ============================================================
# OLLAMA-BASH — Terminal AI Assistant para Modelos Ligeros
# Diseñado para laptops sin GPU dedicada (16GB RAM, Lubuntu)
# ============================================================

set -euo pipefail

# --- Config ---
VERSION="1.0.0"
START_TIME=""
SESSION_DURATION=0
CURRENT_MODEL=""
WORK_DIR="${PWD}"
LOG_FILE="${HOME}/.ollama_bash_history"
WAYHAEAD_DIR="${WORK_DIR}/.wayahead"

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
WHITE='\033[1;37m'
GRAY='\033[0;90m'
BOLD='\033[1m'
NC='\033[0m'

# --- Modelos recomendados por tarea ---
declare -A MODEL_RECOMMENDATIONS
MODEL_RECOMMENDATIONS[code]="qwen2.5-coder:3b"
MODEL_RECOMMENDATIONS[write]="qwen3:4b"
MODEL_RECOMMENDATIONS[chat]="qwen3:4b"
MODEL_RECOMMENDATIONS[summarize]="qwen2.5-coder:1.5b"
MODEL_RECOMMENDATIONS[translate]="qwen2.5-coder:1.5b"
MODEL_RECOMMENDATIONS[wayahead]="qwen3:4b"
MODEL_RECOMMENDATIONS[default]="qwen2.5-coder:3b"

# Modelos ligeros disponibles
LIGHT_MODELS=(
  "qwen2.5-coder:1.5b|986MB|Código simple, resúmenes, traducción"
  "qwen2.5-coder:3b|1.9GB|Código, análisis, tareas generales"
  "qwen3:4b|2.5GB|Escritura, chat, wayahead, reasoning"
  "llama3.2:1b|1.3GB|Ultra ligero, chat básico"
  "llama3.2:3b|2.0GB|Chat, escritura ligera"
  "phi3:3.8b|2.3GB|Razonamiento, código"
  "gemma2:2b|1.6GB|Chat general, lightweight"
  "tinyllama:1.1b|637MB|Minimal, pruebas rápidas"
)

# --- Funciones UI ---
clear_screen() { clear; }

print_header() {
  echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}"
  echo -e "${CYAN}║${NC} ${BOLD}${WHITE}OLLAMA-BASH${NC} ${GRAY}v${VERSION}${NC}                              ${CYAN}║${NC}"
  echo -e "${CYAN}║${NC} ${GRAY}Terminal AI para modelos ligeros Ollama${NC}            ${CYAN}║${NC}"
  echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
  echo ""
}

print_status_bar() {
  local model="${CURRENT_MODEL:-Ninguno}"
  local elapsed="00:00:00"
  local current_time=$(date +"%H:%M:%S")
  if [ -n "$START_TIME" ]; then
    local now=$(date +%s)
    local diff=$((now - START_TIME))
    elapsed=$(printf "%02d:%02d:%02d" $((diff/3600)) $((diff%3600/60)) $((diff%60)))
  fi
  echo -e "${GRAY}┌─────────────────────────────────────────────────────────┐${NC}"
  echo -e "${GRAY}│${NC} 🕒 ${current_time} | Modelo: ${YELLOW}${model}${NC} | ⏱ ${elapsed}${GRAY}│${NC}"
  echo -e "${GRAY}└─────────────────────────────────────────────────────────┘${NC}"
}

print_menu() {
  echo ""
  echo -e "${BOLD}Comandos:${NC}"
  echo -e "  ${GREEN}/models${NC}        Listar modelos disponibles"
  echo -e "  ${GREEN}/use <modelo>${NC}  Seleccionar modelo"
  echo -e "  ${GREEN}/auto${NC}          Auto-seleccionar mejor modelo"
  echo -e "  ${GREEN}/download <m>${NC}  Descargar modelo"
  echo -e "  ${GREEN}/read <archivo>${NC} Leer archivo"
  echo -e "  ${GREEN}/write <archivo>${NC} Escribir archivo"
  echo -e "  ${GREEN}/wayahead${NC}      Generar WAYHAEAD del proyecto"
  echo -e "  ${GREEN}/help${NC}          Mostrar ayuda"
  echo -e "  ${GREEN}/exit${NC}          Salir"
  echo ""
  echo -e "${GRAY}O escribe directamente para chatear con el modelo seleccionado.${NC}"
  echo ""
}

# --- Funciones Ollama ---
check_ollama() {
  if ! command -v ollama &>/dev/null; then
    echo -e "${RED}Error: Ollama no está instalado.${NC}"
    echo -e "Instala: curl -fsSL https://ollama.com/install.sh | sh"
    exit 1
  fi
}

get_available_models() {
  ollama list 2>/dev/null | tail -n +2 | awk '{print $1}'
}

model_exists() {
  local model="$1"
  ollama list 2>/dev/null | grep -q "^${model} "
}

recommend_model() {
  local task="$1"
  local task_lower=$(echo "$task" | tr '[:upper:]' '[:lower:]')

  if [[ "$task_lower" =~ (code|program|script|bug|fix|function) ]]; then
    echo "qwen2.5-coder:3b"
  elif [[ "$task_lower" =~ (write|essay|story|email|report) ]]; then
    echo "qwen3:4b"
  elif [[ "$task_lower" =~ (summar|resum|short|brief) ]]; then
    echo "qwen2.5-coder:1.5b"
  elif [[ "$task_lower" =~ (translat|traduc) ]]; then
    echo "qwen2.5-coder:1.5b"
  elif [[ "$task_lower" =~ (wayahead|roadmap|plan|sprint) ]]; then
    echo "qwen3:4b"
  else
    echo "qwen2.5-coder:3b"
  fi
}

select_model() {
  local model="$1"
  if model_exists "$model"; then
    CURRENT_MODEL="$model"
    echo -e "${GREEN}✓ Modelo seleccionado: ${BOLD}${model}${NC}"
  else
    echo -e "${YELLOW}Modelo '${model}' no está descargado.${NC}"
    echo -e "Descargar ahora? (y/n): "
    read -r answer
    if [[ "$answer" =~ ^[yY] ]]; then
      download_model "$model"
      CURRENT_MODEL="$model"
    fi
  fi
}

download_model() {
  local model="$1"
  echo -e "${CYAN}Descargando ${model}...${NC}"
  echo -e "${GRAY}(Esto puede tardar dependiendo de tu conexión)${NC}"
  ollama pull "$model"
  echo -e "${GREEN}✓ ${model} descargado${NC}"
}

auto_select() {
  local prompt="$1"
  local recommended=$(recommend_model "$prompt")
  local available=$(get_available_models)

  echo -e "${CYAN}Analizando tarea...${NC}"

  if echo "$available" | grep -q "^${recommended}$"; then
    echo -e "${GREEN}✓ Modelo recomendado: ${BOLD}${recommended}${NC}"
    echo -e "${GRAY}(Ya disponible en tu sistema)${NC}"
    CURRENT_MODEL="$recommended"
  else
    echo -e "${YELLOW}Modelo recomendado: ${recommended} (no descargado)${NC}"
    echo -e "Modelos disponibles:"
    echo "$available" | while read -r m; do
      echo -e "  ${GRAY}- ${m}${NC}"
    done
    echo ""
    echo -e "Descargar ${recommended}? (y/n): "
    read -r answer
    if [[ "$answer" =~ ^[yY] ]]; then
      download_model "$recommended"
      CURRENT_MODEL="$recommended"
    else
      echo -e "${YELLOW}Usando modelo por defecto disponible...${NC}"
      local first=$(echo "$available" | head -1)
      if [ -n "$first" ]; then
        CURRENT_MODEL="$first"
        echo -e "${GREEN}✓ Usando: ${first}${NC}"
      else
        echo -e "${RED}No hay modelos disponibles. Descarga uno con /download${NC}"
        return 1
      fi
    fi
  fi
}

# --- Chat ---
chat_with_model() {
  local prompt="$1"
  if [ -z "$CURRENT_MODEL" ]; then
    echo -e "${RED}No hay modelo seleccionado. Usa /use o /auto primero.${NC}"
    return 1
  fi

  echo -e "${CYAN}┌─ ${CURRENT_MODEL}${NC}"
  echo -e "${CYAN}│${NC}"

  ollama run "$CURRENT_MODEL" "$prompt" 2>/dev/null

  echo -e "${CYAN}│${NC}"
  echo -e "${CYAN}└─ Fin respuesta${NC}"
}

# --- File Operations ---
read_file() {
  local file="$1"
  if [ -f "$file" ]; then
    echo -e "${GREEN}Leyendo: ${file}${NC}"
    echo -e "${GRAY}─────────────────────────────────────────${NC}"
    cat "$file"
    echo -e "${GRAY}─────────────────────────────────────────${NC}"
  else
    echo -e "${RED}Archivo no encontrado: ${file}${NC}"
  fi
}

write_file() {
  local file="$1"
  echo -e "${GREEN}Escribiendo en: ${file}${NC}"
  echo -e "${GRAY}(Escribe contenido, Ctrl+D para guardar)${NC}"
  cat > "$file"
  echo -e "${GREEN}✓ Archivo guardado: ${file}${NC}"
}

# --- WAYHAEAD Generator ---
generate_wayahead() {
  if [ -z "$CURRENT_MODEL" ]; then
    echo -e "${RED}Necesitas un modelo seleccionado para generar WAYHAEAD.${NC}"
    return 1
  fi

  local project_name=$(basename "$WORK_DIR")
  local output_file="${WAYHAEAD_DIR}/WAYHAEAD.md"

  mkdir -p "$WAYHAEAD_DIR"

  echo -e "${CYAN}Generando WAYHAEAD para: ${project_name}${NC}"
  echo -e "${GRAY}Analizando estructura del proyecto...${NC}"

  local file_tree=$(find "$WORK_DIR" -maxdepth 2 -not -path '*/\.*' -not -path '*/node_modules/*' | head -30)
  local git_log=$(git log --oneline -5 2>/dev/null || echo "No git history")

  local prompt="Genera un documento WAYHAEAD (roadmap) para el proyecto '${project_name}'.

Estructura del proyecto:
${file_tree}

Últimos commits:
${git_log}

Incluye:
1. Descripción del proyecto
2. Estado actual
3. Sprint completados
4. Próximos sprints con tareas específicas
5. Roadmap a 3-6 meses
6. Métricas de éxito

Formato Markdown limpio."

  local result=$(ollama run "$CURRENT_MODEL" "$prompt" 2>/dev/null)

  cat > "$output_file" << EOF
# WAYHAEAD — ${project_name}

> Generado: $(date '+%Y-%m-%d %H:%M')
> Modelo: ${CURRENT_MODEL}
> Directorio: ${WORK_DIR}

---

${result}

---

*Documento generado automáticamente por Ollama-Bash v${VERSION}*
EOF

  echo -e "${GREEN}✓ WAYHAEAD generado: ${output_file}${NC}"
}

# --- Main Loop ---
main() {
  check_ollama
  clear_screen
  print_header

  # Mostrar modelos disponibles
  local available=$(get_available_models)
  if [ -n "$available" ]; then
    echo -e "${BOLD}Modelos instalados:${NC}"
    echo "$available" | while read -r m; do
      local size=$(ollama list 2>/dev/null | grep "^${m} " | awk '{print $3}')
      echo -e "  ${GREEN}●${NC} ${m} ${GRAY}(${size})${NC}"
    done
  else
    echo -e "${YELLOW}No hay modelos instalados.${NC}"
    echo -e "Ejecuta: ${GREEN}/download qwen2.5-coder:3b${NC}"
  fi

  echo ""
  START_TIME=$(date +%s)

  while true; do
    print_status_bar
    print_menu
    echo -ne "${BOLD}${CYAN}❯ ${NC}"
    read -r input

    case "$input" in
      /models)
        echo -e "${BOLD}Modelos disponibles:${NC}"
        ollama list 2>/dev/null
        echo ""
        echo -e "${BOLD}Modelos ligeros recomendados:${NC}"
        for m in "${LIGHT_MODELS[@]}"; do
          IFS='|' read -r name size desc <<< "$m"
          if model_exists "$name"; then
            echo -e "  ${GREEN}✓${NC} ${name} ${GRAY}(${size})${NC} - ${desc}"
          else
            echo -e "  ${GRAY}○${NC} ${name} ${GRAY}(${size})${NC} - ${desc}"
          fi
        done
        ;;
      /use)
        read -r model_name <<< "${input#* }"
        if [ -n "$model_name" ]; then
          select_model "$model_name"
        else
          echo -e "${YELLOW}Uso: /use <nombre-modelo>${NC}"
        fi
        ;;
      /auto)
        read -r task <<< "${input#* }"
        if [ -n "$task" ]; then
          auto_select "$task"
        else
          echo -e "${YELLOW}Uso: /auto <describe tu tarea>${NC}"
        fi
        ;;
      /download)
        read -r model_name <<< "${input#* }"
        if [ -n "$model_name" ]; then
          download_model "$model_name"
        else
          echo -e "${YELLOW}Uso: /download <nombre-modelo>${NC}"
        fi
        ;;
      /read)
        read -r file_path <<< "${input#* }"
        if [ -n "$file_path" ]; then
          read_file "$file_path"
        else
          echo -e "${YELLOW}Uso: /read <ruta-archivo>${NC}"
        fi
        ;;
      /write)
        read -r file_path <<< "${input#* }"
        if [ -n "$file_path" ]; then
          write_file "$file_path"
        else
          echo -e "${YELLOW}Uso: /write <ruta-archivo>${NC}"
        fi
        ;;
      /wayahead)
        generate_wayahead
        ;;
      /help)
        print_menu
        ;;
      /exit|/quit|exit|quit)
        echo -e "${GREEN}Sesión terminada. Hasta la próxima!${NC}"
        exit 0
        ;;
      "")
        continue
        ;;
      *)
        # Chat directo
        if [ -n "$input" ]; then
          chat_with_model "$input"
        fi
        ;;
    esac

    echo ""
    echo -e "${GRAY}Presiona Enter para continuar...${NC}"
    read -r
    clear_screen
    print_header
  done
}

main "$@"
