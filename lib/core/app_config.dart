import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get newsApiKey => dotenv.env['NEWS_API_KEY'] ?? '';
  static String get openAiKey => dotenv.env['OPENAI_API_KEY'] ?? '';
  static String get openAiModel => dotenv.env['OPENAI_MODEL'] ?? 'gpt-4o-mini';
  static String get baseUrl =>
    dotenv.env['OPENAI_BASE_URL'] ?? 'https://api.openai.com/v1';

}