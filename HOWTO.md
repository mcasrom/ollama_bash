# Ollama-Bash — HOW TO

## Instalación

```bash
# 1. Clonar
git clone https://github.com/mcasrom/ollama_bash.git
cd ollama_bash

# 2. Hacer ejecutable
chmod +x ollama-bash.sh

# 3. Ejecutar
./ollama-bash.sh
```

## Requisitos

- **Ollama** instalado: `curl -fsSL https://ollama.com/install.sh | sh`
- **Bash** 4.0+
- **Linux** (Lubuntu, Ubuntu, Debian, etc.)
- **RAM:** 4GB mínimo (8GB recomendado)

## Uso Rápido

```bash
./ollama-bash.sh
```

Verás el menú principal con modelos disponibles.

## Comandos

| Comando | Descripción | Ejemplo |
|---------|-------------|---------|
| `/models` | Listar todos los modelos | `/models` |
| `/use <m>` | Seleccionar modelo | `/use qwen2.5-coder:3b` |
| `/auto <tarea>` | Auto-seleccionar mejor modelo | `/auto refactor código` |
| `/download <m>` | Descargar modelo | `/download qwen3:4b` |
| `/read <file>` | Leer archivo | `/read server.ts` |
| `/write <file>` | Escribir archivo | `/write notes.md` |
| `/wayahead` | Generar roadmap del proyecto | `/wayahead` |
| `/help` | Mostrar ayuda | `/help` |
| `/exit` | Salir | `/exit` |

## Chat Directo

Sin comando, escribe directamente:

```
❯ Explica qué hace este código: [pega código]
❯ Traduce al inglés: Hola mundo
❯ Resume este archivo: [contenido]
```

## Modelos Recomendados por Tarea

| Tarea | Modelo | RAM | Velocidad |
|-------|--------|-----|-----------|
| Código | `qwen2.5-coder:3b` | 1.9GB | ⚡⚡⚡ |
| Chat general | `qwen3:4b` | 2.5GB | ⚡⚡ |
| Resúmenes | `qwen2.5-coder:1.5b` | 986MB | ⚡⚡⚡⚡ |
| Traducción | `qwen2.5-coder:1.5b` | 986MB | ⚡⚡⚡⚡ |
| Ultra rápido | `tinyllama:1.1b` | 637MB | ⚡⚡⚡⚡⚡ |
| Razonamiento | `phi3:3.8b` | 2.3GB | ⚡⚡ |

## Flujo Típico

```bash
# 1. Abrir
./ollama-bash.sh

# 2. Auto-seleccionar para tarea
❯ /auto revisar código Python

# 3. Chatear
❯ Revisa este script y sugiere mejoras:
   [pega código]

# 4. Guardar resultado
❯ /write review.md

# 5. Salir
❯ /exit
```

## Pipeline (avanzado)

```bash
# Resumir archivo directamente
cat archivo_grande.log | ./ollama-bash.sh --summarize

# Generar commit message
git diff | ./ollama-bash.sh --commit-msg
```

## Tips

1. **Modelos 1.5b** para tareas simples (rápido, poca RAM)
2. **Modelos 3b-4b** para código y razonamiento
3. Ollama **libera RAM** automáticamente cuando no se usa
4. Usa `/auto` si no sabes qué modelo elegir
5. El WAYHAEAD se guarda en `.wayahead/WAYHAEAD.md`

## Troubleshooting

**Ollama no responde:**
```bash
ollama serve &
```

**Modelo muy lento:**
- Usa un modelo más pequeño (`qwen2.5-coder:1.5b`)
- Cierra otras aplicaciones

**Error de memoria:**
- Verifica RAM libre: `free -h`
- Usa modelos <2GB

---

*Para más info: `./ollama-bash.sh` → `/help`*
