import 'dart:convert';
import 'package:app_liter_art/src/core/utils/constants/const_api.dart';
import 'package:app_liter_art/src/model/models.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class BookService {
  // Injeção de dependência do cliente HTTP, padrão é http.Client
  final http.Client client;
  final String baseUrl;
  final int maxResults;
  final Logger _logger = Logger();

  BookService({
    http.Client? client,
    this.baseUrl = lASecretAPIKeyGoogleBook,
    this.maxResults = 40,
  }) : client = client ?? http.Client();

  // Método que busca todos os livros com o título fornecido
  Future<List<Item>> getAllBooks(String title) async {
    // Monta a URL de requisição com o título e configurações adicionais
    final Uri requestUrl =
        Uri.parse("$baseUrl$title&maxResults=$maxResults&printType=books");

    try {
      final http.Response response = await client.get(requestUrl);

      // Verifica se a resposta da API foi bem-sucedida
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBooks = json.decode(response.body);

        if (jsonBooks['items'] != null) {
          // Converte JSON para modelo Book e filtra livros com descrição
          final Book parsedBooks = Book.fromApiBooks(jsonBooks);
          final List<Item> cleanedBooks = parsedBooks.items
              .where((book) => book.volumeInfo.description.isNotEmpty)
              .toList();
          return cleanedBooks;
        } else {
          _logger.w('Nenhum item encontrado na resposta da API.');
          return [];
        }
      } else {
        _logger.e('Erro na requisição: ${response.statusCode}');
        return [];
      }
    } on http.ClientException catch (e) {
      _logger.e('Erro de conexão: $e');
      return [];
    } on FormatException catch (e) {
      _logger.e('Erro ao processar resposta JSON: $e');
      return [];
    } catch (e) {
      _logger.e('Erro inesperado ao buscar livros: $e');
      return [];
    }
  }

  // Constrói a URL de visualização do livro no Google Books
  static String getBookUrl(String id, String volumeInfoTitle) {
    return "https://books.google.com/books?id=$id&dq=$volumeInfoTitle";
  }
}
