# OneKey Translate

Save **40%+ tokens** when using Claude Code / ChatGPT by interacting in English — even if you think in Chinese.

## Why?

| Same meaning | Chinese | English |
|---|---|---|
| Token consumption | Baseline | **40%–100% fewer** |
| 1000 tokens ≈ | 650 characters | 750 words |

English is the most token-efficient language for LLMs. But most of us think and speak in Chinese. OneKey Translate bridges this gap: **voice input in Chinese → one key → English to LLM → one key → Chinese to read.**

> See [AI Token Pricing Research](https://github.com/Levelup-JC/onekey-translate/blob/main/docs/token-efficiency.md) for detailed data.

## How It Works

```
Input Flow (ZH → EN):
  Speak Chinese (Doubao / Apple Dictation) → text appears
  → Press Cmd+E  →  automatically:
      1. Select all text
      2. Translate to English (Google)
      3. Replace in-place
  → Press Enter to send to LLM

Output Flow (EN → ZH):
  Select LLM's English response
  → Press Cmd+Shift+E  →  Chinese translation pops up
  → Press any key to dismiss
```

## Install (30 seconds)

```bash
curl -fsSL https://raw.githubusercontent.com/Levelup-JC/onekey-translate/main/install.sh | bash
```

Or manually:

```bash
git clone https://github.com/Levelup-JC/onekey-translate.git
cd onekey-translate
bash install.sh
```

After install:
1. Grant Accessibility permission: **System Settings → Privacy & Security → Accessibility → toggle Hammerspoon ON**
2. The menu bar shows a hammer icon — you're ready

## Hotkeys

| Shortcut | Function |
|----------|----------|
| `Cmd+E` | Translate all text in current field (ZH → EN) and replace |
| `Cmd+Shift+E` | Translate selected text (EN → ZH) and show popup |
| Double-tap `E` | Same as `Cmd+E` |

## Recommended Voice Input

| Tool | Platform | Cost | Notes |
|------|----------|------|-------|
| [Doubao Input Method](https://www.doubao.com/input/) | macOS / iOS / Android | Free | Best Chinese recognition, hold Fn to speak |
| Apple Dictation | macOS built-in | Free | Press Fn twice, offline capable |
| [iFlytek Input](https://srf.xunfei.cn/) | macOS / iOS / Android | Free | Good accuracy, multi-dialect |

## Requirements

- macOS 12+
- [Hammerspoon](https://www.hammerspoon.org/) (auto-installed by `install.sh`)
- Internet connection (Google Translate API)

## How It Works (Technical)

```
Cmd+E pressed
  → Cmd+A (select all)
  → Cmd+C (copy)
  → curl → translate.googleapis.com (free, no API key)
  → Cmd+V (paste replacement)
  → Done
```

Translation engine: Google Translate free API. Falls back to Apple's built-in translation if offline.

## License

MIT
