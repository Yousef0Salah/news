import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget implements PreferredSizeWidget {
  const CustomSearch({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextFormField(
      cursorColor: theme.primaryColor,
      style: theme.textTheme.titleSmall,
      decoration: InputDecoration(
        labelText: 'Search',
        labelStyle: theme.textTheme.titleMedium,
        suffixIcon: Icon(Icons.close, size: 28, color: theme.primaryColor),
        prefixIcon: Icon(Icons.search, size: 28, color: theme.primaryColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: theme.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: theme.primaryColor),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity,100);
}
