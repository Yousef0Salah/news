import 'package:flutter/material.dart';
import 'package:news/core/categoreis/app_categoreis.dart';
import 'package:news/module/layout/models/sources_response.dart';
import 'package:news/module/layout/service/api_manager.dart';

class ArticalScreen extends StatefulWidget {
  final AppCategoreis selectedCategory;
  const ArticalScreen({super.key, required this.selectedCategory});

  @override
  State<ArticalScreen> createState() => _ArticalScreenState();
}

class _ArticalScreenState extends State<ArticalScreen> {
  Sources? selectedsource;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return FutureBuilder(
      future: ApiManager.getSource(widget.selectedCategory.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var source = snapshot.data ?? [];
          selectedsource ??= source.first;
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.data.toString()));
                    } else {
                      var articles = snapshot.data ?? [];
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          return Container(
                            padding: .all(16),
                            decoration: BoxDecoration(
                              borderRadius: .circular(16),
                              border: Border.all(color: theme.primaryColor),
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
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    Text(
                                      articles[index].publishedAt!.substring(
                                        0,
                                        10,
                                      ),
                                      style: TextStyle(color: Colors.grey),
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
        } else if (snapshot.connectionState == ConnectionState.waiting) {
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
    );
  }
}
