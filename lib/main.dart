import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:oromiya_communication/screens/splash_screen.dart';
import 'package:oromiya_communication/theme/app_theme.dart';
import 'package:oromiya_communication/localization/language_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
      child: const OromiaCommApp(),
    ),
  );
}

class OromiaCommApp extends StatelessWidget {
  const OromiaCommApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
          title: 'Oromia Communication Bureau',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: const Color(0xFF0D47A1),
            textTheme: GoogleFonts.poppinsTextTheme(),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF0D47A1),
              primary: const Color(0xFF0D47A1),
              secondary: const Color(0xFF1976D2),
            ),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
