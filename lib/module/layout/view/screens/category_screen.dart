import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/categoreis/app_categoreis.dart';
import 'package:news/module/layout/view/cubit/layot_cubit.dart';
import 'package:news/module/layout/view/cubit/layout_state.dart';
import 'package:news/module/layout/view/widget/category_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
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
                        cubit.onChangeCategoty(AppCategoreis.categoreis[index]);
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
      },
    );
  }
}
