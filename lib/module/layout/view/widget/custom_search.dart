import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/module/layout/view/cubit/layot_cubit.dart';

class CustomSearch extends StatelessWidget implements PreferredSizeWidget {
  const CustomSearch({super.key});
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return SafeArea(
      child: TextFormField(
        onChanged: (value) {
          cubit.searchWithDebounce(value);
        },

        cursorColor: theme.primaryColor,
        style: theme.textTheme.titleSmall,
        decoration: InputDecoration(
          labelText: 'Search',
          labelStyle: theme.textTheme.titleMedium,
          suffixIcon: InkWell(
            onTap: cubit.closeSearch,
            child: Icon(Icons.close, size: 28, color: theme.primaryColor),
          ),
          prefixIcon: Icon(Icons.search, size: 28, color: theme.primaryColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: theme.primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: theme.primaryColor),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72);
}
