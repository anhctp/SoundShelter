import 'package:flutter/material.dart';

class ButtonAccount extends StatelessWidget {
  final Function()? onPressed;

  const ButtonAccount(void Function() signIn, {
    super.key, 
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 60,
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: const Text(
        "Đăng nhập",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
      ),
    );
  }
}
