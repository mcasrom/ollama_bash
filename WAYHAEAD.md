# WAYHAEAD — Ollama-Bash

> **Repo:** https://github.com/mcasrom/ollama_bash  
> **Estado:** v1.0 MVP Funcionando  
> **Fecha:** Junio 2026  
> **Contacto:** threatradar-osint@viajeinteligencia.com

---

## ✅ Sprint 0 — Completado (MVP)

- [x] Terminal UI con colores y status bar
- [x] Reloj en tiempo real + contador de sesión
- [x] Listado de modelos instalados y recomendados
- [x] Selección manual de modelo (`/use`)
- [x] Auto-selección inteligente por tarea (`/auto`)
- [x] Descarga de modelos (`/download`)
- [x] Chat directo con modelo seleccionado
- [x] Lectura de archivos (`/read`)
- [x] Escritura de archivos (`/write`)
- [x] Guardar respuestas IA (`/save`)
- [x] Generador WAYHAEAD (`/wayahead`)
- [x] Zero resource usage hasta ejecución
- [x] Recomendaciones de modelo por tipo de tarea
- [x] Docs: TODO, HOWTO, ABOUT

---

## 📋 Sprint 1 — UX Avanzada (Semana 1-2)

**Objetivo:** Hacer la terminal más cómoda de usar.

- [ ] Historial de prompts (flecha arriba/abajo con `readline`)
- [ ] Autocompletado de nombres de modelo (Tab)
- [ ] Sesiones persistentes (guardar/cargar contexto de chat)
- [ ] Prompt templates predefinidos (`/template code_review`)
- [ ] Modo stream vs bloqueante
- [ ] Indicador de RAM disponible antes de cargar modelo
- [ ] Colores configurables (`~/.ollama-bash.conf`)

---

## 📋 Sprint 2 — Productividad (Semana 3-4)

**Objetivo:** Integración real con flujo de trabajo.

- [ ] Integración con editor (`/edit server.ts` abre nano con contexto IA)
- [ ] Code review automático de archivos (`/review server.ts`)
- [ ] Generador de scripts bash (`/script "backup de logs"`)
- [ ] Traducción de archivos completos (`/translate readme.md en`)
- [ ] Resumen de logs/archivos grandes (`/summarize access.log`)
- [ ] Pipeline: `cat file | ./ollama-bash.sh --summarize`
- [ ] Commit message generator (`/commit`)

---

## 📋 Sprint 3 — Avanzado (Semana 5-6)

**Objetivo:** Features que diferencian de la competencia.

- [ ] Multi-model chat (comparar respuestas de 2 modelos)
- [ ] Benchmark de modelos (velocidad, calidad, RAM)
- [ ] Integración git (PR descriptions, issue templates)
- [ ] Modo batch (procesar múltiples archivos)
- [ ] RAG local básico (buscar en docs del proyecto antes de responder)
- [ ] Stats de uso (modelos más usados, tiempo, tokens estimados)

---

## 📋 Sprint 4 — TUI v2 (Semana 7-8)

**Objetivo:** Interfaz visual tipo opencode pero en terminal.

- [ ] TUI con `dialog` o `whiptail` (menús visuales)
- [ ] Panel lateral con historial de chat
- [ ] Split view: código + respuesta IA
- [ ] Syntax highlighting en respuestas de código
- [ ] Navegación por teclado completa
- [ ] Export de sesiones (Markdown, PDF, JSON)

---

## 📋 Sprint 5 — Ecosistema (Semana 9+)

- [ ] Plugin system (scripts externos que extienden funcionalidad)
- [ ] Fine-tuning prompts por usuario (aprende preferencias)
- [ ] Mobile companion (SSH al laptop desde móvil)
- [ ] Docker image para deploy rápido
- [ ] Integración con VS Code / Neovim
- [ ] Community templates (compartir prompts útiles)

---

## 🎯 Métricas de Éxito

| Métrica | Target |
|---------|--------|
| RAM usage (modelo 3b) | <500MB |
| Startup time | <1 segundo |
| First response (3b CPU) | <5 segundos |
| Zero background | 0% CPU cuando no se usa |
| Modelos soportados | 8+ ligeros |

---

## 💡 Notas Técnicas

- **Ollama** ya maneja carga lazy: el modelo se carga en RAM al primer uso y se libera tras inactividad
- **Bash puro** = sin dependencias de Python/Node = startup instantáneo
- **Modelos recomendados:** Qwen2.5-Coder (código), Qwen3 (escritura), Phi3 (razonamiento)
- **Limitación:** Modelos 1-4b no reemplazan GPT-4, pero cubren 80% de tareas cotidianas

---

*Documento vivo — actualizar al final de cada sprint*
