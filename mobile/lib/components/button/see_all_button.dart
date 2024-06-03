import 'package:flutter/material.dart';

class SeeAllButton extends StatefulWidget {
  final GestureTapCallback onTap;
  const SeeAllButton({super.key, required this.onTap});

  @override
  State<SeeAllButton> createState() => _SeeAllButtonState();
}

class _SeeAllButtonState extends State<SeeAllButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 45,
              width: 45,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: const Offset(1, 1),
                      blurRadius: 4,
                      spreadRadius: 1),
                ],
                borderRadius: BorderRadius.circular(45),
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: Color(0xFFB2572B),
                size: 30,
              ),
            ),
            const Text(
              "Xem tất cả",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
