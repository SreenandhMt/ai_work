import 'package:ai_work/features/presentation/page/auth/auth_gate.dart';

import '/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:firebase_core/firebase_core.dart';

const String aiKey = "AIzaSyBtSYc3rzX-IStSMHcsYTKMGPHz2idrmh4";
SpeechToText speechToText = SpeechToText();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: aiKey);
  await speechToText.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(background: Colors.grey.shade900,primary: Colors.grey.shade800),
        useMaterial3: true,
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.light(background: Colors.grey.shade100,primary: Colors.grey.shade300),
        useMaterial3: true,
      ),
      home: const AuthGate()
    );
  }
}
