import 'package:flutter/material.dart';
import 'package:news/module/layout/manager/layout_provider.dart';
import 'package:provider/provider.dart';

class ArticalScreen extends StatelessWidget {
  const ArticalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Consumer<LayoutProvider>(
      builder: (context, provider, child) => Column(
        children: [
          DefaultTabController(
            length: provider.sources!.length,
            child: TabBar(
              onTap: (index) {
                provider.onChangeSources(provider.sources![index]);
              },
              dividerColor: Colors.transparent,
              tabAlignment: .start,
              isScrollable: true,
              indicatorColor: theme.primaryColor,
              labelColor: theme.primaryColor,
              unselectedLabelColor: theme.primaryColor,
              tabs: provider.sources!.map((e) {
                return Tab(text: e.name ?? '');
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.separated(
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
                          provider.articles![index].urlToImage ??
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRU8gBmgKJfyFettXPVl5na8uYWmmCTKGkdjVzNUyjJFg&s=10',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        provider.articles![index].title ?? '',
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              provider.articles![index].author ?? '',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Text(
                            provider.articles![index].publishedAt!.substring(
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
              itemCount: provider.articles!.length,
            ),
          ),
        ],
      ),
    );
  }
}
