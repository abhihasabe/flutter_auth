import 'package:flutter/material.dart';
import 'package:gs_diamond/core/theme/app_colors.dart';

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool first, last;

  const OtpInput(this.controller, this.first, this.last, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            print("value: $value");
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
          keyboardType: TextInputType.number,
          maxLength: 1,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 20.0),
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: primaryColor),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );


      /*SizedBox(
      height: 55,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: controller,
          maxLength: 1,
          cursorColor: Theme.of(context).primaryColor,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              counterText: '',
              hintStyle: TextStyle(color: primaryColor, fontSize: 20.0)),
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
        ),
      ),
    );*/
  }
}
