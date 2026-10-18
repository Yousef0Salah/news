import 'package:flutter/material.dart';
import 'package:news/module/layout/manager/layout_provider.dart';
import 'package:news/module/layout/view/artical_screen.dart';
import 'package:news/module/layout/view/category_screen.dart';
import 'package:provider/provider.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});
  static const String id = 'layout';

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => LayoutProvider(),
      child: Consumer<LayoutProvider>(
        builder: (context, provider, child) => Scaffold(
          appBar: AppBar(
            foregroundColor: theme.primaryColor,
            centerTitle: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            title: Text(
              provider.selectedCategory == null
                  ? 'Home'
                  : provider.selectedCategory!.name,
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
                      provider.goToHome();
                      Navigator.pop(context);
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
          
          body: provider.selectedCategory != null
              ? ArticalScreen()
              : CategoryScreen(),
        ),
      ),
    );
  }
}
