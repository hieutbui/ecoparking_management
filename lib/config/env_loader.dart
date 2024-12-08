import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvLoader {
  static const compileTimeEnvironment = {
    'SUPABASE_PROJECT_URL': String.fromEnvironment('SUPABASE_PROJECT_URL'),
    'SUPABASE_ANON_KEY': String.fromEnvironment('SUPABASE_ANON_KEY'),
  };

  static const String envFileName = '.env';

  static final String supabaseProjectUrl = _loadEnv('SUPABASE_PROJECT_URL');
  static final String supabaseAnonKey = _loadEnv('SUPABASE_ANON_KEY');

  static String _loadEnv(name) => dotenv.get(name);
}
