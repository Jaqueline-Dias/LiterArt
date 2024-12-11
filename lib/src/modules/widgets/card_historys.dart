import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/core/utils/utils.dart';
import 'package:app_liter_art/src/modules/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LACardHistorys extends StatelessWidget {
  const LACardHistorys(
      {super.key,
      this.date,
      this.imageBook,
      this.title,
      this.authors,
      this.category,
      this.pageNumber,
      this.onTap,
      required this.docId,
      this.buttonStatus = true});

  final dynamic date;
  final String? imageBook;
  final String? title;
  final String? authors;
  final String? category;
  final String? pageNumber;
  final void Function()? onTap;
  final String docId;
  final bool buttonStatus;

  @override
  Widget build(BuildContext context) {
    Future<void> updateDonationStatus(String docId, bool newStatus) async {
      try {
        await FirebaseFirestore.instance
            .collection('donations')
            .doc(docId)
            .update({'status': newStatus});
        print('Status atualizado para $newStatus');
      } catch (e) {
        print('Erro ao atualizar status: $e');
      }
    }

    final LAUtils util = LAUtils();
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  util.formatDate(date),
                  style: const TextStyle(fontSize: 11),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      imageBook ??
                          'https://firebasestorage.googleapis.com/v0/b/literart-529e2.appspot.com/o/profile_default.png?alt=media&token=1aefd6f3-94bf-47ff-bd31-f304d543fdb1',
                      fit: BoxFit.cover,
                      height: 150,
                      width: 100,
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title ?? 'Sem título',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            authors ?? 'Autor desconhecido',
                            style: const TextStyle(fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          buttonStatus
                              ? LABottonDeleteStatus(
                                  imageIcon: 'assets/images/icons/status.svg',
                                  titleIcon: 'Disponível',
                                  onTap: () {
                                    _showConfirmAvailableDialog(
                                      context,
                                      docId,
                                      () async => await updateDonationStatus(
                                          docId, true),
                                    );
                                  },
                                )
                              : Container(),
                          const SizedBox(
                            height: 8,
                          ),
                          LABottonDeleteStatus(
                            imageIcon: 'assets/images/icons/delete.svg',
                            titleIcon: 'Excluir',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: const BoxDecoration(
                  color: LAColors.buttonPrimary,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                  ),
                ),
                child: const Text(
                  'Ver mais detalhes',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showConfirmAvailableDialog(
    BuildContext context, String docId, Future<void> Function() onConfirm) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Alterar status de doação"),
        content: const Text("Este livro já foi doado?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              await onConfirm(); // Chama a função de atualização
              Navigator.of(context).pop(); // Fecha o modal
            },
            child: const Text(
              "Confirmar",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}
