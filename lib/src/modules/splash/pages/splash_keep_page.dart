import 'dart:math';

import 'package:app_liter_art/src/modules/splash/pages/widgets/widget_background.dart';
import 'package:app_liter_art/src/modules/splash/pages/widgets/widget_text_book.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashKeepPage extends StatefulWidget {
  const SplashKeepPage({super.key});

  @override
  State<SplashKeepPage> createState() => _SplashKeepPageState();
}

class _SplashKeepPageState extends State<SplashKeepPage> {
  late String _selectedText;
  late String _selectedBook;
  late String _selectedAuthor;
  late AssetImage _selectedImage;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var auth = FirebaseAuth.instance;
  User? _user;

  final List<Map<String, dynamic>> quotesAndImages = [
    {
      'text': '“Tu te tornas eternamente responsável por aquilo que cativas.”',
      'book': 'O Pequeno Príncipe',
      'author': 'Antoine de Saint-Exupéry',
      'image': 'assets/images/background01.jpg',
    },
    {
      'text':
          '“Só se vê bem com o coração, o essencial é invisível aos olhos.”',
      'book': 'O Pequeno Príncipe',
      'author': 'Antoine de Saint-Exupéry',
      'image': 'assets/images/background02.jpg',
    },
    {
      'text': '“As melhores pessoas são loucas.”',
      'book': 'Alice no País das Maravilhas',
      'author': 'Lewis Carrol',
      'image': 'assets/images/background03.jpg',
    },
    {
      'text': '“O único jeito de aprender é vivendo.”',
      'book': 'A Biblioteca da Meia-Noite',
      'author': 'Matt Haig',
      'image': 'assets/images/background04.jpg',
    },
    {
      'text':
          '“Aceita o conselho dos outros, mas nunca desistas da tua própria opinião.”',
      'book': 'Hamlet',
      'author': 'William Shakespeare',
      'image': 'assets/images/background05.jpg',
    },
    {
      'text':
          '“O pôquer simula a vida. Às vezes você perde, às vezes ganha, mas o negócio é se manter lá, jogando.”',
      'book': 'Suicidas',
      'author': 'Raphael Montes',
      'image': 'assets/images/background06.jpg',
    },
    {
      'text':
          '“A traição e a violência são facas de dois gumes: ferem mais aqueles que as manejam do que seus inimigos.”',
      'book': 'O Morro dos Ventos Uivantes',
      'author': 'Emily Brontë',
      'image': 'assets/images/background07.jpg',
    },
    {
      'text':
          '“Nem tudo que é ouro brilha, nem todos os que vagueiam estão perdidos.”',
      'book': 'O Senhor dos Anéis: A Sociedade do Anel',
      'author': 'J. R. R. Tolkien',
      'image': 'assets/images/background08.jpg',
    },
    {
      'text':
          '“Pode se encontrar a felicidade mesmo nas horas mais sombrias, se a pessoa se lembrar de acender a luz.”',
      'book': 'Harry Potter e o Prisioneiro de Azkaban',
      'author': 'J. K. Rowling',
      'image': 'assets/images/background09.jpg',
    },
  ];

  // Seleciona uma frase e imagem aleatória
  void _getRandomQuoteAndImage() {
    final random = Random();
    int randomIndex = random.nextInt(quotesAndImages.length);

    _selectedText = quotesAndImages[randomIndex]['text'];
    _selectedBook = quotesAndImages[randomIndex]['book'];
    _selectedAuthor = quotesAndImages[randomIndex]['author'];
    _selectedImage = AssetImage(quotesAndImages[randomIndex]['image']);
  }

  @override
  void initState() {
    super.initState();
    _getRandomQuoteAndImage();
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Imagem de fundo
          WidgetBackground(
            image: _selectedImage,
          ),
          // Citação e botão "Continuar" na outra metade
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  WidgetTextBook(
                    text: _selectedText,
                    book: _selectedBook,
                    author: _selectedAuthor,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_auth.currentUser != null) {
// Usuário está logado, redireciona para a home
                        Navigator.of(context).pushReplacementNamed('/home');
                      } else {
// Usuário não está logado, redireciona para a tela de splash
                        Navigator.of(context)
                            .pushReplacementNamed('/splash/welcome');
                      }
                    },
                    child: const Text(
                      'Continuar',
                      style: TextStyle(fontSize: 18),
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
