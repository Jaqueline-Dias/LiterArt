import 'package:app_liter_art/src/modules/liter_art_service/chat/chat_service.dart';
import 'package:app_liter_art/src/modules/screen/chat_screen.dart';
import 'package:app_liter_art/src/modules/widgets/user_tile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeedMessagePage extends StatefulWidget {
  const FeedMessagePage({super.key});

  @override
  State<FeedMessagePage> createState() => _FeedMessagePageState();
}

class _FeedMessagePageState extends State<FeedMessagePage> {
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUserlist(),
    );
  }

  //retorna a lista de usuários
  Widget _buildUserlist() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          //erros
          if (snapshot.hasError) {
            return const Text("Erro");
          }
          //carregar
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Carregando...");
          }
          //visualizar lista de usuários
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserlistItem(userData, context))
                .toList(),
          );
        });
  }

  //retorna usuários individualmente
  Widget _buildUserlistItem(
      Map<String, dynamic> userData, BuildContext context) {
    //Exibir se diferente do usuário logado
    if (userData["email"] != _auth.currentUser!.email) {
      return UserTileWidget(
        text: userData["nickname"],
        onTap: () {
          // Clicar no usuário => pagina de chat
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen(
                        receiverNickname: userData["nickname"],
                        receiverId: userData["userUid"],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
