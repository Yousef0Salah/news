import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/module/layout/view/cubit/layot_cubit.dart';
import 'package:news/module/layout/view/cubit/layout_state.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticalScreen extends StatelessWidget {
  const ArticalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var cubit = BlocProvider.of<LayoutCubit>(context);

    return Column(
      children: [
        BlocBuilder<LayoutCubit, LayoutState>(
          buildWhen: (previous, current) =>
              current is GetSourcesSuccessState ||
              current is GetSourcesLoadingState ||
              current is GetSourcesErrorState,

          builder: (context, state) {
            if (state is GetSourcesLoadingState) {
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (state is GetSourcesSuccessState) {
              return DefaultTabController(
                length: cubit.sources!.length,
                child: TabBar(
                  onTap: (index) {
                    cubit.onChangeSources(cubit.sources![index]);
                  },
                  dividerColor: Colors.transparent,
                  tabAlignment: .start,
                  isScrollable: true,
                  indicatorColor: theme.primaryColor,
                  labelColor: theme.primaryColor,
                  unselectedLabelColor: theme.primaryColor,
                  tabs: cubit.sources!.map((e) {
                    return Tab(text: e.name ?? '');
                  }).toList(),
                ),
              );
            } else if (state is GetSourcesErrorState) {
              return SizedBox();
              // return Text(state.error, style: theme.textTheme.titleMedium);
            } else {
              return SizedBox();
            }
          },
        ),
        BlocBuilder<LayoutCubit, LayoutState>(
          buildWhen: (previous, current) =>
              current is GetNewsSuccessState ||
              current is GetNewsLoadingState ||
              current is GetNewsErrorState,
          builder: (context, state) {
            if (state is GetNewsLoadingState) {
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (state is GetNewsSuccessState) {
              return Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          // showDragHandle: true,
                          useSafeArea: true,
                          backgroundColor: theme.primaryColor,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: .circular(16),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          cubit.articles![index].urlToImage ??
                                          '',
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),

                                    // Image.network(
                                    //   provider.articles![index].urlToImage ??
                                    //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRU8gBmgKJfyFettXPVl5na8uYWmmCTKGkdjVzNUyjJFg&s=10',
                                    // ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    cubit.articles![index].description ?? '',
                                    style: theme.textTheme.titleSmall!.copyWith(
                                      color: theme.scaffoldBackgroundColor,
                                    ),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 12),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: .all(16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: .circular(8),
                                      ),
                                      backgroundColor:
                                          theme.scaffoldBackgroundColor,
                                      foregroundColor: theme.primaryColor,
                                    ),
                                    onPressed: () {
                                      _launchUrl(
                                        cubit.articles?[index].url ?? '',
                                      );
                                    },
                                    child: Center(
                                      child: Text(
                                        'View Full Articel',
                                        style: theme.textTheme.titleSmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: .all(16),
                        decoration: BoxDecoration(
                          borderRadius: .circular(16),
                          border: Border.all(color: theme.primaryColor),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: .circular(16),
                              child: CachedNetworkImage(
                                imageUrl:
                                    cubit.articles![index].urlToImage ?? '',
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),

                              // Image.network(
                              //   provider.articles![index].urlToImage ??
                              //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRU8gBmgKJfyFettXPVl5na8uYWmmCTKGkdjVzNUyjJFg&s=10',
                              // ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              cubit.articles![index].title ?? '',
                              style: theme.textTheme.titleSmall,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    cubit.articles![index].author ?? '',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Text(
                                  cubit.articles![index].publishedAt!.substring(
                                    0,
                                    10,
                                  ),
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 16);
                  },
                  itemCount: cubit.articles!.length,
                ),
              );
            } else if (state is GetNewsErrorState) {
              return Center(
                child: Text(state.error, style: theme.textTheme.titleLarge),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }
}

Future<void> _launchUrl(String url) async {
  final Uri uri = Uri.parse(url);

  final bool success = await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  );

  if (!success) {
    debugPrint('Could not launch $url');
  }
}
