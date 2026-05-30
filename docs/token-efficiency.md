# Why English? — Token Efficiency Data

## Chinese vs English Token Consumption

| Metric | English | Chinese |
|--------|---------|---------|
| Per unit text | 1 word ≈ 1–2 tokens | 1 character ≈ 1–1.5 tokens |
| 1000 tokens ≈ | 750 words | 650 characters |
| Compression | High (space-delimited, BPE-optimized) | Lower (no spaces, character-level split) |

**Same meaning, Chinese consumes 40%–100% more tokens than English.**

## Why This Matters

LLMs charge by token (input + output), and output tokens cost 2–5x more than input tokens.

A typical Claude Code session:
- Chinese: ~10,000 tokens per exchange
- English: ~6,000 tokens per exchange
- **You save ~40% every time you use English**

## 2025 LLM Pricing Reference

| Model | Input ($/1M tokens) | Output ($/1M tokens) |
|-------|---------------------|----------------------|
| GPT-4o | $5.00 | $20.00 |
| Claude Opus 4.5 | $5.00 | $25.00 |
| Claude Sonnet 4 | $3.00 | $15.00 |
| Gemini 2.5 Flash | $0.15 | $0.60 |
| DeepSeek V3.2 | $0.28 | $0.42 |

With Chinese, you're paying 40%–100% more for the same conversation.

## Sources

- Anthropic, OpenAI, Google official pricing pages (2025)
- BPE tokenizer analysis: OpenAI tiktoken, Anthropic tokenizer
