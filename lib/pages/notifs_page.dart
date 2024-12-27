import 'package:flutter/material.dart';
import '../components/search_text_field.dart';

class NotifsPage extends StatelessWidget {
  NotifsPage({super.key});
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        leading: Container(
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
          child: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 20,
            ),
            onTap: () {
              Navigator.pop(context);
            },
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
          child: const Center(
            child: Text('Null'),
          ),
        ),
      ),
    );
  }
}
