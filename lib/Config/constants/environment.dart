import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String movieDbKey =
      dotenv.env["API_KEY_MOVIEDB"] ?? "No hay API key definida";
}
