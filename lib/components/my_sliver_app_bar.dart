import 'package:flutter/material.dart';
import 'package:food_delivery/models/my_notification.dart';
import 'package:food_delivery/pages/notifs_page.dart';
import 'package:provider/provider.dart';

class MySliverAppBar extends StatelessWidget {
  final Widget title;
  final Widget child;

  const MySliverAppBar({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 180,
      collapsedHeight: 100,
      floating: false,
      pinned: true,
      leading: GestureDetector(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(15),
            boxShadow: Theme.of(context).brightness == Brightness.light
                ? [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: const Icon(
            Icons.menu_rounded,
            size: 22.5,
          ),
        ),
      ),
      actions: [
        // notifs button
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotifsPage(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: Theme.of(context).brightness == Brightness.light
                  ? [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Consumer<MyNotification>(
              builder: (context, notificationProvider, child) => Badge(
                isLabelVisible: notificationProvider.notifications.isNotEmpty,
                label: Text('${notificationProvider.notifications.length}'),
                backgroundColor: Colors.red,
                child: Icon(
                  color: Theme.of(context).colorScheme.primary,
                  Icons.notifications_none_rounded,
                  size: 22.5,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      foregroundColor: Theme.of(context).primaryColor,
      title: const Text(
        "Popular menu",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: child,
        ),
        title: title,
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 0, top: 0),
        expandedTitleScale: 1,
      ),
    );
  }
}
