import 'dart:io';
import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
//import 'package:app_liter_art/src/modules/liter_art_service/assessments/assesment_view_model.dart';
import 'package:app_liter_art/src/modules/liter_art_service/donations/widgets/donation_registration_confirm.dart';
import 'package:app_liter_art/src/modules/widgets/widgets.dart';
import 'package:app_liter_art/src/repositories/services/firestore/firestore_service_assessment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AssessmentConfirmationPage extends StatefulWidget {
  final String title;
  final String author;
  final String? category;
  final int pageNumber;
  final int pagesRead;
  final File? selectedImage;
  final String? apiImageUrl;

  const AssessmentConfirmationPage({
    super.key,
    required this.title,
    required this.author,
    this.category,
    required this.pageNumber,
    this.selectedImage,
    this.apiImageUrl,
    required this.pagesRead,
  });

  @override
  State<AssessmentConfirmationPage> createState() =>
      _AssessmentConfirmationPageState();
}

class _AssessmentConfirmationPageState
    extends State<AssessmentConfirmationPage> {
  double _rating = 0.0; // Avaliação inicial
  final _assessmentEC = TextEditingController();

  //final AssessmentViewModel _viewModel = AssessmentViewModel();
  final addressEC = TextEditingController();
  final FirestoreServiceAssessment _firestoreServiceAssessment =
      FirestoreServiceAssessment();
  // final List<File> _imagens = [];
  bool _isLoading = false;
  String? conservation;

  @override
  void dispose() {
    super.dispose();
    addressEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isLoading
          ? null
          : AppBar(
              leading: const BottomNavigatorAppBar(),
              title: const Text(
                'Nova avaliação',
                style: LAAppTheme.textInfoAppBar,
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 24),
                  child: Text(
                    '2/2',
                    style: LAAppTheme.textInfoAppBar,
                  ),
                )
              ],
            ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Atribuir uma nota',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Labels "Ruim" e "Bom" ao lado do centro
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Ruim", style: TextStyle(fontSize: 12)),
                        Center(
                          child: RatingBar.builder(
                            initialRating: _rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.purple.shade300,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                _rating = rating;
                              });
                            },
                          ),
                        ),
                        const Text("Bom", style: TextStyle(fontSize: 12)),
                      ]),
                  const SizedBox(height: 16),
                  const Text(
                    'Comentário avaliativo',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _assessmentEC,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Deixe sua opinião a respeito desta obra...',
                      filled: true,
                      fillColor: Colors.purple.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      await _submitAssessments(context);
                    },
                    child: const Text('Confirmar Avaliação'),
                  ),
                ],
              ),
            ),
    );
  }

  String _gerarNome() {
    final now = DateTime.now();
    return now.millisecondsSinceEpoch.toString();
  }

  Future<String?> _uploadSelectedImage(String userId) async {
    if (widget.selectedImage == null) return null;

    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      Reference imageRef =
          storage.ref().child(userId).child('assessments/${_gerarNome()}.jpg');
      final TaskSnapshot task = await imageRef.putFile(widget.selectedImage!);

      if (task.state == TaskState.success) {
        return await task.ref.getDownloadURL();
      }
    } catch (e) {
      print("Erro ao fazer upload da imagem selecionada: $e");
    }
    return null;
  }

  Future<void> _submitAssessments(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String userId = auth.currentUser!.uid;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    setState(() {
      _isLoading = true;
    });

    // Upload da imagem de capa selecionada (se houver) e obtenção da URL
    String? coverImageUrl = widget.apiImageUrl;
    if (widget.selectedImage != null) {
      coverImageUrl = await _uploadSelectedImage(userId);
      if (coverImageUrl == null) {
        setState(() {
          _isLoading = false;
        });
        scaffoldMessenger.showSnackBar(
          const SnackBar(
              content:
                  Text('Erro ao enviar a imagem de capa. Tente novamente.')),
        );
        return;
      }
    }

    try {
      await _firestoreServiceAssessment.createAssessment(
        userUid: userId,
        title: widget.title,
        authors: widget.author,
        bookCover: coverImageUrl, // Usa a URL da capa após o upload
        category: widget.category,
        pageNumber: widget.pageNumber,
        comment: _assessmentEC.text,
        note: _rating,
        pagesRead: widget.pagesRead,
      );

      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Avaliação criada com sucesso!')),
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const DonationRegistrationConfirm()),
      );
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Erro ao criar postagem: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
