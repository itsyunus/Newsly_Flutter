
# 📰 Newsly – AI-Powered News App

**Newsly** is a modern Flutter application that delivers the latest global headlines and summarizes them using **AI models from OpenRouter (GPT-4 class)**.  
It features a clean UI, real-time updates, and optional voice playback of summaries.

---

## 🌟 Features
- 🗞️ Fetches live top headlines by category (Tech, Health, Business, Science, etc.)  
- 🤖 AI-generated concise summaries (3–5 bullet points + TL;DR)  
- 🔊 Text-to-speech support to read summaries aloud  
- 🌐 “Open Source” button to view full articles in browser  
- 🌙 Dark & light theme support  
- 💻 Cross-platform: Android, iOS, Web, and Windows  
- 🧩 Built with clean architecture using Provider + Services pattern  

---

## 🛠️ Tech Stack
| Layer | Technology |
|-------|-------------|
| Frontend | Flutter (Dart) |
| News Data | [NewsAPI.org](https://newsapi.org/) |
| AI Summarization | [OpenRouter API](https://openrouter.ai) (GPT-4o-mini) |
| Speech | Flutter TTS |
| State Management | Provider |
| Config / API | HTTP, URL Launcher, DotEnv |

---

## ⚙️ Installation

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/<your-username>/newsly.git
cd newsly
```

### 2️⃣ Initialize Flutter & Dependencies
```bash
flutter create .
flutter pub get
```

### 3️⃣ Configure Environment
Copy and edit your `.env` file:
```bash
copy .env.example .env
```

**Edit `.env`:**
```
NEWS_API_KEY=your-newsapi-key
OPENAI_API_KEY=your-openrouter-key
OPENAI_MODEL=gpt-4o-mini
OPENAI_BASE_URL=https://openrouter.ai/api/v1
```

---

## 🚀 Run the App
```bash
flutter run
```

Choose your preferred device (Windows, Chrome, Android, etc.).

---

## 📂 Project Structure
```
lib/
 ├─ core/
 │   ├─ app_config.dart        # Environment loader
 │   ├─ app_constants.dart     # Global constants
 │   └─ app_theme.dart         # Theme definitions
 ├─ models/
 │   └─ article.dart           # Article data model
 ├─ services/
 │   ├─ news_service.dart      # Fetches news from NewsAPI
 │   ├─ ai_service.dart        # Summarizes using OpenRouter AI
 │   └─ favorites_service.dart # Manages saved favorites
 ├─ screens/
 │   ├─ home_screen.dart
 │   ├─ article_detail_screen.dart
 │   └─ settings_screen.dart
 ├─ widgets/
 │   ├─ article_card.dart
 │   ├─ empty_state.dart
 │   └─ error_view.dart
 └─ main.dart                  # App entry point
```

---

## 🔑 API Keys
- **NewsAPI:** [https://newsapi.org/register](https://newsapi.org/register)  
- **OpenRouter:** [https://openrouter.ai](https://openrouter.ai)

---

## 💡 Notes
- Free OpenRouter models (like `gpt-4o-mini`) may have rate limits.  
- For production, hide API keys securely (not in client code).  
- UI and logic are fully modular, allowing easy backend integration.

---

## 👨‍💻 Author
**Shaik Mohammad Yunus**  
🎓 B.Tech (Hons.) in Data Science and Data Engineering – Lovely Professional University  

---

## 🧾 License
Licensed under the **MIT License**.  
You’re free to use, modify, and distribute with attribution.

---

### ⭐ Give a Star
If you found this project useful, please star the repo — it motivates further development! 🌟
