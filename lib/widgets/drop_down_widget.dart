import 'package:flutter/material.dart';
import 'text_widget.dart';
import 'theme.dart';

class DropDownWidget extends StatelessWidget {
  final List<dynamic> list;
  final void Function(Object?) onChanged;
  final String? Function(Object?) validator;
  final Object value;
  const DropDownWidget(
      {super.key, required this.list, required this.onChanged, required this.validator, required this.value});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      key: key,
      items: list
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              onTap: () {},
              child: TextWidget(
                text: e,
                textStyleNum: TextStyleNum.headline3,
                headlineColor: Colors.black54,
                fontWeightNum: FontWeightNum.w500,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      dropdownColor: Colors.white,
      value: value,
      isDense: true,
      borderRadius: BorderRadius.circular(8),
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: Colors.black54,
      ),
      decoration: InputDecoration(
        border: _border,
        enabledBorder: _border,
        disabledBorder: _border,
        focusedBorder: _border,
        enabled: true,
        contentPadding: const EdgeInsets.all(16),
        isDense: false,
        labelStyle: TextThemeApp.textTheme(
          TextStyleNum.headline2,
          context,
          fontWeightNum: FontWeightNum.w500,
          headlineColor: Colors.black,
        ),
        hintStyle: TextThemeApp.textTheme(
          TextStyleNum.headline2,
          context,
          fontWeightNum: FontWeightNum.w500,
          headlineColor: Colors.black54,
        ),
      ),
    );
  }

  OutlineInputBorder get _border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xFFE0E0E0),
          width: 1,
        ),
      );
}
