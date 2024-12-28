import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:app_liter_art/src/modules/liter_art_service/chat/chat_service.dart';
import 'package:app_liter_art/src/modules/widgets/message_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/chat_bubble_widget.dart';

class ChatScreen extends StatelessWidget {
  final String receiverNickname;
  final String receiverId;

  ChatScreen(
      {super.key, required this.receiverNickname, required this.receiverId});

  //Texto Controller
  final TextEditingController _messageController = TextEditingController();

  //chat & auth services
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Enviar mensagens
  void sendMessage() async {
    //caso exista algo no textefield
    if (_messageController.text.isNotEmpty) {
      //envia
      await _chatService.sendMessage(receiverId, _messageController.text);
      //após enviar limpar o controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: LAColors.textPrimary,
            size: 32,
          ),
        ),
        title: Text(
          receiverNickname,
          style: const TextStyle(color: LAColors.textPrimary),
        ),
        backgroundColor: LAColors.light,
      ),
      body: Column(
        children: [
          //exibir todas as menssagens
          Expanded(
            child: _buildMessageList(),
          ),
          //Input do usuário
          _buildUserInput(),
        ],
      ),
    );
  }

  //build da lista de menssagens
  Widget _buildMessageList() {
    String senderId = _auth.currentUser!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(senderId, receiverId),
      builder: (context, snapshot) {
        //erros
        if (snapshot.hasError) {
          return const Text("Erro");
        }
        //carregar
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Carregando...");
        }
        //listar
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  //build menssagens individuais
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //se for o usuário logado
    bool isCurrentUser = data["senderUid"] == _auth.currentUser!.uid;

    //se for o outro usuário alinhar para o outro lado
    var aligment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: aligment,
      child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubbleWidget(
                message: data["message"], isCurrent: isCurrentUser),
          ]),
    );
  }

  //build input de menssagem
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            child: CustomChatTextField(
              controller: _messageController,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: LAColors.buttonPrimary,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(top: 15, right: 15, bottom: 15),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
