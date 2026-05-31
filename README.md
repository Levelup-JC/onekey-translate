# OneKey Translate

**A workflow that saves 40%+ LLM tokens by letting you think in Chinese but interact in English.**

## The Problem

When you use Claude Code / ChatGPT / Cursor in Chinese, you burn **40%–100% more tokens** than saying the same thing in English.

| Same meaning | Chinese | English |
|---|---|---|
| Token consumption | Baseline | **40%–100% fewer** |
| 1000 tokens ≈ | 650 characters | 750 words |

But typing English is slow. Voice-typing Chinese is fast. The solution: **voice in Chinese → one key → English to LLM**.

> [Full data: token pricing & efficiency research](docs/token-efficiency.md)

## The Workflow

```
┌──────────────────────────────────────────────────────┐
│                    STEP 1: SPEAK                      │
│                                                      │
│  Voice input tool (Doubao / Apple Dictation)          │
│  Hold Fn → speak Chinese → text appears              │
│                                                      │
│  🔧 TOOL: Doubao Input Method (free, macOS)           │
│     https://www.doubao.com/input/                     │
│     OR: Apple built-in Dictation (press Fn twice)     │
│                                                      │
├──────────────────────────────────────────────────────┤
│                    STEP 2: TRANSLATE                  │
│                                                      │
│  Select text → press Cmd+E                           │
│  → Chinese auto-translated to English                │
│  → English replaces Chinese in-place                  │
│                                                      │
│  🔧 TOOL: OneKey Translate (this repo)                │
│     curl -fsSL https://raw.githubusercontent.com/... │
│                                                      │
├──────────────────────────────────────────────────────┤
│                    STEP 3: SEND                       │
│                                                      │
│  English text is in your Claude Code / ChatGPT input  │
│  → Press Enter → LLM responds in English              │
│                                                      │
│  🔧 TOOL: Claude Code / ChatGPT / Cursor              │
│     (whatever you already use)                        │
│                                                      │
├──────────────────────────────────────────────────────┤
│                    STEP 4: READ                       │
│                                                      │
│  Select LLM's English response → press Cmd+Shift+E    │
│  → Chinese translation pops up                       │
│  → Press any key to dismiss                          │
│                                                      │
│  🔧 TOOL: OneKey Translate (same repo)                │
│                                                      │
└──────────────────────────────────────────────────────┘
```

**Total effort: speak + one key + Enter + one key. No copy-paste.**

## Tools You Need

| Step | Tool | Install | Role |
|------|------|---------|------|
| 1. Speak | **Doubao Input** (recommended) | [doubao.com/input](https://www.doubao.com/input/) | Voice → Chinese text |
| 1. Speak | **Apple Dictation** (built-in) | Press Fn twice | Fallback |
| 2. Translate | **OneKey Translate** (this repo) | ↓ one-line install ↓ | ZH↔EN via hotkey |
| 3. Send | **Claude Code / ChatGPT** | You already have it | LLM chat |
| 4. Read | **OneKey Translate** (same repo) | Already installed from step 2 | Popup reading |

## Install OneKey Translate

```bash
curl -fsSL https://raw.githubusercontent.com/Levelup-JC/onekey-translate/main/install.sh | bash
```

Then: **System Settings → Privacy & Security → Accessibility → toggle Hammerspoon ON.**

Done. You'll see a hammer icon in the menu bar.

## Hotkeys

| Shortcut | What it does |
|----------|-------------|
| `Cmd+E` | Select all text → translate ZH→EN → **replace in-place** |
| `Cmd+Shift+E` | Copy selection → translate EN→ZH → **popup display** |
| Double-tap `E` | Same as `Cmd+E` |

## Quick Start (5 minutes)

1. Install [Doubao Input Method](https://www.doubao.com/input/) for macOS
2. Install OneKey Translate: `curl -fsSL https://raw.githubusercontent.com/Levelup-JC/onekey-translate/main/install.sh | bash`
3. Open Claude Code (or ChatGPT) in VS Code
4. Hold Fn, speak Chinese, release → text appears
5. Press `Cmd+E` → text becomes English
6. Press Enter → LLM responds
7. Select response → `Cmd+Shift+E` → read Chinese popup

## Requirements

- macOS 12+
- Internet (Google Translate API)
- Any voice input tool (Doubao recommended, Apple Dictation as fallback)
- Claude Code / ChatGPT / Cursor / any LLM chat

## License

MIT
