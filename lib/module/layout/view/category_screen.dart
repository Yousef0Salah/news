import 'package:flutter/material.dart';
import 'package:news/core/categoreis/app_categoreis.dart';
import 'package:news/module/layout/widget/category_widget.dart';

class CategoryScreen extends StatelessWidget {
   CategoryScreen({super.key,required this.onTap});
  void Function(int index) onTap;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Padding(
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
                    onTap(index);
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
    );
  }
}
