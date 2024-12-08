import 'package:flutter/material.dart';

class SbtTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Widget icon;
  final bool keybordNumbber;

  const SbtTextField({
    super.key,
    required this.controller,
    required this.icon,
    required this.label,
    this.keybordNumbber = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: TextField(
          controller: controller,
          keyboardType:
              keybordNumbber ? TextInputType.number : TextInputType.text,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            prefixIcon: icon,
            labelText: label,
            labelStyle: theme.textTheme.bodySmall?.copyWith(
              color: theme.hintColor,
            ),
            filled: true,
            fillColor: theme.cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.primaryColor, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.dividerColor, width: 1),
            ),
          ),
        ),
      ),
    );
  }
}
