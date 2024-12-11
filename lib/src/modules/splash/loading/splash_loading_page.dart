import 'package:app_liter_art/src/common/styles/styles.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashLoadingPage extends StatefulWidget {
  const SplashLoadingPage({super.key});

  @override
  State<SplashLoadingPage> createState() => _SplashLoadingPageState();
}

class _SplashLoadingPageState extends State<SplashLoadingPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 5), () {
        Navigator.of(context).pushReplacementNamed('/splash/keep');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              LAColors.secondary,
              LAColors.light,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Image.asset(
                LAImages.darkAppLogo,
                height: 200,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Text(
                LATexts.appName,
                style: LAStyles.titleAlertDialog,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
