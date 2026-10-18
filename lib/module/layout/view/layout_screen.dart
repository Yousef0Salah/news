import 'package:flutter/material.dart';
import 'package:news/core/categoreis/app_categoreis.dart';
import 'package:news/module/layout/models/sources_response.dart';
import 'package:news/module/layout/service/api_manager.dart';
import 'package:news/module/layout/view/artical_screen.dart';
import 'package:news/module/layout/view/category_screen.dart';
import 'package:news/module/layout/widget/category_widget.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});
  static const String id = 'layout';

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

AppCategoreis? selectedCategory;
Sources? selectedsource;

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: theme.primaryColor,
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(
          selectedCategory == null ? 'Home' : selectedCategory!.name,
          style: theme.textTheme.titleSmall,
        ),

        actions: [Icon(Icons.search, size: 28)],
      ),

      drawer: Drawer(
        backgroundColor: theme.scaffoldBackgroundColor,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: theme.primaryColor),
              child: Center(
                child: Text('News App', style: theme.textTheme.titleLarge),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  selectedCategory = null;
                  selectedsource = null;
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.home_rounded,
                      color: theme.primaryColor,
                      size: 34,
                    ),
                    SizedBox(width: 16),
                    Text('Go To Home', style: theme.textTheme.titleMedium),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: selectedCategory != null
          ? ArticalScreen(selectedCategory: selectedCategory!)
          : CategoryScreen(
              onTap: (index) {
                selectedCategory = AppCategoreis.categoreis[index];
                setState(() {});
              },
            ),
    );
  }
}
