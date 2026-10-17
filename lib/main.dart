import 'package:flutter/material.dart';
import 'package:news/core/theme/app_theme.dart';
import 'package:news/core/theme/theme_provider.dart';
import 'package:news/module/layout/view/layout_screen.dart';
import 'package:news/module/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const News());
}

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          // themeMode: provider.theme,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          initialRoute: SplashScreen.id,
          routes: {
            SplashScreen.id: (_) => SplashScreen(),
            LayoutScreen.id: (_) => LayoutScreen(),
          },
        );
      },
    );
  }
}
