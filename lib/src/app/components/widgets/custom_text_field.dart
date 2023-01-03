import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CustomChatField extends StatelessWidget {
  const CustomChatField({
    Key? key,
    required this.fieldKey,
    required this.name,
    this.onChanged,
    this.controller,
    this.keyboardType,
  }) : super(key: key);
  final String fieldKey;
  final String name;
  final void Function(String?)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: controller,
      autovalidateMode: AutovalidateMode.disabled,
      name: fieldKey,
      decoration: InputDecoration(
        hintText: name,
      ),
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(
            errorText: 'This Field Required',
          ),
        ],
      ),
      onChanged: onChanged,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }
}
