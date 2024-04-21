import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController textController;

  const InputField({
    super.key,
    required this.label,
    required this.obscureText,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFFB2572B)),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          style: const TextStyle(color: Color(0xFFB2572B)),
          obscureText: obscureText,
          controller: textController,
          decoration: InputDecoration(
            fillColor: const Color(0xFFF4F1E7),
            filled: true,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFB2572B))),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
