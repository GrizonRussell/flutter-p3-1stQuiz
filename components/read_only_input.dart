import 'package:flutter/material.dart';

class ReadOnlyInput extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final VoidCallback? onTap;

  const ReadOnlyInput({
    Key? key,
    required this.labelText,
    required this.controller,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextFormField(
          readOnly: true,
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(7),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}