import 'package:flutter/material.dart';
import 'package:news/core/categoreis/app_categoreis.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.categoreis,
    required this.isLeft,
  });
  final AppCategoreis categoreis;
  final bool isLeft;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: 185,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: .circular(24),
      ),
      child: Row(
        textDirection: isLeft ? TextDirection.ltr : TextDirection.rtl,
        children: [
          Expanded(flex: 2, child: Image.asset(categoreis.image)),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(categoreis.name, style: theme.textTheme.titleLarge),
                Container(
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor.withValues(alpha: 0.5),
                    borderRadius: .circular(360),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    textDirection: isLeft
                        ? TextDirection.ltr
                        : TextDirection.rtl,

                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'View All',
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: theme.scaffoldBackgroundColor,
                        foregroundColor: theme.primaryColor.withValues(
                          alpha: 0.5,
                        ),
                        child: Icon(
                          isLeft
                              ? Icons.arrow_forward_ios
                              : Icons.arrow_back_ios,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
