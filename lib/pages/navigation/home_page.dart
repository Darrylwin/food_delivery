import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_drawer.dart';
import 'package:food_delivery/components/my_food_tile.dart';
import 'package:food_delivery/components/my_sliver_app_bar.dart';
import 'package:food_delivery/components/my_tab_bar.dart';
import 'package:food_delivery/components/search_text_field.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/pages/food_page.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery/pages/navigation/message_page.dart';
import 'package:food_delivery/pages/navigation/profile_page.dart';

import '../../models/restaurant.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabsController;
  int _bottomNavBarIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  TextEditingController controller = TextEditingController();

  // Liste des pages
  final List<Widget> _pages = [
    const HomeContent(),
    const CartPage(),
    const ProfilePage(),
    const MessagePage(),
  ];

  @override
  void initState() {
    super.initState();
    _tabsController =
        TabController(length: FoodCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabsController.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const MyDrawer(),
      body: _pages[_bottomNavBarIndex],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        color: Colors.transparent,
        buttonBackgroundColor: Theme.of(context).colorScheme.surface,
        // color: Colors.transparent,
        backgroundColor: Colors.transparent,
        items: [
          Image.asset(
            'assets/icons/home.png',
            // color: Theme.of(context).colorScheme.primary,
            height: 25,
          ),
          Image.asset(
            'assets/icons/order.png',
            // color: Theme.of(context).colorScheme.primary,
            height: 25,
          ),
          Image.asset(
            'assets/icons/profil.png',
            // color: Theme.of(context).colorScheme.primary,
            height: 25,
          ),
          Image.asset(
            'assets/icons/message.png',
            // color: Theme.of(context).colorScheme.primary,
            height: 25,
          ),
        ],
        onTap: (index) {
          setState(() {
            _bottomNavBarIndex = index;
          });
        },
      ),
    );
  }
}

// Nouvelle classe pour le contenu de la page d'accueil
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabsController;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabsController =
        TabController(length: FoodCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabsController.dispose();
    super.dispose();
  }

  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  //return list of foods in this category
  List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);

      return GridView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final food = categoryMenu[index];
          return MyFoodTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodPage(food: food),
                ),
              );
            },
            food: food,
          );
        },
        itemCount: categoryMenu.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: -0,
          childAspectRatio:
              150 / 250, // This will make each child 150 wide and 250 high
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        MySliverAppBar(
          title: MyTabBar(tabsController: _tabsController),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // const SizedBox(height: 10),
              SearchTextField(
                controller: controller,
                sort: true,
              ),
            ],
          ),
        ),
      ],
      body: Consumer<Restaurant>(
        builder: (context, restaurant, child) => TabBarView(
          controller: _tabsController,
          children: getFoodInThisCategory(restaurant.menu),
        ),
      ),
    );
  }
}
