import 'package:flutter/material.dart';
import 'package:food_delivery/components/notification_tile.dart';
import 'package:food_delivery/models/my_notification.dart';
import 'package:provider/provider.dart';
import '../components/search_text_field.dart';

class NotifsPage extends StatefulWidget {
  const NotifsPage({super.key});

  @override
  State<NotifsPage> createState() => _NotifsPageState();
}

class _NotifsPageState extends State<NotifsPage> with RouteAware {
  TextEditingController controller = TextEditingController();

  @override
  void didPop() {
    context.read<NotificationProvider>().markAllAsRead();
    super.didPop();
  }

  @override
  void dispose() {
    context.read<NotificationProvider>().markAllAsRead();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
        builder: (context, NotificationProvider notification, child) {
      return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          surfaceTintColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
          title: const Text(
            'Notifications',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              context.read<NotificationProvider>().markAllAsRead();
              Navigator.pop(context);
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
                Icons.arrow_back_ios_new,
                size: 20,
              ),
            ),
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 64,
              collapsedHeight: 65,
              floating: false,
              pinned: true,
              shadowColor: Theme.of(context).scaffoldBackgroundColor,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              surfaceTintColor:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
              title: SearchTextField(
                controller: controller,
                sort: false,
              ),
            ),
          ],
          body: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: notification.notifications.isEmpty
                ? const Center(child: Text('Aucune Notification'))
                : ListView.builder(
                    itemCount: notification.notifications.length,
                    itemBuilder: (context, index) {
                      final notif = notification.notifications[index];
                      return NotificationTile(
                        title: notif.title,
                        description: notif.description,
                        time: notif.time,
                      );
                    },
                  ),
          ),
        ),
      );
    });
  }
}
