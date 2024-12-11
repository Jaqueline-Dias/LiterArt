import 'package:app_liter_art/src/common/styles/styles.dart';
import 'package:app_liter_art/src/common/widgets/widgets.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/modules/splash/keep/splash_keep_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashKeepPage extends StatefulWidget {
  const SplashKeepPage({super.key});

  @override
  State<SplashKeepPage> createState() => _SplashKeepPageState();
}

class _SplashKeepPageState extends State<SplashKeepPage> {
  final SplashKeepViewModel _viewModel = SplashKeepViewModel();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _viewModel.getRandomQuoteAndImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          LAWidgetBackground(
            image: _viewModel.selectedImage,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  LAWidgetPhraseBook(
                    text: _viewModel.selectedText,
                    book: _viewModel.selectedBook,
                    author: _viewModel.selectedAuthor,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_auth.currentUser != null) {
                        Navigator.of(context).pushReplacementNamed('/home');
                      } else {
                        Navigator.of(context)
                            .pushReplacementNamed('/splash/welcome');
                      }
                    },
                    child: const Text(
                      LATexts.lAContinue,
                      style: LAStyles.fontSize18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
