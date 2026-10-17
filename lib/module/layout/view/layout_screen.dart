import 'package:flutter/material.dart';
import 'package:news/core/categoreis/app_categoreis.dart';
import 'package:news/module/layout/models/sources_response.dart';
import 'package:news/module/layout/service/api_manager.dart';
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
          ? FutureBuilder(
              future: ApiManager.getSource(selectedCategory!.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var source = snapshot.data ?? [];
                  if (selectedsource == null) {
                    selectedsource = source.first;
                  }
                  return Column(
                    children: [
                      DefaultTabController(
                        length: source.length,
                        child: TabBar(
                          onTap: (value) {
                            selectedsource = source[value];
                            setState(() {});
                          },
                          dividerColor: Colors.transparent,
                          tabAlignment: .start,
                          isScrollable: true,
                          indicatorColor: theme.primaryColor,
                          labelColor: theme.primaryColor,
                          unselectedLabelColor: theme.primaryColor,
                          tabs: source.map((e) {
                            return Tab(text: e.name ?? '');
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Expanded(
                        child: FutureBuilder(
                          future: ApiManager.getNews(selectedsource!.id!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(snapshot.data.toString()),
                              );
                            } else {
                              var articles = snapshot.data ?? [];
                              return ListView.separated(
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: .all(16),
                                    decoration: BoxDecoration(
                                      borderRadius: .circular(16),
                                      border: Border.all(
                                        color: theme.primaryColor,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: .circular(16),
                                          child: Image.network(
                                            articles[index].urlToImage ??
                                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRU8gBmgKJfyFettXPVl5na8uYWmmCTKGkdjVzNUyjJFg&s=10',
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          articles[index].title ?? '',
                                          style: theme.textTheme.titleSmall,
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                articles[index].author ?? '',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              articles[index].publishedAt!
                                                  .substring(0, 10),
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 16);
                                },
                                itemCount: articles.length,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                      style: theme.textTheme.titleSmall,
                    ),
                  );
                }
              },
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
