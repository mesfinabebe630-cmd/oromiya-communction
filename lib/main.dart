import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oromiya_communication/screens/splash_screen.dart';
import 'package:oromiya_communication/theme/app_theme.dart';
import 'package:oromiya_communication/localization/language_provider.dart';
import 'package:oromiya_communication/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const OromiaCommApp(),
    ),
  );
}

class OromiaCommApp extends StatelessWidget {
  const OromiaCommApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Oromia Communication Bureau',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const SplashScreen(),
        );
      },
    );
  }
}
