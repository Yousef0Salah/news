import 'package:news/core/const/assets.dart';

class AppCategoreis {
  final String id;
  final String name;
  final String image;

  AppCategoreis({required this.id, required this.name, required this.image});

  static List<AppCategoreis> categoreis = [
    AppCategoreis(id: 'general', name: 'General', image: Assets.general),
    AppCategoreis(id: 'business', name: 'Busniess', image: Assets.busniess),
    AppCategoreis(id: 'sports', name: 'Sport', image: Assets.sport),
    AppCategoreis(
      id: 'technology',
      name: 'Technology',
      image: Assets.technology,
    ),
    AppCategoreis(id: 'helth', name: 'Helth', image: Assets.helth),
    AppCategoreis(id: 'scienec', name: 'Scienec', image: Assets.scienec),
    AppCategoreis(
      id: 'entertainment',
      name: 'Entertainment',
      image: Assets.entertainment,
    ),
  ];
}
