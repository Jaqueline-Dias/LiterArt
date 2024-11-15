import 'package:app_liter_art/src/modules/liter_art_service/assessments/assesment_view_model.dart';
import 'package:app_liter_art/src/modules/liter_art_service/donations/widgets/widget_text_field.dart';
import 'package:app_liter_art/src/modules/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class FormFields extends StatelessWidget {
  final AssessmentViewModel viewModel;

  const FormFields({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        WidgetTextField(
          keyboardType: TextInputType.text,
          label: 'Título',
          controller: viewModel.titleEC,
          validator: Validatorless.required('Título obrigatório'),
        ),
        WidgetTextField(
          keyboardType: TextInputType.text,
          label: 'Autor',
          controller: viewModel.authorEC,
          validator: Validatorless.required('Autor obrigatório'),
        ),
        DropdownButtonFormFieldLiterArt(
          titleButton: 'Categoria',
          title: 'Escolha uma categoria',
          value: viewModel.selectedCategory,
          mainCategories: viewModel.mainCategories,
          valueDrop: 'Outros',
          titleDrop: 'Outros',
          onChanged: viewModel.onCategoryChanged,
          validator: (value) =>
              viewModel.validateDropdown(value, 'Escolha uma categoria'),
        ),
        Row(
          children: [
            Expanded(
              child: WidgetTextField(
                keyboardType: TextInputType.phone,
                label: 'Páginas',
                controller: viewModel.pageNumberEC,
                validator:
                    Validatorless.required('Informe o número de páginas'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: WidgetTextField(
                keyboardType: TextInputType.phone,
                label: 'Páginas lidas',
                controller: viewModel.pagesReadEC,
                validator:
                    Validatorless.required('Informe o número de páginas lidas'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
