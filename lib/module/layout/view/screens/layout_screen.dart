import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/di/di.dart';
import 'package:news/module/layout/view/cubit/layot_cubit.dart';
import 'package:news/module/layout/view/cubit/layout_state.dart';
import 'package:news/module/layout/view/screens/artical_screen.dart';
import 'package:news/module/layout/view/screens/category_screen.dart';
import 'package:news/module/layout/view/screens/search_screen.dart';
import 'package:news/module/layout/view/widget/custom_search.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});
  static const String id = 'layout';

 

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocProvider(
      create: (context) => getIt<LayoutCubit>(),
      child: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {
          if (state is GoToHome) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<LayoutCubit>(context);

          return Scaffold(
            appBar: cubit.isSearch
                ? CustomSearch()
                : AppBar(
                    foregroundColor: theme.primaryColor,
                    centerTitle: true,
                    backgroundColor: theme.scaffoldBackgroundColor,
                    title: Text(
                      cubit.selectedCategory == null
                          ? 'Home'
                          : cubit.selectedCategory!.name,
                      style: theme.textTheme.titleSmall,
                    ),

                    actions: [
                      InkWell(
                        onTap: cubit.closeSearch,
                        child: Icon(Icons.search, size: 28),
                      ),
                    ],
                  ),

            drawer: Drawer(
              backgroundColor: theme.scaffoldBackgroundColor,
              child: Column(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: theme.primaryColor),
                    child: Center(
                      child: Text(
                        'News App',
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        cubit.goToHome();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.home_rounded,
                            color: theme.primaryColor,
                            size: 34,
                          ),
                          SizedBox(width: 16),
                          Text(
                            'Go To Home',
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            body:  cubit.isSearch ? SearchScreen():
            
            cubit.selectedCategory != null
                ? ArticalScreen()
                : CategoryScreen(),
          );
        },
      ),
    );
  }
}
