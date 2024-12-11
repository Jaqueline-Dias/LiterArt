import 'dart:math';

import 'package:app_liter_art/src/core/utils/constants/const_image_strings.dart';
import 'package:app_liter_art/src/core/utils/constants/const_texts.dart';
import 'package:flutter/material.dart';

class SplashKeepViewModel {
  late String selectedBook;
  late String selectedAuthor;
  late String selectedText;

  late AssetImage selectedImage;

  final List<Map<String, dynamic>> quotesAndImages = [
    {
      LATexts.text: LATexts.phrasePequenoPrincipe1,
      LATexts.book: LATexts.titlePequenoPrincipe,
      LATexts.author: LATexts.authorPequenoPrinicipe,
      LATexts.image: LAImages.splashPequenoPrincipe1,
    },
    {
      LATexts.text: LATexts.phrasePequenoPrincipe2,
      LATexts.book: LATexts.titlePequenoPrincipe,
      LATexts.author: LATexts.authorPequenoPrinicipe,
      LATexts.image: LAImages.splashPequenoPrincipe2,
    },
    {
      LATexts.text: LATexts.phraseAliceNoPaisDasMaravilhas1,
      LATexts.book: LATexts.titleAliceNoPaisDasMaravilhas,
      LATexts.author: LATexts.authorAliceNoPaisDasMaravilhas,
      LATexts.image: LAImages.splashAliceNoPaisDasMaravilhas1,
    },
    {
      LATexts.text: LATexts.phraseBibliotecaMeiaNoite,
      LATexts.book: LATexts.titleBibliotecaMeiaNoite,
      LATexts.author: LATexts.authorBibliotecaMeiaNoite,
      LATexts.image: LAImages.splashBibliotecaMeiaNoite,
    },
    {
      LATexts.text: LATexts.phraseHamlet,
      LATexts.book: LATexts.titleHamlet,
      LATexts.author: LATexts.authorHamlet,
      LATexts.image: LAImages.splashHamlet,
    },
    {
      LATexts.text: LATexts.phraseSuicidas1,
      LATexts.book: LATexts.titleSuicidas,
      LATexts.author: LATexts.authorSuicidas,
      LATexts.image: LAImages.splashSuicidas1,
    },
    {
      LATexts.text: LATexts.phraseMorroVentosUivantes,
      LATexts.book: LATexts.titleMorroVentosUivantes,
      LATexts.author: LATexts.authorMorroVentosUivantes,
      LATexts.image: LAImages.splashMorroVentosUivantes,
    },
    {
      LATexts.text: LATexts.phraseSenhorDosAneis,
      LATexts.book: LATexts.titleSenhorDosAneis,
      LATexts.author: LATexts.authorSenhorDosAneis,
      LATexts.image: LAImages.splashSenhorDosAneis,
    },
    {
      LATexts.text: LATexts.phraseHarryPotter1,
      LATexts.book: LATexts.titleHarryPotter1,
      LATexts.author: LATexts.authorHarryPotter1,
      LATexts.image: LAImages.splashSenhorDosAneis,
    },
  ];

  // Seleciona uma frase e imagem aleatória
  void getRandomQuoteAndImage() {
    final random = Random();
    int randomIndex = random.nextInt(quotesAndImages.length);

    selectedText = quotesAndImages[randomIndex][LATexts.text];
    selectedBook = quotesAndImages[randomIndex][LATexts.book];
    selectedAuthor = quotesAndImages[randomIndex][LATexts.author];
    selectedImage = AssetImage(quotesAndImages[randomIndex][LATexts.image]);
  }
}
