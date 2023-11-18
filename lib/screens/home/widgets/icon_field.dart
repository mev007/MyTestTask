import 'package:flutter/material.dart';

class IconField extends StatelessWidget {
  const IconField({super.key});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.orange[100],
      child: const Icon(
        Icons.lock_open_outlined,
        size: 18,
        color: Colors.orange,
      ),
    );
  }
}
