import 'package:flutter/material.dart';
import 'package:news/core/categoreis/app_categoreis.dart';
import 'package:news/module/layout/widget/category_widget.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});
  static const String id = 'layout';

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

AppCategoreis? selectedCategory;

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
          ? Column(
              children: [
                DefaultTabController(
                  length: 10,
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    tabAlignment: .start,
                    isScrollable: true,
                    indicatorColor: theme.primaryColor,
                    labelColor: theme.primaryColor,
                    unselectedLabelColor: theme.primaryColor,
                    tabs: [
                      Text('All'),
                      Text('All'),
                      Text('All'),
                      Text('All'),
                      Text('All'),
                      Text('All'),
                      Text('All'),
                      Text('All'),
                      Text('All'),
                      Text('All'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: .all(16),
                  decoration: BoxDecoration(
                    borderRadius: .circular(16),
                    border: Border.all(color: theme.primaryColor),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: .circular(16),
                        child: Image.asset('assets/image/test.jpg'),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'yousef salah maarouf',
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              ' By : yousef salah',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Text(
                            'yousef salah',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Good Morning\nHere is Some News For You',
                    style: theme.textTheme.titleMedium,
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            selectedCategory = AppCategoreis.categoreis[index];
                            setState(() {});
                          },
                          child: CategoryWidget(
                            categoreis: AppCategoreis.categoreis[index],
                            isLeft: index % 2 == 0,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 16);
                      },
                      itemCount: AppCategoreis.categoreis.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
