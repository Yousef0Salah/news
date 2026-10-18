import 'package:flutter/material.dart';
import 'package:news/core/const/assets.dart';
import 'package:news/module/layout/view/screens/layout_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String id = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((v) {
      Navigator.pushReplacementNamed(context, LayoutScreen.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Image.asset(Assets.splashLogo, color: theme.primaryColor),
          ),
          Image.asset(
            Assets.newsBranding,
            color: theme.primaryColor,
            width: 214,
          ),
        ],
      ),
    );
  }
}
