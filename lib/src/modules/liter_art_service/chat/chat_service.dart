import 'package:app_liter_art/src/model/model_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  //Pegar instância Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //pegar usuários

  /*
  Exemplo funcionamento
  
  Stream<List<Map<String,dynamic> = 

  [
  {
    'email': teste@gmail.com,
    'id': 0151387
  }
  {
    'email': teste@hotmail.com,
    'id': 0897979
  }
  ]
  */
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //Verifica cada usuário individualmente
        final user = doc.data();
        //Retorna usuário
        return user;
      }).toList();
    });
  }

  //Enviar mensagens
  Future<void> sendMessage(String receiverId, message) async {
    //pegar usuário logado
    final String currentUserID = _auth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    //criar nova mensagem
    ModelMessage newMessage = ModelMessage(
      senderUid: currentUserID,
      recipientUid: receiverId,
      message: message,
      time: timestamp,
    );

    //contrução do chat para dois usuários
    List<String> ids = [currentUserID, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');
    //adicionar mensagem ao banco
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //pegar mensagens
  Stream<QuerySnapshot> getMessages(String currentUserID, otherUserId) {
    List<String> ids = [currentUserID, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("time", descending: false)
        .snapshots();
  }
}
