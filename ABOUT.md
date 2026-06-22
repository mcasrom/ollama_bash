# Ollama-Bash — About

## ¿Qué es?

**Ollama-Bash** es un asistente de terminal diseñado para usar modelos de IA ligeros con Ollama en laptops sin GPU dedicada.

Piensa en él como un "opencode minimalista" que corre en tu terminal, optimizado para hardware modesto (16GB RAM, CPU integrada).

## ¿Por qué?

Los modelos de IA suelen requerir GPUs potentes. Pero para tareas cotidianas — revisar código, resumir textos, generar scripts, traducir — los modelos ligeros (1.5b-4b parámetros) son suficientes y corren bien en CPU.

Ollama-Bash te da:

- **Zero fricción:** Un script bash, sin dependencias extra
- **Zero consumo:** No carga nada hasta que lo usas
- **Inteligente:** Recomienda el modelo adecuado para cada tarea
- **Práctico:** Lee, escribe y genera docs directamente

## Para quién

- **Developers** que quieren IA sin configurar IDEs pesados
- **Sysadmins** que necesitan ayuda con scripts bash
- **Writers** que quieren resumir o traducir textos
- **Students** que necesitan ayuda con código en laptops básicas
- **Cualquiera** con Ollama instalado y ganas de ser más productivo

## Filosofía

1. **Simple > Complejo** — Un script, sin frameworks
2. **Ligero > Potente** — Modelos 1-4b, no 70b
3. **Local > Cloud** — Tus datos no salen de tu máquina
4. **Práctico > Bonito** — Funciona antes que se ve bien

## Stack

- **Bash** — El runtime
- **Ollama** — El motor de IA
- **Modelos:** Qwen2.5-Coder, Qwen3, Phi3, Llama3.2, Gemma2, TinyLlama

## Limitaciones

Los modelos ligeros tienen límites claros:

- ❌ No esperes razonamiento complejo de nivel GPT-4
- ❌ Contexto limitado (4K-8K tokens)
- ❌ Puede alucinar en temas técnicos profundos
- ✅ Perfecto para: código simple, resúmenes, traducción, brainstorming

## Contacto

- **GitHub:** https://github.com/mcasrom/ollama_bash
- **Email:** threatradar-osint@viajeinteligencia.com

## Licencia

MIT — Úsalo, modifícalo, compártelo.

---

*Hecho para laptops que merecen IA también.* ⚡
