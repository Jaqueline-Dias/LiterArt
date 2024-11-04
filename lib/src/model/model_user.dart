import 'package:cloud_firestore/cloud_firestore.dart';

class ModelUser {
  String? userUid;
  String? nickname;
  String? profilePicture;
  String? email;
  String? password;
  String? biography;
  bool? privacy;
  List<dynamic>? bookshelf;
  int? points;

  ModelUser({
    this.userUid,
    this.nickname,
    this.profilePicture,
    this.email,
    this.password,
    this.biography,
    this.privacy,
    this.bookshelf,
    this.points,
  });

  Map<String, dynamic> toMap() {
    return {
      if (userUid != null) 'userUid': userUid,
      if (nickname != null) 'nickname': nickname,
      if (profilePicture != null) 'profilePicture': profilePicture,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (biography != null) 'biography': biography,
      if (privacy != null) 'privacy': privacy,
      if (bookshelf != null) 'bookshelf': bookshelf,
      if (points != null) 'points': points,
    };
  }

  ModelUser.fromJson(Map<String, dynamic> json)
      : userUid = json['userUid'],
        nickname = json['nickname'],
        profilePicture = json['profilePicture'],
        email = json['email'],
        password = json['password'],
        biography = json['biography'],
        privacy = json['privacy'],
        bookshelf = json['bookshelf'],
        points = json['points'];

  factory ModelUser.fromDocument(DocumentSnapshot doc) {
    final dados = doc.data()! as Map<String, dynamic>;
    return ModelUser.fromJson(dados);
  }

  @override
  String toString() {
    return "Email: $email\n Senha: $password";
  }
}
