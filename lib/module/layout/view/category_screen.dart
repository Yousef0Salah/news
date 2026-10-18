import 'package:flutter/material.dart';
import 'package:news/core/categoreis/app_categoreis.dart';
import 'package:news/module/layout/manager/layout_provider.dart';
import 'package:news/module/layout/widget/category_widget.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Consumer<LayoutProvider>(
      builder: (context, provider, child) => Padding(
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
                      provider.onChangeCategoty(
                        AppCategoreis.categoreis[index],
                      );
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
