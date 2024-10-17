import 'package:cloud_firestore/cloud_firestore.dart';

class ModelMessage {
  String? senderUid;
  String? recipientUid;
  String? time;
  String? message;

  ModelMessage({
    this.senderUid,
    this.recipientUid,
    this.time,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      if (senderUid != null) 'senderUid': senderUid,
      if (recipientUid != null) 'recipientUid': recipientUid,
      if (time != null) 'time': time,
      if (message != null) 'message': message,
    };
  }

  ModelMessage.fromJson(Map<String, dynamic> json)
      : senderUid = json['senderUid'],
        recipientUid = json['recipientUid'],
        time = json['time'],
        message = json['message'];

  factory ModelMessage.fromDocument(DocumentSnapshot doc) {
    final dados = doc.data()! as Map<String, dynamic>;
    return ModelMessage.fromJson(dados);
  }

  @override
  String toString() {
    return "Remetente: $senderUid\n Destinatário: $recipientUid";
  }
}
