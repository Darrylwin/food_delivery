// food item
class Food {
  final String name;
  final String imagePath;
  final String description;
  final double price;
  final FoodCategory category;
  List<Addons> availableAddons;

  Food({
    required this.imagePath,
    required this.description,
    required this.price,
    required this.name,
    required this.availableAddons,
    required this.category,
  });
}

//food category
enum FoodCategory {
  burgers,
  pizza,
  pasta,
  salads,
  desserts,
  drinks,
}

//food addons
class Addons {
  String name;
  double price;

  Addons({
    required this.name,
    required this.price,
  });
}
