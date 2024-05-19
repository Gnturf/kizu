import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kizu/auth/presentation/screens/auth.dart';
import 'package:kizu/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(16, 56, 81, 1),
          background: const Color.fromRGBO(16, 56, 81, 1),
          onBackground: const Color.fromRGBO(235, 200, 119, 1),
          primary: const Color.fromRGBO(235, 200, 119, 1),
          onPrimary: const Color.fromRGBO(16, 56, 81, 1),
          secondary: const Color.fromRGBO(191, 105, 129, 1),
          onSecondary: const Color.fromRGBO(16, 56, 81, 1),
          primaryContainer: const Color.fromRGBO(255, 255, 255, 0.1),
          onPrimaryContainer: const Color.fromRGBO(255, 255, 255, 0.2),
          secondaryContainer: const Color.fromRGBO(255, 255, 255, 0.1),
          onSecondaryContainer: const Color.fromRGBO(16, 56, 81, 1),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontFamily: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
            ).fontFamily,
            fontSize: 32,
            color: const Color.fromRGBO(235, 200, 119, 1),
          ),
          displayMedium: TextStyle(
            fontFamily: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
            ).fontFamily,
            fontSize: 28,
            color: const Color.fromRGBO(235, 200, 119, 1),
          ),
          displaySmall: TextStyle(
            fontFamily: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
            ).fontFamily,
            fontSize: 22,
            color: const Color.fromRGBO(235, 200, 119, 1),
          ),
          titleLarge: TextStyle(
            fontFamily: GoogleFonts.roboto().fontFamily,
            fontSize: 18,
            color: const Color.fromRGBO(235, 200, 119, 1),
          ),
          titleMedium: TextStyle(
            fontFamily: GoogleFonts.roboto().fontFamily,
            fontSize: 16,
            color: const Color.fromRGBO(235, 200, 119, 1),
          ),
          labelLarge: TextStyle(
            fontFamily: GoogleFonts.roboto().fontFamily,
            fontSize: 14,
            color: const Color.fromRGBO(235, 200, 119, 1),
          ),
          labelMedium: TextStyle(
            fontFamily: GoogleFonts.roboto().fontFamily,
            fontSize: 12,
            color: const Color.fromRGBO(235, 200, 119, 1),
          ),
          headlineLarge: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontSize: 18,
            color: const Color.fromRGBO(235, 200, 119, 1),
          ),
          headlineMedium: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontSize: 16,
            color: const Color.fromRGBO(235, 200, 119, 1),
          ),
          bodyLarge: TextStyle(
            fontFamily: GoogleFonts.openSans().fontFamily,
            fontSize: 16,
            color: const Color.fromRGBO(235, 200, 119, 1),
          ),
          bodyMedium: TextStyle(
            fontFamily: GoogleFonts.openSans().fontFamily,
            fontSize: 14,
            color: const Color.fromRGBO(235, 200, 119, 1),
          ),
          bodySmall: TextStyle(
            fontFamily: GoogleFonts.openSans().fontFamily,
            fontSize: 12,
            color: const Color.fromRGBO(235, 200, 119, 1),
          ),
        ),
      ),
      home: const AuthScreen(),
    );
  }
}
