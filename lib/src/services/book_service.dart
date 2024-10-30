import 'dart:convert';
import 'package:app_liter_art/src/model/models.dart';
import 'package:http/http.dart' as http;

class BookService {
  //Instância para realizar requisições HTTP.
  http.Client client = http.Client();

  //URL base da API do Google Books
  String baseUrl = "https://www.googleapis.com/books/v1/volumes?q=";

  //Parâmetro para limitar o número de resultados retornados pela API para no máximo 40.
  String maxResults = "&maxResults=40";

  //Método assíncrono que recebe uma string (title) e retorna uma lista de itens (List<Item>), onde cada item representa um livro.
  Future<List<Item>> getAllBooks(String title) async {
    Book parsedBooks;
    Uri baseUrlParsed = Uri.parse("$baseUrl$title$maxResults&printType=books");
    http.Response booksResponse = await client.get(baseUrlParsed);

    if (booksResponse.statusCode == 200) {
      String jsonBooks = booksResponse.body;
      parsedBooks = Book.fromApiBooks(json.decode(jsonBooks));
      List<Item> cleanedBooks = parsedBooks.items
          .where((book) => book.volumeInfo.description.isNotEmpty)
          .toList();

      return cleanedBooks;
    } else {
      return [];
    }
  }

  //Direciona para a página do livro no Google Books.
  static String getBookUrl(String id, String volumeInfoTitle) {
    String launchUrlBook =
        "https://books.google.com.do/books?id=$id&dq=$volumeInfoTitle";
    return launchUrlBook;
  }
}
