import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'text_widget.dart';
import 'theme.dart';

class TextField {
  final String question;
  final String hintText;
  final TextEditingController controller;
  final String? addInfoText;
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String?)? validator;
  const TextField(this.question, this.controller, this.inputFormatters, this.validator,
      {required this.hintText, this.addInfoText});
}

class TextFieldCampo extends StatefulWidget {
  final String question;
  final TextEditingController controller;
  final String hintText;
  final String? hint2Text;
  final String helperText;
  final String? addInfoText;
  final String? Function(String?)? validator;
  final String? Function(String?)? validator2;
  final Function(String)? onChanged;
  final String? buttonText;
  final String? buttonText2;
  final Function(bool value)? isButton2;

  const TextFieldCampo({
    super.key,
    required this.question,
    required this.controller,
    required this.hintText,
    required this.helperText,
    this.addInfoText,
    this.validator,
    this.onChanged,
    this.hint2Text,
    this.validator2,
    this.buttonText,
    this.buttonText2,
    this.isButton2,
  });

  @override
  State<TextFieldCampo> createState() => _TextFieldCampoState();
}

class _TextFieldCampoState extends State<TextFieldCampo> {
  late bool _button2;
  String? error;

  @override
  void initState() {
    _button2 = false;
    widget.controller.addListener(() {
      if (widget.hint2Text?.isNotEmpty == true) {
        if (_button2) {
          error = widget.validator2!(widget.controller.text);
        } else {
          error = widget.validator!(widget.controller.text);
        }
      } else {
        error = widget.validator!(widget.controller.text);
      }
      if (!mounted) return;

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              textStyleNum: TextStyleNum.headline2,
              text: widget.question,
              fontWeightNum: FontWeightNum.w500,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: TextFormField(
                      controller: widget.controller,
                      onChanged: widget.onChanged,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                        border: _border(),
                        errorBorder: _border(),
                        enabledBorder: _border(),
                        focusedBorder: _border(),
                        disabledBorder: _border(),
                        focusedErrorBorder: _border(),
                        hintText: widget.hint2Text?.isNotEmpty == true
                            ? _button2
                                ? widget.hint2Text
                                : widget.hintText
                            : widget.hintText,
                        hintStyle: TextThemeApp.textTheme(
                          TextStyleNum.headline2,
                          context,
                          fontWeightNum: FontWeightNum.w400,
                        ),
                      ),
                      style: TextThemeApp.textTheme(
                        TextStyleNum.headline2,
                        context,
                        fontWeightNum: FontWeightNum.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (error != null)
              TextWidget(
                text: error ?? '',
                headlineColor: Colors.red,
                textStyleNum: TextStyleNum.headline1,
                fontWeightNum: FontWeightNum.w400,
              ),
            const SizedBox(
              height: 8,
            ),
            if (widget.addInfoText?.isNotEmpty ?? false)
              TextWidget(
                textStyleNum: TextStyleNum.headline0,
                text: widget.addInfoText!,
                fontWeightNum: FontWeightNum.w400,
              ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder _border() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
        borderSide: BorderSide(
          color: Color(0xFF9B9EB2),
          width: 0.5,
        ));
  }
}
