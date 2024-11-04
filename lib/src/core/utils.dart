import 'dart:convert';
import 'package:app_liter_art/src/model/models.dart';
import 'package:app_liter_art/src/repositories/services/book_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Utils {
  static void getGoogleBooksInfo(String id, String volumeInfoTitle) {
    Uri bookUrl = Uri.parse(
      BookService.getBookUrl(id, volumeInfoTitle),
    );
    launchUrlString(
      bookUrl.toString(),
      mode: LaunchMode.externalApplication,
    );
  }

  static String bookToMap(Item book) {
    Map<String, dynamic> bookMap = Item.toMap(book);
    String jsonBook = jsonEncode(bookMap);
    return jsonBook;
  }

  String formatDate(dynamic date) {
    try {
      DateTime dateTime;

      // Verifica se o tipo é Timestamp e converte para DateTime
      if (date is Timestamp) {
        dateTime = date.toDate();
      } else if (date is String) {
        dateTime = DateTime.parse(date);
      } else {
        throw const FormatException("Tipo de data inválido");
      }

      // Formatar a data como string
      String formattedDate = DateFormat("dd/MM/yyyy").format(dateTime);

      return formattedDate;
    } catch (e) {
      return 'Data inválida';
    }
  }
}
