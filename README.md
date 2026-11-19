# Newsly - AI-Assisted News Aggregator

A cross-platform news reader application developed with Flutter that aggregates global headlines via NewsAPI, computes concise article summaries using OpenAI inference endpoints, and reads articles aloud via native Text-to-Speech (TTS).

## Features

- Multi-Source Aggregation: Curates top stories and category-specific streams via NewsAPI.
- AI Executive Summaries: Condenses long-form journalism into actionable executive briefs.
- Integrated Text-to-Speech: Native speech synthesis using `flutter_tts` for eyes-free listening.
- State Management: Reactive architecture built on Flutter Provider.

## Build Requirements

- Flutter SDK >= 3.2.0
- Valid NewsAPI and OpenAI API credentials configured in `.env`

```bash
flutter pub get
flutter run
```
