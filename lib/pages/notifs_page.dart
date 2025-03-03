import 'package:flutter/material.dart';
import 'package:food_delivery/components/notification_tile.dart';
import 'package:food_delivery/models/my_notification.dart';
import 'package:provider/provider.dart';
import '../components/search_text_field.dart';

class NotifsPage extends StatelessWidget {
  NotifsPage({super.key});
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<MyNotification>(
        builder: (context, MyNotification notification, child) {

      return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text(
            'Notifications',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
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
              expandedHeight: 50,
              collapsedHeight: 57,
              floating: false,
              pinned: true,
              shadowColor: Colors.white,
              backgroundColor: Colors.white,
              foregroundColor: Colors.white,
              title: SearchTextField(
                controller: controller,
                sort: false,
              ),
            ),
          ],
          body: Container(
            color: Colors.white,
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
