import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CurrentSession {
  //SingleTon
  CurrentSession._();
  static final CurrentSession _instance = CurrentSession._();
  factory CurrentSession() => CurrentSession._instance;
  //

  late SharedPreferences prefs;
  SupabaseClient get supabase => Supabase.instance.client;

  String? userUuid;

  Future init() async {
    await dotenv.load(fileName: ".env");
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_KEY']!,
    );
    prefs = await SharedPreferences.getInstance();
  }
}
