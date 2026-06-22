# Ollama-Bash — TODO / Roadmap

> **Repo:** https://github.com/mcasrom/ollama_bash  
> **Estado:** v1.0 MVP  
> **Fecha:** Junio 2026

---

## ✅ v1.0 — Completado

- [x] Terminal UI con colores y status bar
- [x] Listado de modelos instalados
- [x] Selección manual de modelo (`/use`)
- [x] Auto-selección inteligente por tarea (`/auto`)
- [x] Descarga de modelos (`/download`)
- [x] Chat directo con modelo seleccionado
- [x] Lectura de archivos (`/read`)
- [x] Escritura de archivos (`/write`)
- [x] Generador WAYHAEAD (`/wayahead`)
- [x] Contador de tiempo de sesión
- [x] Zero resource usage hasta ejecución
- [x] Recomendaciones de modelo por tipo de tarea

---

## 📋 v1.1 — Mejoras UX (Semana 1)

- [ ] Historial de prompts (flecha arriba/abajo)
- [ ] Autocompletado de nombres de modelo (Tab)
- [ ] Sesiones persistentes (guardar/cargar contexto)
- [ ] Prompt templates predefinidos (code review, refactor, explain)
- [ ] Output en archivo (`/save <archivo>`)
- [ ] Modo stream vs bloqueante
- [ ] Indicador de RAM disponible antes de cargar modelo

---

## 📋 v1.2 — Productividad (Semana 2)

- [ ] Integración con editor (nano/vim) para editar con IA
- [ ] Code review automático de archivos
- [ ] Generador de scripts bash
- [ ] Traducción de archivos completos
- [ ] Resumen de logs/archivos grandes
- [ ] Pipeline: `cat file | ollama-bash --summarize`

---

## 📋 v1.3 — Avanzado (Semana 3-4)

- [ ] Multi-model chat (comparar respuestas)
- [ ] Benchmark de modelos (velocidad, calidad)
- [ ] Config file (~/.ollama-bash.conf)
- [ ] Aliases personalizados
- [ ] Integración git (commit messages, PR descriptions)
- [ ] Modo batch (procesar múltiples archivos)

---

## 📋 v2.0 — Features Pro

- [ ] TUI con ncurses (menús visuales)
- [ ] Plugin system
- [ ] RAG local (buscar en docs del proyecto)
- [ ] Fine-tuning prompts por usuario
- [ ] Stats de uso (modelos más usados, tiempo, tokens)
- [ ] Export de sesiones

---

## 🎯 Objetivos

| Meta | Target |
|------|--------|
| RAM usage | <500MB modelos 1.5-3b |
| Startup time | <1 segundo |
| First response | <3 segundos (3b en CPU) |
| Zero background | Sin consumo cuando no se usa |

---

*Documento vivo*
